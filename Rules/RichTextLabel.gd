extends RichTextLabel

onready var Timer = get_node("../Timer")

onready var stringPrinted = "In each field, there are holes into which you may fall, causing you to lose some supply crates. To clear a field, you will need to bypass all the holes and uncover the entire field. Numbers will be displayed on the ground indicating how many holes the tile with the number is touching (whether it is touching vertically, horizontally, or diagonally). Now! It is your time to shine! Deliver the supplies! We’re counting on you! "

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
