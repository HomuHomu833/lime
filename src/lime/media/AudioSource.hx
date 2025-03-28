package lime.media;

import lime.app.Event;
import lime.media.openal.AL;
import lime.media.openal.ALSource;
import lime.math.Vector4;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class AudioSource
{
	public var onComplete = new Event<Void->Void>();
	public var buffer:AudioBuffer;
	public var currentTime(get, set):Float;
	public var gain(get, set):Float;
	public var length(get, set):Int;
	public var loops(get, set):Int;
	public var pitch(get, set):Float;
	public var offset:Int;
	public var position(get, set):Vector4;

	/**
		The estimated output latency, in miliseconds, for this `AudioSource`. If not possible to retrieve will return `0`.

		NOTE: This will return `0` if the source is not playing!
	**/
	public var latency(get, never):Float;

	@:noCompletion private var __backend:AudioSourceBackend;

	public function new(buffer:AudioBuffer = null, offset:Int = 0, length:Null<Int> = null, loops:Int = 0)
	{
		this.buffer = buffer;
		this.offset = offset;

		__backend = new AudioSourceBackend(this);

		if (length != null && length != 0)
		{
			this.length = length;
		}

		this.loops = loops;

		if (buffer != null)
		{
			init();
		}
	}

	public function dispose():Void
	{
		__backend.dispose();
	}

	@:noCompletion private function init():Void
	{
		__backend.init();
	}

	public function play():Void
	{
		__backend.play();
	}

	public function pause():Void
	{
		__backend.pause();
	}

	public function stop():Void
	{
		__backend.stop();
	}

	// Get & Set Methods
	@:noCompletion private function get_currentTime():Float
	{
		return __backend.getCurrentTime();
	}

	@:noCompletion private function set_currentTime(value:Float):Float
	{
		return __backend.setCurrentTime(value);
	}

	@:noCompletion private function get_gain():Float
	{
		return __backend.getGain();
	}

	@:noCompletion private function set_gain(value:Float):Float
	{
		return __backend.setGain(value);
	}

	@:noCompletion private function get_length():Int
	{
		return __backend.getLength();
	}

	@:noCompletion private function set_length(value:Int):Int
	{
		return __backend.setLength(value);
	}

	@:noCompletion private function get_loops():Int
	{
		return __backend.getLoops();
	}

	@:noCompletion private function set_loops(value:Int):Int
	{
		return __backend.setLoops(value);
	}

	@:noCompletion private function get_pitch():Float
	{
		return __backend.getPitch();
	}

	@:noCompletion private function set_pitch(value:Float):Float
	{
		return __backend.setPitch(value);
	}

	@:noCompletion private function get_position():Vector4
	{
		return __backend.getPosition();
	}

	@:noCompletion private function set_position(value:Vector4):Vector4
	{
		return __backend.setPosition(value);
	}

	@:noCompletion private function get_latency():Float
	{
		return __backend.getLatency();
	}
}

#if (js && html5)
@:noCompletion private typedef AudioSourceBackend = lime._internal.backend.html5.HTML5AudioSource;
#else
@:noCompletion private typedef AudioSourceBackend = lime._internal.backend.native.NativeAudioSource;
#end
