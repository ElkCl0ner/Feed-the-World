extends RichTextLabel

onready var Timer = get_node("../Timer")

onready var level3 = "Congratulations! You have made through quite a few fields now.\n\nIn a close by village, you come across an old lady that is in need of food supplies.\n\nOld lady : Good day traveler, I see that you are carrying a good quantity of food and water behind you. You see, my daughter is quite ill, and the entire village has not eaten a decent meal in months. Would it be possible to spare us a few food supplies and water? We beg of you…\n\nDo you give away some of the supplies?"
onready var level6 = "Amazing! You are almost at the end!\n\nAs you walk up a bridge, you see a young lady dangling on the edge of the bridge, about to let go and fall into the ravine. You rush your way to save her and manage to grab ahold of her wrist. You slowly try to pull her up, only to realise that all the supply crates were on the verge of falling into the ravine as well. What do you do?\n\nDo you give up on the supplies and save the young lady?"

signal done

var done = false
var rng = RandomNumberGenerator.new()

func _ready():
	Timer.set_wait_time(.05) # time between letters
	if get_tree().get_root().get_node("Game").stats['level'] == 3:
		_dialogue( level3 )
	elif get_tree().get_root().get_node("Game").stats['level'] == 6:
		_dialogue( level6 )

func _dialogue( string ):
	for letter in string:
		Timer.start()
		self.add_text( letter )
		yield(Timer, "timeout")
	done = true
	_on_done()

func _on_done():
	get_node('../Yes').set_button_icon(load('res://ressources/Yes.jpg'))
	get_node('../No').set_button_icon(load('res://ressources/no.jpg'))
	get_node('../Yes').connect('button_down', self, '_yes')
	get_node('../No').connect('button_down', self, '_no')

func _yes():
	rng.randomize()
	get_tree().get_root().get_node("Game").stats['supplies'] -= rng.randi_range(get_tree().get_root().get_node("Game").stats['level'] -1, get_tree().get_root().get_node("Game").stats['level'] +1)
	emit_signal('done')

func _no():
	emit_signal('done')

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if done:
			_on_done()
		else:
			if get_tree().get_root().get_node("Game").stats['level'] == 3:
				self.set_text(level3)
			elif get_tree().get_root().get_node("Game").stats['level'] == 6:
				self.set_text(level6)
			Timer.stop()
			done = true
