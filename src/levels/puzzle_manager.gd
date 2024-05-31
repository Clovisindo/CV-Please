extends Node

const LEVELS_DIR = "res://data/puzzles/"
const TRES_SUFIX = ".tres"


func save_puzzle(_puzzle):
	var result = ResourceSaver.save(LEVELS_DIR + _puzzle.applicant_name + TRES_SUFIX, _puzzle)
	assert(result == OK)


# func get_all_puzzle():
# 	var puzzles = []
# 	var dir = Directory.new()
# 	if dir.open(LEVELS_DIR) == OK:
# 		dir.list_dir_begin()
# 		var file_name = dir.get_next()
# 		var regex = RegEx.new()
# 		regex.compile(".*\\.tres")
# 		while file_name != "":
# 			if regex.search(file_name):
# 				if not dir.current_is_dir():
# 					var puzzle = ResourceLoader.load(LEVELS_DIR + file_name)
# 					if puzzle is Puzzle:
# 						puzzles.append(puzzle)
# 			file_name = dir.get_next()
# 	else:
# 		print("An error occurred when trying to access the path.")
# 	return puzzles


func get_all_puzzle():
	var puzzles = []
	var dir = Directory.new()
	var current_dir = _get_directory_by_month(Global.current_month)
	if dir.open(current_dir) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var regex = RegEx.new()
		regex.compile(".*\\.tres")
		while file_name != "":
			if regex.search(file_name):
				if not dir.current_is_dir():
					var puzzle = ResourceLoader.load(current_dir + file_name)
					if puzzle is Puzzle:
						puzzles.append(puzzle)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return puzzles


func _get_directory_by_month(_current_month):
	return LEVELS_DIR + _get_month_value(_current_month) + "/"


func _get_month_value(enum_month):
	match enum_month:
		Time.MONTH_JANUARY:
			return "/1january"
		Time.MONTH_FEBRUARY:
			return "/2february"
		Time.MONTH_MARCH:
			return "/3march"
		Time.MONTH_APRIL:
			return "/4april"
		Time.MONTH_MAY:
			return "/5may"
		Time.MONTH_JUNE:
			return "/6june"
