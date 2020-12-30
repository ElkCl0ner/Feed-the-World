extends TileMap

var my_dict = {
	revealed = false,
	mine = false,
	flag = false
}

var map = []
var rng = RandomNumberGenerator.new()
var map_vec
var started = false
var mines
var size
var pos
var change = 0

signal end

func _get_level():
	match get_tree().get_root().get_node("Game").stats['level']:
		0:pass
		1:_level1()
		2:_level2()
		3:_level3()
		4:_level4()
		5:_level5()
		6:_level6()
		7:_level7()
		8:_level8()
	#print(pos,size,mines)

func _level1():
	pos = get_tree().get_root().get_node("Game").level1['pos']
	size = get_tree().get_root().get_node("Game").level1['size']
	mines = get_tree().get_root().get_node("Game").level1['mines']

func _level2():
	pos = get_tree().get_root().get_node("Game").level2['pos']
	size = get_tree().get_root().get_node("Game").level2['size']
	mines = get_tree().get_root().get_node("Game").level2['mines']

func _level3():
	pos = get_tree().get_root().get_node("Game").level3['pos']
	size = get_tree().get_root().get_node("Game").level3['size']
	mines = get_tree().get_root().get_node("Game").level3['mines']

func _level4():
	pos = get_tree().get_root().get_node("Game").level4['pos']
	size = get_tree().get_root().get_node("Game").level4['size']
	mines = get_tree().get_root().get_node("Game").level4['mines']

func _level5():
	pos = get_tree().get_root().get_node("Game").level5['pos']
	size = get_tree().get_root().get_node("Game").level5['size']
	mines = get_tree().get_root().get_node("Game").level5['mines']

func _level6():
	pos = get_tree().get_root().get_node("Game").level6['pos']
	size = get_tree().get_root().get_node("Game").level6['size']
	mines = get_tree().get_root().get_node("Game").level6['mines']

func _level7():
	pos = get_tree().get_root().get_node("Game").level7['pos']
	size = get_tree().get_root().get_node("Game").level7['size']
	mines = get_tree().get_root().get_node("Game").level7['mines']

func _level8():
	pos = get_tree().get_root().get_node("Game").level8['pos']
	size = get_tree().get_root().get_node("Game").level8['size']
	mines = get_tree().get_root().get_node("Game").level8['mines']

func _draw_map():
	for x in range(size.x):
		map.append([])
		for y in range(size.y):
			map[x].append(my_dict.duplicate())
	
	for x in range(size.x):
		for y in range(size.y):
			set_cell(x, y, 11)

func _reveal(x, y):
	map[x][y]['revealed'] = true
	set_cell(x, y, map[x][y]['number'])

func _set_mines():
	var set_mines = 0
	
	while set_mines < mines:
		rng.randomize()
		var x = rng.randi_range(0, size.x -1)
		var y = rng.randi_range(0, size.y -1)
		if map[x][y]['revealed'] == false and map[x][y]['mine'] == false:
			var test = true
			for x2 in range(x-1, x+2):
					for y2 in range(y-1, y+2):
						if x2 in Array(range(size.x)) and y2 in Array(range(size.y)):
							if map[x2][y2]['revealed'] == true:
								test = false
			if test:
				map[x][y]['mine'] = true
				set_mines += 1

func _calculate_numbers():
	for x in range(size.x):
		for y in range(size.y):
			var seen_mines = 0
			if map[x][y]['mine'] == true:
				map[x][y]['number'] = 9
			else:
				for x2 in range(x-1, x+2):
					for y2 in range(y-1, y+2):
						if x2 in Array(range(size.x)) and y2 in Array(range(size.y)):
							if map[x2][y2]['mine'] == true:
								seen_mines += 1
				map[x][y]['number'] = seen_mines

func _zeros(x, y):
	_reveal(x, y)
	for x2 in range(x-1, x+2):
		for y2 in range(y-1, y+2):
			if x2 in Array(range(size.x)) and y2 in Array(range(size.y)):
				if map[x2][y2]['revealed'] == false and map[x2][y2]['number'] == 0:
					_zeros(x2, y2)
				_reveal(x2, y2)

func test_cleared():
	for x in range(size.x):
		for y in range(size.y):
			if get_cell(x, y) == 11:
				return false
	return true

func test_done():
	for x in range(size.x):
		for y in range(size.y):
			if not (get_cell(x, y) in Array(range(10)) or (map[x][y]['flag'] == map[x][y]['mine'])):
				return false
	return true

func _test_end():
	if test_cleared() and test_done():
		#print("done")
		rng.randomize()
		change += rng.randi_range(5,7)
		get_tree().get_root().get_node("Game").stats['supplies'] += change
		get_tree().get_root().get_node("Game").stats['level'] += 1
		emit_signal('end')

func _lose():
	rng.randomize()
	change -= rng.randi_range(1,3)
	get_node('../Supplies Stat').set_text(str(get_tree().get_root().get_node("Game").stats['supplies'] + change))

func _cheat():
	for x in range(size.x):
		for y in range(size.y):
			set_cell(x, y, map[x][y]['number'])

func _ready():
	_get_level()
	self.position = pos
	_draw_map()

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if started:
			map_vec = world_to_map(event.position - pos)
			if get_cellv(map_vec) == 11:
				if map[map_vec.x][map_vec.y]['number'] == 0:
					_zeros(map_vec.x, map_vec.y)
				else:
					_reveal(map_vec.x, map_vec.y)
					if map[map_vec.x][map_vec.y]['mine'] == true:
						_lose()
				_test_end()
		else:
			map_vec = world_to_map(event.position - pos)
			if get_cellv(map_vec) != -1:
				map[map_vec.x][map_vec.y]['number'] = 0
				_reveal(map_vec.x, map_vec.y)
				_set_mines()
				_calculate_numbers()
				_zeros(map_vec.x, map_vec.y)
				started = true
	
	elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
		map_vec = world_to_map(event.position - pos)
		if get_cellv(map_vec) == 11:
			map[map_vec.x][map_vec.y]['flag'] = true
			set_cellv(map_vec, 10)
			_test_end()
		elif get_cellv(map_vec) == 10:
			map[map_vec.x][map_vec.y]['flag'] = false
			set_cellv(map_vec, 11)
