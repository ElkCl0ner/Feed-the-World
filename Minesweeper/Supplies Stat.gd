extends RichTextLabel

func _ready():
	set_text(str(get_tree().get_root().get_node("Game").stats['supplies']))
