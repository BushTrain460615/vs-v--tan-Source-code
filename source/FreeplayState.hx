package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxSort;
import lime.app.Application;
import openfl.utils.Future;
import openfl.media.Sound;
import flixel.system.FlxSound;
#if sys
import smTools.SMFile;
import sys.FileSystem;
import sys.io.File;
#end
import Song.SwagSong;
import flash.text.TextField;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroupIterator;

import flixel.util.FlxTimer;
import io.newgrounds.NG;
import flixel.FlxState;
import flixel.animation.FlxBaseAnimation;

import sys.FileSystem;
import sys.io.File;
using StringTools;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	
	var curSelected:Int = 0;
	var camFollow:FlxObject;

	public var curDifficulty:Int=1;
	
    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/freeplay/menublue'));
	private var iconArray:Array<HealthIcon> = [];
	public var port:FlxSprite = new FlxSprite();
	public var diffs:FlxSprite = new FlxSprite();
	public var yotsuba:FlxSprite = new FlxSprite();
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	public var diffictext:String;
	var scoreText:FlxText;
	
	var header:Headers;
	  
	var selectedSong:FlxText;
	var debug:Bool;
	
	override function create()
	{
		super.create();
	    #if debug
		debug = true;
		#end
		
		
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('data/freeplaySonglist'));			
		for (i in 0...initSonglist.length)
			{
				var data:Array<String> = initSonglist[i].split(':');
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
			if(debug||FlxG.save.data.unlockBonus)
				songs.push(new SongMetadata("infinigger", Std.parseInt("8"), "cancer")); ///aaa
			
			scoreText = new FlxText("", 32);
			scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.BLUE, RIGHT);
			scoreText.setPosition(765,311);
			
			selectedSong = new FlxText("", 32);
			selectedSong.setFormat(Paths.font("score.ttf"), 32, FlxColor.fromRGB(17, 103, 7));
			selectedSong.setPosition(267,320);
			selectedSong.alignment = FlxTextAlign.CENTER;
			
			
					
			var ports = Paths.getSparrowAtlas('Menu/freeplay/ports');
					port.frames = ports;
					port.animation.addByPrefix('0',"week0port", 24, false);
					port.animation.addByPrefix('1',"week1port", 24, false);
					port.animation.addByPrefix('2',"week2port", 24, false);
					port.animation.addByPrefix('3',"week3port", 24, false);
					port.animation.addByPrefix('4',"week4port", 24, false);
					port.animation.addByPrefix('5',"week5port", 24, false);
					port.animation.addByPrefix('6',"week6port0", 24, false);
					port.animation.addByPrefix('7',"weekvport", 24, false);
					port.animation.addByPrefix('6alt',"week6port3", 24, false);
					port.animation.addByPrefix('5alt',"week5portalt", 24, false);
					port.animation.addByPrefix('8',"weekcanport", 24, false);
					port.animation.addByPrefix('2alt',"weekmonport", 24, false);
					
					port.scale.set(0.67,0.67);
					port.setPosition(562,383);
					
			var diff = Paths.getSparrowAtlas('Menu/diff/diff_blue');
					diffs.frames = diff;
					diffs.animation.addByPrefix('easy',"be", 24, false);
					diffs.animation.addByPrefix('normal',"bn", 24, false);
					diffs.animation.addByPrefix('hard',"bh", 24, false);
					diffs.animation.play('normal');
					diffs.scale.set(0.8,0.8);
					diffs.setPosition(750,335);
			
			
			var yo = Paths.getSparrowAtlas('Menu/freeplay/Yotsu');
				yotsuba.frames = yo;
				yotsuba.animation.addByPrefix('easy',"Ye", 24, false);
				yotsuba.animation.addByPrefix('normal',"Yn", 24, false);
				yotsuba.animation.addByPrefix('hard',"yh", 24, false);
				yotsuba.animation.play('normal');
				yotsuba.scale.set(0.68,0.68);
				yotsuba.setPosition(240,370);
	
				
				bg.screenCenter();
				
				
				
				add(bg);
				add(port);
                add(diffs);	
				add(scoreText);
			    add(yotsuba);
			    add(selectedSong);
				changeItem(0);
				changeDiff(1);
			
				diffictext='';
				var blue:FlxSprite = new FlxSprite(475,29).loadGraphic(Paths.image('Menu/headers/free'));
				header = new Headers(475, 32);
				add(header);
				add(blue);
			}

	var selectedSomethin:Bool = false;
	override function update(elapsed:Float)
	{	
		if (!selectedSomethin)
		{
			if (FlxG.keys.justPressed.E){changeDiff(0);diffictext='-easy';}
			if (FlxG.keys.justPressed.N){changeDiff(1);diffictext='';}
			if (FlxG.keys.justPressed.H){changeDiff(2);diffictext='-hard';}
			
		
			if (FlxG.keys.justPressed.LEFT)
			{			
				changeItem(-1);
				changeDiff(curDifficulty);
			}

			if (FlxG.keys.justPressed.RIGHT)
			{				
				changeItem(1);
				changeDiff(curDifficulty);
			}
			
		
			
			if (FlxG.keys.justPressed.ESCAPE)
			{
				  
				
				FlxG.switchState(new MainMenuState());
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				var songFormat = StringTools.replace(songs[curSelected].songName, " ", "-");
				switch (songFormat) {
					case 'Dad-Battle': songFormat = 'Dadbattle';
					case 'Philly-Nice': songFormat = 'Philly';
		            case 'Sage':songFormat= 'sage';
					case 'Vidyagaems':songFormat= 'vidyagaems';
					case 'Harmony':songFormat= 'harmony';		
				}
						
				var songcheck = StringTools.replace(songs[curSelected].songName, " ", "-"); ////UUNNNHGGGGGG
				switch (songcheck) {
					case 'Dad-Battle': songcheck = 'dadbattle';
					case 'Philly-Nice': songcheck = 'philly';
					case 'Satin-Panties': songcheck = 'satin-panties';
					case 'Winter-Horrorland': songcheck = 'winter-horrorland';
					case 'Tutorial': songcheck = 'tutorial';
					case 'Bopeebo': songcheck = 'bopeebo';
					case 'Fresh': songcheck = 'fresh';
					case 'Spookeez': songcheck = 'spookeez';
					case 'South': songcheck = 'south';
					case 'Monster': songcheck = 'monster';
					case 'Pico': songcheck = 'pico';
					case 'Blammed': songcheck = 'blammed';
					case 'High': songcheck = 'high';
					case 'Milf': songcheck = 'milf';
					case 'Cocoa': songcheck = 'cocoa';
					case 'Eggnog': songcheck = 'eggnog';
					case 'Senpai': songcheck = 'senpai';
					case 'Roses': songcheck = 'roses';
					case 'Thorns': songcheck = 'thorns';
					case 'Sage':songcheck= 'sage';
					case 'Vidyagaems':songcheck= 'vidyagaems';
					case 'Harmony':songcheck= 'harmony';	
				}
				
			
				
				if(sys.FileSystem.exists('assets/data/'+ songcheck +'/'+ songcheck + diffictext + '.json'))
					{
						var poop:String = Highscore.formatSong(songFormat, curDifficulty);		
						PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName);
						PlayState.isSM = false;
						PlayState.isStoryMode = false;
						PlayState.storyDifficulty = curDifficulty;
						PlayState.storyWeek = songs[curSelected].week;
						LoadingState.loadAndSwitchState(new PlayState());}
				else
					{FlxG.switchState(new MissingState(true));}
            }
        }
    }

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
		{
			songs.push(new SongMetadata(songName, weekNum, songCharacter));
		}
	
	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
		{
			if (songCharacters == null)
				songCharacters = ['dad'];
	
			var num:Int = 0;
			for (song in songs)
			{
				addSong(song, weekNum, songCharacters[num]);
	
				if (songCharacters.length != 1)
					num++;
			}
		}
	
		function changeItem(change:Int = 0)
		{	
			//selectedSong.setPosition(275,320);			
			//FlxTween.tween(selectedSong, { x: 267, y: 320 }, 0.4);
			
			curSelected += change;
			if (curSelected < 0)
				curSelected = songs.length - 1;
			if (curSelected >= songs.length)
				curSelected = 0;
			FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName));	
			FlxG.sound.play(Paths.sound('scrollMenu'),false);
			
			switch(curSelected)
			{           
				case 0 : port.animation.play('0');
				case 1 : port.animation.play('1');
				case 2 : port.animation.play('1');
				case 3 : port.animation.play('1');
				case 4 : port.animation.play('2');
				case 5 : port.animation.play('2');
				case 6 : port.animation.play('2alt');
				case 7 : port.animation.play('3');
				case 8 : port.animation.play('3');
				case 9 : port.animation.play('3');
				case 10 : port.animation.play('4');
				case 11 : port.animation.play('4');
				case 12 : port.animation.play('4');
				case 13 : port.animation.play('5');
				case 14 : port.animation.play('5');
				case 15 : port.animation.play('5alt');
				case 16 : port.animation.play('6');
				case 17 : port.animation.play('6');
				case 18 : port.animation.play('6alt');
				case 19 : port.animation.play('7');
				case 20 : port.animation.play('7');
				case 21 : port.animation.play('7');
				case 22 : port.animation.play('8');
			}
			
			var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
				case 'Sage':songHighscore= 'sage';
				case 'Vidyagaems':songHighscore= 'vidyagaems';
				case 'Harmony':songHighscore= 'harmony';
			}		
			
			intendedScore = Highscore.getScore(songHighscore, curDifficulty);			
			
			selectedSong.text=""+ songs[curSelected].songName;
			
		}
		
		function changeDiff(D:Int)
			{
				curDifficulty = D;		
				switch(D)
				{
					case 0 :diffs.animation.play('easy'); yotsuba.animation.play('easy');
					case 1 :diffs.animation.play('normal'); yotsuba.animation.play('normal');
					case 2 :diffs.animation.play('hard'); yotsuba.animation.play('hard');
				}			
				
				var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
				switch (songHighscore) 
				{
					case 'Dad-Battle': songHighscore = 'Dadbattle';
					case 'Philly-Nice': songHighscore = 'Philly';
					case 'Sage':songHighscore= 'sage';
					case 'Vidyagaems':songHighscore= 'vidyagaems';
					case 'Harmony':songHighscore= 'harmony';
				
				}
				intendedScore = Highscore.getScore(songHighscore, curDifficulty);					
			
				scoreText.text = "" + intendedScore;
			}	
			



}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	#if sys
	public var sm:SMFile;
	public var path:String;
	#end
	public var songCharacter:String = "";

	public var diffs = [];

	#if sys
	public function new(song:String, week:Int, songCharacter:String, ?sm:SMFile = null, ?path:String = "")
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.sm = sm;
		this.path = path;
	}
	#else
	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
	#end
}
