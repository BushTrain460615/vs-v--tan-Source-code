package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxObject;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.effects.FlxFlicker;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import io.newgrounds.NG;
import flixel.math.FlxMath;
import lime.app.Application;


using StringTools;

/////////////////////// GARBAGE CODE WILL REDO WITH GRANDPA DEATH///////////////////////////////////


class MainMenuState extends MusicBeatState
{
	
	public static var nightly:String = "";
	public static var kadeEngineVer:String = "1.6.1" + nightly;
	public static var gameVer:String = "0.2.7.1";

	////weeks 
    var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Bopeebo', 'Fresh', 'Dadbattle'],
		['Spookeez', 'South', "Monster"],
		['Pico', 'Philly', "Blammed"],
		['Satin-Panties', "High", "Milf"],
		['Cocoa', 'Eggnog', 'Winter-Horrorland'],
		['Senpai', 'Roses', 'Thorns'],
		['vidyagaems','sage','harmony'],
	    ['infinigger'],['nogames']
	];
	var music:FlxSound;
	///non buttons
	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/menu'));
	///button side images 
    var portsB:FlxSprite = new FlxSprite();
    ///button sprites
	var freeplayB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/freeplay'));   
	var optionsB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/options')); 
	var comicsB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/comics')); 
	var week1B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week1'));
	var week2B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week2'));
	var week3B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week3'));
	var week4B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week4'));
	var week5B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week5'));
	var week6B:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/week6'));
	var vB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/v'));
	var gdB:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Menu/mainmenu/buttons/GD'));
	var bonusButton:FlxSprite = new FlxSprite();
	var freeplay:Bool;
	var options:Bool;
	var comics:Bool; 
	var week1:Bool;
	var week2:Bool;
	var week3:Bool;
	var week4:Bool;
	var week5:Bool;
	var week6:Bool;
	var bonus:Bool;
	var v:Bool;
	var gd:Bool;
	var diffs:FlxSprite = new FlxSprite();
	var diffic:String;

	var note:FlxSprite = new FlxSprite(900,415).loadGraphic(Paths.image('Menu/mainmenu/NOTE'));
	var score:FlxText;
	var intendedScore:Int;
	var CD:Int;
	
	var missing:Bool;
	var debug:Bool = false;
	
	var _noGames:FlxText;
	var noGames:Bool;
      var header:Headers;
	  
	
	override public function create()
		{
			super.create();
			
			
			#if debug
			debug = true;
			#end
			
			var bBonus = Paths.getSparrowAtlas('Menu/mainmenu/bonus/bonus');
			bonusButton.frames=bBonus;
			bonusButton.animation.addByPrefix('idle',"Bonus-idle", 24);
			bonusButton.animation.addByPrefix('selected',"Bonus-selected", 24);//they are reversed??? what the fuck
			bonusButton.animation.play('idle');
			bonusButton.setPosition(500,175);
			
		
			
			if (!FlxG.sound.music.playing)
				{
					FlxG.sound.playMusic(Paths.music('breakfast'));
				}
				
			score = new FlxText(FlxG.width * 0.2, "");
			score.setFormat(Paths.font("vcr.ttf"), 25, FlxColor.BLUE, RIGHT);
			score.setPosition(355,621);
			
			var diff = Paths.getSparrowAtlas('Menu/diff/diff');
					diffs.frames = diff;
					diffs.animation.addByPrefix('easy',"de", 24, false);
					diffs.animation.addByPrefix('normal',"dn", 24, false);
					diffs.animation.addByPrefix('hard',"dh", 24, false);
					diffs.scale.set(0.6,0.6);
					diffs.setPosition(800,609);
							
			
			
			var images = Paths.getSparrowAtlas('Menu/mainmenu/side2');
					portsB.frames = images;
					portsB.animation.addByPrefix('week1',"w1", 24, false);
					portsB.animation.addByPrefix('week2',"w2", 24, false);
					portsB.animation.addByPrefix('week3',"w3", 24, false);
					portsB.animation.addByPrefix('week4',"w4", 24, false);
					portsB.animation.addByPrefix('week5',"w5", 24, false);
					portsB.animation.addByPrefix('week6',"w6", 24, false);
					portsB.animation.addByPrefix('v',"wv", 24, false);
					portsB.animation.addByPrefix('gd',"gd", 24, false);
					portsB.animation.addByPrefix('options',"op", 24, false);
					portsB.animation.addByPrefix('freeplay',"fp", 24, false);
					portsB.animation.addByPrefix('comics',"co", 24, false);
					portsB.setPosition(575,400);
					
		
			week1B.y = vB.y= 295;
			week2B.y = gdB.y = week1B.y+30;
			week3B.y = week2B.y+30;
			week4B.y =freeplayB.y= week3B.y+30;
			week5B.y = optionsB.y= week4B.y+30;
			week6B.y = comicsB.y = week5B.y+30;
			bg.screenCenter();

			freeplayB.scale.set(0.45,0.45);/// made them in 1980p kill meee
			optionsB.scale.set(0.45,0.45); ///should've used TEXT! 
			comicsB.scale.set(0.45,0.45);
			week1B.scale.set(0.45,0.45);
			week2B.scale.set(0.45,0.45);
			week3B.scale.set(0.45,0.45);
			week4B.scale.set(0.45,0.45);
			week5B.scale.set(0.45,0.45);
			week6B.scale.set(0.45,0.45);
			vB.scale.set(0.45,0.45);
			gdB.scale.set(0.45,0.45);
			bonusButton.scale.set(0.7,0.7);
			note.scale.set(0.55,0.55);

			add(bg);
			add(note);	
			add(week1B);
			add(week2B);
			add(week3B);
			add(week4B);
			add(week5B);
			add(week6B);
			add(vB);
			add(gdB);
			add(freeplayB);
			add(optionsB);
			add(comicsB);
			add(diffs);
			add(portsB);
			add(score);
			
			_noGames = new FlxText("NoGames");
			_noGames.setFormat(Paths.font("score.ttf"), 23, FlxColor.fromRGB(97, 14, 14));
			_noGames.setPosition(460,week6B.y+70);
			
			
			if(debug||FlxG.save.data.nogames)
				add(_noGames);	


			if(debug||FlxG.save.data.unlockBonus)
				add(bonusButton);			
			
			freeplay = true;
			options = comics = week1 = week2 = week3 = week4 = week5 = week6 = v = gd =  bonus = false;
			
			diffic="";CD=1;		
			diffs.animation.play('normal');			
		
			var red:FlxSprite = new FlxSprite(475,29).loadGraphic(Paths.image('Menu/headers/main'));
			header = new Headers(475, 32);
			add(header);
			add(red);
		}
	
		override public function update(elapsed:Float)
		{
			super.update(elapsed);
			
			if(FlxG.keys.justPressed.V)
				openSubState(new ThankSubstate());
			
		
			
			
			if(FlxG.keys.justPressed.NUMPADFOUR)
				remove(note);
			if(FlxG.keys.justPressed.NUMPADSEVEN)
				add(note);
			if(FlxG.keys.justPressed.ESCAPE)
				FlxG.switchState(new TitleState());
			if (FlxG.keys.justPressed.N) 
				{diffs.animation.play('normal');diffic="";CD=1;}
			else if (FlxG.keys.justPressed.E) 
				{diffs.animation.play('easy');diffic="-easy";CD=0;}
			else if (FlxG.keys.justPressed.H) 
				{diffs.animation.play('hard');diffic="-hard";CD=2;}
		
			if (week1 == false)
				week1B.x = 230;
			if (week2 == false)
				week2B.x = 230;
			if (week3 == false)
				week3B.x = 230;
			if (week4 == false)
				week4B.x = 230;
			if (week5 == false)
				week5B.x = 230;
			if (week6 == false)
				week6B.x = 230;
			if (v == false)
				vB.x = 445;
			if (gd == false)
				gdB.x = 310;
			if (freeplay == false)
				freeplayB.x = 390;
			if (options == false)
				optionsB.x = 390;
			if (comics == false)
				comicsB.x = 365;
		    if (bonus == true)
				bonusButton.animation.play('selected');
			else
				bonusButton.animation.play('idle');
			if(noGames == false)
				_noGames.color=FlxColor.fromRGB(97, 14, 14);
				
			
			if (freeplay == true)
				{
					portsB.setPosition(630,80);portsB.scale.set(0.35,0.35);portsB.animation.play('freeplay');freeplayB.x = 405;
					score.text = "N/a";
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = false;
						options = true;
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = false;
						gd = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = false;
						week4 = true;
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = false;
						week4 = true;
					}
					if(FlxG.keys.justPressed.ENTER)				
						FlxG.switchState(new FreeplayState());
						
				}	
			else if (options == true)
				{
					portsB.setPosition(640,80);portsB.scale.set(0.3,0.3);portsB.animation.play('options');optionsB.x = 405;
					score.text = "N/a";
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = options = false;			
						comics = true;
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = true;
						options = false;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = options = false;				
						week5 = true;
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = options = false;					
						week5 = true;
					}
					if(FlxG.keys.justPressed.ENTER)
					
						FlxG.switchState(new OptionsMenu());
					
				}
			else if (comics == true)
				{
					portsB.setPosition(635,80);portsB.scale.set(0.3,0.3);portsB.animation.play('comics');comicsB.x = 380;
					score.text = "N/a";
					
					if (FlxG.keys.justPressed.DOWN)
						{
							
						
							if(debug||FlxG.save.data.nogames)
								{
									freeplay = comics = false;	
									noGames = true;						
								}
								
							 else
								 {						
									freeplay = comics = false;										
									v = true;
								}								
						
						}
					if (FlxG.keys.justPressed.UP)
						{
							freeplay = comics = false;
							options = true;							
						}
					if (FlxG.keys.justPressed.LEFT)
						{
							freeplay = comics = false;							
							week6 = true;
						}
					if (FlxG.keys.justPressed.RIGHT)
						{
							freeplay = comics = false;
							week6 = true;
						}				
					if(FlxG.keys.justPressed.ENTER)					
							FlxG.openURL('https://imgur.com/a/ce8YEtV');
								
				}
			else if (week1 == true)
				{
					portsB.setPosition(650,80);portsB.scale.set(0.35,0.35);portsB.animation.play('week1');week1B.x = 245;
				
					scoreText(1,CD);
					
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = week1 = false;				
						week2 = true;
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = week1 = false;					
						week6 = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						if(debug||FlxG.save.data.unlockBonus)
						{
						 freeplay = week1 = false;					
						 bonus = true;
						}
				     else
				     	{
						freeplay = week1 = false;					
						v = true;
			     		}
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = week1 = false;						
						v = true;
					}
					if(FlxG.keys.justPressed.ENTER)
					{	if(sys.FileSystem.exists('assets/missingW1.txt')) //stupid way to check on the weeks,freeplay has a better way to check  
							FlxG.switchState(new MissingState(false));
						else 	 weekselected(1,CD,diffic);}
				}
			else if (week2 == true)
				{
					portsB.setPosition(630,100);portsB.scale.set(0.4,0.4);portsB.animation.play('week2');week2B.x = 245;
					scoreText(2,CD);
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = week2 = false;		
						week3 = true;
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = week2 = false;		
						week1 = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = week2 = false;		
						gd = true;
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
							freeplay = week2 = false;
							gd = true;
					}
					if(FlxG.keys.justPressed.ENTER)						
						{if(sys.FileSystem.exists('assets/missingW2.txt'))
							FlxG.switchState(new MissingState(false));
						else 	weekselected(2,CD,diffic);	}				
				}
			else if (week3 == true)
				{		
					portsB.setPosition(755,270);portsB.scale.set(1,1);portsB.animation.play('week3');week3B.x = 245;
					scoreText(3,CD);
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = week3 = false;					
						week4 = true;
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = week3 = false;					
						week2 = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = true;
						week3 = false;
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = true;
						week3 = false;
					}
					if(FlxG.keys.justPressed.ENTER)					
					{	if(sys.FileSystem.exists('assets/missingW3.txt'))
							FlxG.switchState(new MissingState(false));
						else 	weekselected(3,CD,diffic);			}					
				}
			else if (week4 == true)
				{
					portsB.setPosition(735,150);portsB.scale.set(0.7,0.7);portsB.animation.play('week4');week4B.x = 245;
					scoreText(4,CD);
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = 	week4 = false;	
						week5 = true;	
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = week4 = false;								
						week3 = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = true;
						week4 = false;
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = true;
						week4 = false;
					}
					if(FlxG.keys.justPressed.ENTER)
						{if(sys.FileSystem.exists('assets/missingW4.txt'))
							FlxG.switchState(new MissingState(false));
						else 						
						weekselected(4,CD,diffic);		}					
						
				}
			else if (week5 == true)
				{
					portsB.setPosition(595,75);portsB.scale.set(0.25,0.25);portsB.animation.play('week5');week5B.x = 245;
					scoreText(5,CD);
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = week5 = false;		
						week6 = true;
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = 	week5 = false;			
						week4 = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = week5 = false;
						options = true;					
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = week5 = false;
						options = true;				
					}
					if(FlxG.keys.justPressed.ENTER)
						{if(sys.FileSystem.exists('assets/missingW5.txt'))
							FlxG.switchState(new MissingState(false));
						else 
							weekselected(5,CD,diffic);}
						
					
				}
			else if (week6 == true)
				{
					
					portsB.setPosition(670,160);portsB.scale.set(0.6,0.6);portsB.animation.play('week6');week6B.x = 245;
					scoreText(6,CD);
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = week6 = false;
						week1 = true;	
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = week6 = false;
						week5 = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = week6 = false;
						comics = true;						
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = week6 = false;
						comics = true;						
					}
					if(FlxG.keys.justPressed.ENTER)
						
					{	if(sys.FileSystem.exists('assets/missingW6.txt'))
							FlxG.switchState(new MissingState(false));
						else 
							weekselected(6,CD,diffic);}
							
				}
			else if (v == true)
				{ 
					portsB.setPosition(690,150);portsB.scale.set(0.55,0.55);portsB.animation.play('v');vB.x = 460;
			        scoreText(7,CD);
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = v = false;									
						gd = true;	
					}
					if (FlxG.keys.justPressed.UP)
					{
						if(debug||FlxG.save.data.nogames)
							{
								freeplay = 	v = false;
								noGames = true;									
				        	}
							
						 else
							 {						
								freeplay = v = false;										
								comics = true;
							}									
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = 	v = false;
						week1 = true;								
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						if(debug||FlxG.save.data.unlockBonus)
							{
								freeplay = 	v = false;
									bonus = true;									
				        	}
							
						 else
							 {						
								freeplay = 	v = false;
								week1 = true;
							}								
					}
					if(FlxG.keys.justPressed.ENTER)
						
							weekselected(7,CD,diffic);
										
				}
			else if (gd == true)
				{
					portsB.setPosition(645,40);portsB.scale.set(0.25,0.25);portsB.animation.play('gd');gdB.x = 325;
	
					if (FlxG.keys.justPressed.DOWN)
					{
						freeplay = true;
						gd = false;	
					}
					if (FlxG.keys.justPressed.UP)
					{
						freeplay = gd = false;
						v = true;
					}
					if (FlxG.keys.justPressed.LEFT)
					{
						freeplay = gd = false;
						week1 = true;						
					}
					if (FlxG.keys.justPressed.RIGHT)
					{
						freeplay = gd = false;
						week1 = true;
					}
					if(FlxG.keys.justPressed.ENTER){}						
				}
				else if (bonus == true)
					{
						scoreText(8,CD);
						if (FlxG.keys.justPressed.LEFT)
						{
							freeplay = bonus = false;
							v = true;						
						}
						if (FlxG.keys.justPressed.RIGHT)
						{
							freeplay = bonus = false;
							week1 = true;
						}
						if(FlxG.keys.justPressed.ENTER){weekselected(8,CD,diffic);}						
					}
				
				else if (noGames == true)
					{
						_noGames.color = FlxColor.BLUE;
						scoreText(9,CD);
						if (FlxG.keys.justPressed.UP)
						{
							freeplay = noGames = false;
							comics = true;						
						}
						if (FlxG.keys.justPressed.DOWN)
						{
							freeplay = noGames = false;
							v = true;
						}
						if(FlxG.keys.justPressed.ENTER){weekselected(9,CD,diffic);}						
					}
	
		
			}
		
		public function weekselected(i:Int,CD,diffic):Void
			{
				if(bonus == true && CD == 1||bonus == true && CD == 0 ||noGames == true && CD == 1||noGames == true && CD == 0 )
				{FlxG.switchState(new Urafaggot());}
				else
				{
					
							FlxG.sound.music.stop();// bits of the music kept playing even after switching to video state  					
							PlayState.storyPlaylist = weekData[i];
							PlayState.isStoryMode = true;
							PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
							PlayState.sicks = 0;
							PlayState.bads = 0;
							PlayState.shits = 0;
							PlayState.goods = 0;
							PlayState.campaignMisses = 0;
							PlayState.storyWeek = i;
							PlayState.campaignScore = 0;
							PlayState.storyDifficulty = CD;																			
							if(v==true){LoadingState.loadAndSwitchState(new VideoState("assets/videos/v_intro.webm", new PlayState()));}
							else if (bonus== true ){LoadingState.loadAndSwitchState(new VideoState("assets/videos/cancer_intro.webm", new PlayState()));}
							else{LoadingState.loadAndSwitchState(new PlayState(), true);}
							
						
			    }
		}
		public function scoreText(a:Int,CD):Void
			{
				intendedScore = Highscore.getWeekScore(a, CD);
				intendedScore = Math.floor(intendedScore);
				score.text = "" + intendedScore;
			}




}