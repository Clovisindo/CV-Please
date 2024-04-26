extends Node

const LEVELS_DIR = "res://data/puzzles/"
const TRES_SUFIX = ".tres"


func save_puzzle(_puzzle):
	var result = ResourceSaver.save(LEVELS_DIR + _puzzle.applicant_name + TRES_SUFIX, _puzzle)
	assert(result == OK)


func get_all_puzzle():
	var puzzles = []
	var dir = Directory.new()
	if dir.open(LEVELS_DIR) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var regex = RegEx.new()
		regex.compile(".*\\.tres")
		while file_name != "":
			if regex.search(file_name):
				if not dir.current_is_dir():
					var puzzle = ResourceLoader.load(LEVELS_DIR + file_name)
					if puzzle is Puzzle:
						puzzles.append(puzzle)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return puzzles
