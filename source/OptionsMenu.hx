package;

import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Lib;
import Controls.Control;
import lime.app.Application;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxObject;
import flixel.tweens.FlxEase;

class OptionsMenu extends MusicBeatState
{
	 
	
	
/////garbage code just to get this out 
	
	
	
	 var keyBin:Bool=true;
	 var offSet:Bool=false;
	 var scrollType:Bool=false;
	 var scrollSpeed:Bool=false;
	 var ghostTapping:Bool=false;
	 var showFps:Bool=false;
	 var songPos:Bool=false;
	 var safeFrames:Bool=false;
	 var accuracyType:Bool=false;
	 var restartR:Bool=false;
	 var fpsCap:Bool=false;
	 var hideSlurs:Bool=false;
	 var cacheImages:Bool=false;
	 var customizeGameplay:Bool=false;
	 var charterGrid:Bool=false;
	

	
	
	
	 var _keyBin:FlxText;
	 var _offSet:FlxText;
	 var _scrollType:FlxText;
	 var _scrollSpeed:FlxText;
	 var _ghostTapping:FlxText;
	 var _showFps:FlxText;
	 var _songPos:FlxText;
	 var _safeFrames:FlxText;
	 var _accuracyType:FlxText;
	 var _restartR:FlxText;
	 var _fpsCap:FlxText;
	 var _hideSlurs:FlxText;
	 var _cacheImages:FlxText;
	 var _customizeGameplay:FlxText;
	 var _charterGrid:FlxText;

	 var baseX:Int=60;
	 var baseY:Int=242;
	 var newX:Int=75;
	 var yFollow:FlxObject;
	
	public static var acceptInput:Bool = true;
	
	public var disc:FlxText;
	var header:Headers;
	  
	override function create()
	{
		super.create();
		
		if (!FlxG.sound.music.playing)
			{
				FlxG.sound.playMusic(Paths.music('breakfast'));
			}
		
		var bg:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Menu/options/bg'));
		
		var bg2:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Menu/options/bg2'));
		add(bg2);
	   ///options text
	   
	 
	
	 
	 
	   _keyBin = new FlxText("Key bindings.");
		_offSet = new FlxText("Offset.");
		_scrollType = new FlxText("Scroll type.");
		_scrollSpeed = new FlxText("Scroll speed.");
		_ghostTapping = new FlxText("Ghost tapping.");
		_showFps = new FlxText("Show FPS.");
		_songPos = new FlxText("Song position.");	
		_safeFrames = new FlxText("Safe frames.");	
		_accuracyType = new FlxText("Accuracy type.");	
		_restartR = new FlxText("Restart pressing R.");	
		_fpsCap = new FlxText("FPS Cap.");	
		_hideSlurs = new FlxText("Hide slurs.");	
		_cacheImages = new FlxText("Cache.");	
		_customizeGameplay = new FlxText("Customize Hud.");	
		_charterGrid = new FlxText("Charter grid.");	
	
		///format
		_keyBin.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_offSet.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_scrollType.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_scrollSpeed.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_ghostTapping.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_showFps.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_songPos.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_safeFrames.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_accuracyType.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_restartR.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_fpsCap.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_hideSlurs.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_cacheImages.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_customizeGameplay.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
		_charterGrid.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(66, 26, 82));
	
		///disc
	     disc = new FlxText("This is a test text lol");
		 disc.setFormat(Paths.font("score.ttf"), 25, FlxColor.fromRGB(82, 41, 26));
		 disc.setPosition(380,629);
         //adding everyhing
		 add(_keyBin);
		 add(_offSet);
		 add(_scrollType);
		 add(_scrollSpeed);
		 add(_ghostTapping);
		 add(_showFps);
		 add(_songPos);
		 
		 add(_safeFrames);
         add(_accuracyType);
		 add(_restartR);
		 add(_fpsCap);
		 add(_hideSlurs);
		 add(_cacheImages);
		 add(_customizeGameplay);
		 add(_charterGrid);
		
		
		 add(bg);
		 
		 var prup:FlxSprite = new FlxSprite(475,29).loadGraphic(Paths.image('Menu/headers/ops'));
		 header = new Headers(475, 32);
		 add(header);
		 add(prup);
		 yFollow = new FlxObject(baseX, baseY, 1, 1);
		 add(disc);
	
	
		 resetX();
		 moveY();			
		 options();
	}

	

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (acceptInput)
			{
				
				
				
				if(FlxG.keys.justPressed.ESCAPE)
					{				
						if(FlxG.save.data.slurs)	
							FlxG.switchState(new NiggerState());// get fucked lmao
						else
						FlxG.switchState(new MainMenuState());
					}
				
					resetX();
					moveY();			//this is bad		
					options();
			
			
			}
					
			FlxG.save.flush();
	
	
	
	
	}

   function moveY():Void
	{
	
		
		_keyBin.setPosition(yFollow.x,yFollow.y);
		_offSet.setPosition(yFollow.x,yFollow.y+35);
		_scrollType.setPosition(yFollow.x,yFollow.y+70);
		_scrollSpeed.setPosition(yFollow.x,yFollow.y+105);
		_ghostTapping.setPosition(yFollow.x,yFollow.y+140);
		_showFps.setPosition(yFollow.x,yFollow.y+175);
		_songPos.setPosition(yFollow.x,yFollow.y+210);//aaaaa
		_safeFrames.setPosition(yFollow.x,yFollow.y+245);
		_accuracyType.setPosition(yFollow.x,yFollow.y+280);
		_restartR.setPosition(yFollow.x,yFollow.y+315);
		_fpsCap.setPosition(yFollow.x,yFollow.y+350);
		_hideSlurs.setPosition(yFollow.x,yFollow.y+385);
		_cacheImages.setPosition(yFollow.x,yFollow.y+420);
		_customizeGameplay.setPosition(yFollow.x,yFollow.y+455);
		_charterGrid.setPosition(yFollow.x,yFollow.y+490);

		
		
		if(keyBin==true|| offSet==true|| showFps==true||scrollType==true||scrollSpeed==true || ghostTapping==true||songPos==true || safeFrames==true|| keyBin==true||  accuracyType==true||fpsCap==true  ||hideSlurs==true)
			yFollow.y=baseY;
		else if(cacheImages==true)
			yFollow.y=207;
		else if(customizeGameplay==true)
			yFollow.y=172;
		else if(charterGrid==true)
			yFollow.y=137;
	}
    function resetX():Void
		{
			if(keyBin==false)
				_keyBin.x=baseX;
			if(offSet==false)
				_offSet.x=baseX;
			if(scrollType==false)
				_scrollType.x=baseX;
			if(scrollSpeed==false)
				_scrollSpeed.x=baseX;
			if(ghostTapping==false)
				_ghostTapping.x=baseX;
			if(showFps==false)
				_showFps.x=baseX;
			if(songPos==false)
				_songPos.x=baseX;
			if(safeFrames==false)
				_safeFrames.x=baseX;
			if(accuracyType==false)
				_accuracyType.x=baseX;
			if(restartR==false)
				_restartR.x=baseX;
			if(fpsCap==false)
				_fpsCap.x=baseX;
			if(hideSlurs==false)
				_hideSlurs.x=baseX;
			if(cacheImages==false)
				_cacheImages.x=baseX;
			if(customizeGameplay==false)
				_customizeGameplay.x=baseX;
			if(charterGrid==true)
				_charterGrid.x=baseX;
			
		}
	function options(): Void
		{
			if(keyBin == true)/// should use switch case, oh well
				{
					_keyBin.x=newX;
					disc.text="Change input keys.";
					
					if (FlxG.keys.justPressed.ENTER)
						{
						openSubState(new KeyBindMenu());
						}
					if (FlxG.keys.justPressed.UP)
						{
							charterGrid = true;
							keyBin = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{						
							offSet = true;
							keyBin = false;
						}
				}
			else if(offSet== true)
				{
					_offSet.x=newX;
								
					if (FlxG.keys.justPressed.RIGHT)
						FlxG.save.data.offset += 0.1;
					if (FlxG.keys.justPressed.LEFT)
						FlxG.save.data.offset -= 0.1;
					if (FlxG.keys.justPressed.R)
						FlxG.save.data.offset = 0;

					disc.text="Intput offset : "+ HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + '- Press R to reset';

					if (FlxG.keys.justPressed.UP)
						{
							keyBin = true;
							offSet = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{
							scrollType = true;
							offSet = false;
						}
				}
			else if(scrollType== true)
				{
					_scrollType.x=newX;
				
					if (FlxG.keys.justPressed.ENTER)
						{
							FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
							
						}
					if (FlxG.keys.justPressed.UP)
						{
							offSet = true;
							scrollType = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{
							scrollSpeed = true;
							scrollType = false;
						}
				
						FlxG.save.data.downscroll ? disc.text="Scroll type : Down" : disc.text="Scroll type : UP";
				}
			else if(scrollSpeed== true)
				{
					_scrollSpeed.x=newX;
											
					if (FlxG.keys.justPressed.LEFT)
						{
							FlxG.save.data.scrollSpeed -= 0.1;

							if (FlxG.save.data.scrollSpeed < 1)
								FlxG.save.data.scrollSpeed = 1;
					
							if (FlxG.save.data.scrollSpeed > 4)
								FlxG.save.data.scrollSpeed = 4;
					
						}
					if (FlxG.keys.justPressed.RIGHT)
						{
							FlxG.save.data.scrollSpeed += 0.1;

							if (FlxG.save.data.scrollSpeed < 1)
								FlxG.save.data.scrollSpeed = 1;
					
							if (FlxG.save.data.scrollSpeed > 4)
								FlxG.save.data.scrollSpeed = 4;
						
						}
					disc.text="Scroll speed : " + HelperFunctions.truncateFloat(FlxG.save.data.scrollSpeed,1);
					
					if (FlxG.keys.justPressed.UP)
						{
							scrollType = true;
							scrollSpeed = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{
							ghostTapping = true;
							scrollSpeed = false;
						}	
				}
			else if(ghostTapping== true)
				{
					_ghostTapping.x=newX;
					
					if (FlxG.keys.justPressed.ENTER)
						{
							FlxG.save.data.ghost = !FlxG.save.data.ghost;
							
						}
					if (FlxG.keys.justPressed.UP)
						{
							scrollSpeed = true;
							ghostTapping = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{
							showFps = true;
							ghostTapping = false;
						}
						FlxG.save.data.ghost ? disc.text="Safe input in empty sections : ON" : disc.text="Safe input in empty sections : OFF";
					}
			else if(showFps== true)
				{
					_showFps.x=newX;
					
					if (FlxG.keys.justPressed.ENTER)
						{
							FlxG.save.data.fps = !FlxG.save.data.fps;
							(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
							
						}
					if (FlxG.keys.justPressed.UP)
						{
							ghostTapping = true;
							showFps = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{
							songPos = true;
							showFps = false;
						}
						!FlxG.save.data.fps ? disc.text="Display FPS counter : OFF" : disc.text="Display FPS counter : ON";
					}
			else if(songPos== true)
				{
					_songPos.x=newX;
					
					if (FlxG.keys.justPressed.ENTER)
						{
							FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
							
						}
					if (FlxG.keys.justPressed.UP)
						{
							showFps = true;
							songPos = false;
						}
					if (FlxG.keys.justPressed.DOWN)
						{
							safeFrames = true;
							songPos = false;
						}
				
						!FlxG.save.data.songPosition ? disc.text="Bar showing the length of the song : OFF" :disc.text="Bar showing the length of the song : ON ";								
					}
					else if(safeFrames== true)
						{
							_safeFrames.x=newX;
							
							if (FlxG.keys.justPressed.LEFT)
								{	
									Conductor.safeFrames -= 1;
									FlxG.save.data.frames = Conductor.safeFrames;								
									Conductor.recalculateTimings();										
								}
							if (FlxG.keys.justPressed.RIGHT)
								{								
									Conductor.safeFrames += 1;
									FlxG.save.data.frames = Conductor.safeFrames;								
									Conductor.recalculateTimings();									
								}
							if (FlxG.keys.justPressed.UP)
								{
									songPos = true;
									safeFrames = false;
								}
							if (FlxG.keys.justPressed.DOWN)
								{
									accuracyType = true;
									safeFrames = false;
								}
								disc.text = "Ratings:" + Conductor.safeFrames +
								"|SK:" + HelperFunctions.truncateFloat(45 * Conductor.timeScale, 0) +
								"ms|GD:" + HelperFunctions.truncateFloat(90 * Conductor.timeScale, 0) +
								"ms|BD:" + HelperFunctions.truncateFloat(135 * Conductor.timeScale, 0) + 
								"ms|ST:" + HelperFunctions.truncateFloat(166 * Conductor.timeScale, 0) +
								"ms|All:" + HelperFunctions.truncateFloat(Conductor.safeZoneOffset,0)+"ms";
								
							}

						else if(accuracyType== true)
							{
								_accuracyType.x=newX;
								
								if (FlxG.keys.justPressed.ENTER)
									{
										FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;			
									}
								if (FlxG.keys.justPressed.UP)
									{
										safeFrames = true;
										accuracyType = false;
									}
								if (FlxG.keys.justPressed.DOWN)
									{
										restartR = true;
										accuracyType = false;
									}
									FlxG.save.data.accuracyMod == 0 ?  disc.text="Accurate" : disc.text="Complex";
								
								}
						else if(restartR == true)
							{
								_restartR.x=newX;
								
							
								if (FlxG.keys.justPressed.ENTER)
									{
										FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
									}
								if (FlxG.keys.justPressed.UP)
									{
										accuracyType = true;
										restartR = false;
									}
								if (FlxG.keys.justPressed.DOWN)
									{						
										fpsCap = true;
										restartR = false;
									}
									!FlxG.save.data.resetButton ? disc.text="R as a restart button : ON" : disc.text="R as a restart button : OFF";

							}
							else if(fpsCap == true)
								{
									_fpsCap.x=newX;
											
									if (FlxG.keys.justPressed.LEFT)
										{	
											if (FlxG.save.data.fpsCap > 290)
												FlxG.save.data.fpsCap = 290;
											else if (FlxG.save.data.fpsCap < 60)
												FlxG.save.data.fpsCap = Application.current.window.displayMode.refreshRate;
											else
												FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 10;
											(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
										}
									if (FlxG.keys.justPressed.RIGHT)
										{								
											if (FlxG.save.data.fpsCap >= 290)
												{
													FlxG.save.data.fpsCap = 290;
													(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);
												}
											else
													FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 10;					
										}
									if (FlxG.keys.justPressed.UP)
										{
											restartR = true;
											fpsCap = false;
										}
									if (FlxG.keys.justPressed.DOWN)
										{						
											hideSlurs = true;
											fpsCap = false;
										}
									disc.text="FPS CAP: " + FlxG.save.data.fpsCap + (FlxG.save.data.fpsCap == Application.current.window.displayMode.refreshRate ? "Hz" : "");

								}
								else if(hideSlurs == true)
									{
										_hideSlurs.x=newX;
										
									
										if (FlxG.keys.justPressed.ENTER)
											{
												FlxG.save.data.slurs = !FlxG.save.data.slurs;
											}
										if (FlxG.keys.justPressed.UP)
											{
												fpsCap = true;
												hideSlurs = false;
											}
										if (FlxG.keys.justPressed.DOWN)
											{						
												cacheImages = true;
												hideSlurs = false;
											}
									
											FlxG.save.data.slurs ?  disc.text="Hide slurs : ON" : disc.text="Hide slurs : OFF";									
									}
	
									else if(cacheImages == true)
										{
											_cacheImages.x=newX;												
											if (FlxG.keys.justPressed.ENTER)
												{
													FlxG.save.data.scoreScreen = !FlxG.save.data.scoreScreen;
												}
											if (FlxG.keys.justPressed.UP)
												{
													hideSlurs = true;
													cacheImages = false;
												}
											if (FlxG.keys.justPressed.DOWN)
												{						
													customizeGameplay = true;
													cacheImages = false;
												}
										
												FlxG.save.data.cacheImages ?  disc.text="Cache Characters : ON" : disc.text="Cache Characters : OFF";									
										}
										else if(customizeGameplay == true)
											{
												_customizeGameplay.x=newX;																										
												if (FlxG.keys.justPressed.ENTER)
													{
														FlxG.switchState(new GameplayCustomizeState());
													}
												if (FlxG.keys.justPressed.UP)
													{
														cacheImages = true;
														customizeGameplay = false;
													}
												if (FlxG.keys.justPressed.DOWN)
													{						
														charterGrid = true;
														customizeGameplay = false;
													}
											
													disc.text="Change the placement of some HUD elements" ;							
											}
											else if(charterGrid == true)
												{
													_charterGrid.x=newX;																										
													if (FlxG.keys.justPressed.ENTER)
														{
															FlxG.save.data.editor = !FlxG.save.data.editor;

														}
													if (FlxG.keys.justPressed.UP)
														{
															customizeGameplay = true;
															charterGrid = false;
														}
													if (FlxG.keys.justPressed.DOWN)
														{						
															keyBin = true;
															customizeGameplay = false;
														}
												
														FlxG.save.data.editor ?  disc.text="Charter grid : ON" : disc.text="Charter grid : OFF";													
												}
			



									
				FlxG.save.flush();
		}
}
