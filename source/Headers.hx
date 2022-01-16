package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
class Headers extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
        


        var choose = FlxG.random.int(1,31);
		
        frames = Paths.getSparrowAtlas("Menu/headers/banners");
	
        animation.addByPrefix('1', 'bb0');
        animation.addByPrefix('2', 'bb2');
        animation.addByPrefix('3', 'bb3');
        animation.addByPrefix('4', '4');
        animation.addByPrefix('5', '5');
        animation.addByPrefix('6', '6');
        animation.addByPrefix('7', '7');
        animation.addByPrefix('8','8');
        animation.addByPrefix('9', '9');
        animation.addByPrefix('10', '10');
        animation.addByPrefix('11', '11');
        animation.addByPrefix('12', '12');
        animation.addByPrefix('13', '13');
        animation.addByPrefix('14', '14');
        animation.addByPrefix('15', '15');
        animation.addByPrefix('16', '16');
        animation.addByPrefix('17', '17');
        animation.addByPrefix('18', '18');
        animation.addByPrefix('19', '19');
        animation.addByPrefix('20', '20');
        animation.addByPrefix('21', '21');
        animation.addByPrefix('22', '25');
        animation.addByPrefix('23', '26');
        animation.addByPrefix('24', '27');
        animation.addByPrefix('25', '28');
        animation.addByPrefix('26', '29');
        animation.addByPrefix('27', '30');
        animation.addByPrefix('28', '31');
        animation.addByPrefix('29', '32');
        animation.addByPrefix('30', '33');
        animation.addByPrefix('31', '34');
        animation.play(choose+"");
        
        antialiasing = true;
	}

	
}
