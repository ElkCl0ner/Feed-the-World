extends Node2D

var stats = {
	level = 1,
	supplies = 5
}

var level1 = {
	pos = Vector2(672,256),
	size = Vector2(10,10),
	mines = 16
}
var level2 = {
	pos = Vector2(672,256),
	size = Vector2(12,12),
	mines = 23
	}
var level3 = {
	pos = Vector2(672,256),
	size = Vector2(14,14),
	mines = 30
	}
var level4 = {
	pos = Vector2(672,256),
	size = Vector2(14,14),
	mines = 34
	}
var level5 = {
	pos = Vector2(672,256),
	size = Vector2(16,16),
	mines = 40
	}
var level6 = {
	pos = Vector2(672,160),
	size = Vector2(18,18),
	mines = 44
	}
var level7 = {
	pos = Vector2(672,160),
	size = Vector2(18,18),
	mines = 52
	}
var level8 = {
	pos = Vector2(672,96),
	size = Vector2(20,20),
	mines = 64
	}

var levels = [level1, level2, level3, level4, level5, level6, level7, level8]

func _connect_all():
	get_node('Main Menu/New Game').connect('button_down', self, '_new_game')
	get_node('Main Menu/Load Game').connect('button_down', self, '_load_game')
	get_node('Main Menu/Credits').connect('button_down', self, '_credits')
	get_node('Main Menu/Quit').connect('button_down', self, '_quit')

func _connect_levels():
	get_node('Levels/Tutorial').connect('button_down', self, '_tutorial')
	get_node('Levels/Level 1').connect('button_down', self, '_level1')
	get_node('Levels/Level 2').connect('button_down', self, '_level2')
	get_node('Levels/Level 3').connect('button_down', self, '_level3')
	get_node('Levels/Level 4').connect('button_down', self, '_level4')
	get_node('Levels/Level 5').connect('button_down', self, '_level5')
	get_node('Levels/Level 6').connect('button_down', self, '_level6')
	get_node('Levels/Level 7').connect('button_down', self, '_level7')
	get_node('Levels/Level 8').connect('button_down', self, '_level8')
	get_node('Levels/The End').connect('button_down', self, '_the_end')

func _connect_end():
	get_node('Minesweeper/TileMap').connect('end', self, '_return_to_levels')

func _no_rules():
	self.remove_child(self.get_child(1))

func _tutorial():
	self.add_child(load('res://Rules/Rules.tscn').instance())
	get_node('Rules/Rules Text').connect('done', self, '_no_rules')

func _level1():
	if stats['level'] == 1:
		self.remove_child(self.get_child(0))
		self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
		get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
		_connect_end()

func _level2():
	if stats['level'] == 2:
		self.remove_child(self.get_child(0))
		self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
		get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
		_connect_end()

func _level3():
	if stats['level'] == 3:
		self.add_child(load('res://Events/Events.tscn').instance())
		get_node('Events/Event Text').connect('done', self, '_go_level3')

func _go_level3():
	self.remove_child(self.get_child(0))
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
	get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
	_connect_end()

func _level4():
	if stats['level'] == 4:
		self.remove_child(self.get_child(0))
		self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
		get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
		_connect_end()

func _level5():
	if stats['level'] == 5:
		self.remove_child(self.get_child(0))
		self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
		get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
		_connect_end()

func _level6():
	if stats['level'] == 6:
		self.add_child(load('res://Events/Events.tscn').instance())
		get_node('Events/Event Text').connect('done', self, '_go_level6')

func _go_level6():
	self.remove_child(self.get_child(0))
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
	get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
	_connect_end()

func _level7():
	if stats['level'] == 7:
		self.remove_child(self.get_child(0))
		self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
		get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
		_connect_end()

func _level8():
	if stats['level'] == 8:
		self.remove_child(self.get_child(0))
		self.add_child(load('res://Minesweeper/Minesweeper.tscn').instance())
		get_node('Minesweeper/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
		_connect_end()

func _the_end():
	if stats['level'] == 9:
		self.add_child(load('res://End/End.tscn').instance())
		get_node('End/End Text').connect('done', self, '_the_end2')

func _the_end2():
	self.remove_child(self.get_child(1))
	self.add_child(load('res://End/End2.tscn').instance())
	get_node('End2/Sprite').connect('done', self, '_end')

func _end():
	self.remove_child(self.get_child(0))
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Main Menu/Main Menu.tscn').instance())
	_connect_all()

func _return_to_levels():
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Levels/Levels.tscn').instance())
	get_node('Levels/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
	_connect_levels()

func _new_game():
	self.add_child(load('res://New Game/New Game.tscn').instance())
	get_node('New Game/Yes').connect('button_down', self, '_new_game_yes')
	get_node('New Game/No').connect('button_down', self, '_new_game_no')
	

func _new_game_yes():
	self.remove_child(self.get_child(1))
	self.add_child(load('res://Intro/Intro.tscn').instance())
	get_node('Intro/Intro Text').connect('done', self, '_continue')

func _new_game_no():
	self.remove_child(self.get_child(1))

func _continue():
	self.remove_child(self.get_child(0))
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Levels/Levels.tscn').instance())
	get_node('Levels/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')
	_connect_levels()

func _load_game():
	var file = File.new()
	if file.file_exists('res://save/save.json'):
		file.open('res://save/save.json', file.READ)
		var json = file.get_as_text()
		stats = JSON.parse(json).result
		file.close()
		stats['level'] = int(stats['level'])
		stats['supplies'] = int(stats['supplies'])
	
	_new_game()
	_continue()

func _credits():
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Credits/Credits.tscn').instance())
	get_node('Credits/Return to Main Menu').connect('button_down', self, '_return_to_main_menu')

func _quit():
	var file = File.new()
	file.open('res://save/save.json', file.WRITE)
	file.store_line(to_json(stats))
	file.close()
	get_tree().quit()

func _return_to_main_menu():
	self.remove_child(self.get_child(0))
	self.add_child(load('res://Main Menu/Main Menu.tscn').instance())
	_connect_all()

func _ready():
	self.add_child(load('res://Main Menu/Main Menu.tscn').instance())
	_connect_all()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_quit()
