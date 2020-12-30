extends RichTextLabel

onready var Timer = get_node("../Timer")

onready var stringPrinted = "Welcome to Froot inc. There is no time to spare! We need your help to deliver supplies to families who suffer from food insecurity. In order to do so, you will need to go through 8 grass fields. In each field, there are holes into which you may fall, causing you to lose some supply crates. You will be rewarded with some supply crates after clearing each field. Your goal is to deliver 20 supply crates at the end."

signal done

var done = false

func _ready():
	Timer.set_wait_time(.05) # time between letters
	_dialogue( stringPrinted )

func _dialogue( string ):
	for letter in string:
		Timer.start()
		self.add_text( letter )
		yield(Timer, "timeout")
	done = true

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if done:
			emit_signal('done')
		else:
			self.set_text(stringPrinted)
			Timer.stop()
			done = true
