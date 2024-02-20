extends Node

class_name PuzzleManager
var puzzle
const FILE_NAME = "res://scenes/game/levels/"

func save_puzzle(_puzzle):
	var result = ResourceSaver.save(FILE_NAME + _puzzle.applicant_name + ".tres", _puzzle)
	assert(result == OK)

func load_puzzle(_applicant_name):
	var file_name = FILE_NAME + _applicant_name + ".tres"
	if ResourceLoader.exists(file_name):
		var puzzle = ResourceLoader.load(file_name)
		if puzzle is Puzzle:
			return puzzle
