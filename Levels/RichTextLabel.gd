extends RichTextLabel

func _ready():
	set_text('Current Level: ' + str(get_tree().get_root().get_node("Game").stats['level']))
