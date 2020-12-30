extends RichTextLabel

onready var Timer = get_node("../Timer")

onready var stringPrinted = "Oh wow! I never thought you would make it this far!\n\nSo you arrive at the delivery station where all the supplies will be distributed across the country. Many of the workers look at you with disgust since you haven’t showered in days and dedicated the last few days in pursuit for this one specific moment. You strongly wish all the people end up obtaining even a slight bit of food and water so that they can survive a little longer. Once your job is done, you leave and go back home.\n\nThe distribution center starts counting the amount of supply crates you brought in..."

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
	emit_signal("done")

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if done:
			emit_signal("done")
		else:
			self.set_text(stringPrinted)
			Timer.stop()
			done = true
