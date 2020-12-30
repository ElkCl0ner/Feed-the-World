extends Sprite

signal done

func _ready():
	if get_tree().get_root().get_node("Game").stats['supplies'] >= 20:
		self.set_texture(load('res://ressources/win.jpg'))
	get_node('Supplies').set_text(str(get_tree().get_root().get_node("Game").stats['supplies']))
	get_node('../Return to Main Menu').set_button_icon(load('res://ressources/return_1.jpg'))
	get_node('../Return to Main Menu').connect('button_down', self, '_done')

func _done():
	emit_signal('done')
