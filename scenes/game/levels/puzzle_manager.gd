extends Node

class_name PuzzleManager
var puzzle
const FILE_NAME = "res://scenes/game/levels/levels_puzzle.json"

#var puzzle = {
#	"applicant_name": "Zippy",
#	"validate_solution" : true
#}

func _init():
	instantiate_puzzle()
	save_puzzle()
#	load_puzzle()
	

func instantiate_puzzle():
	puzzle = {
		#applicant
		"applicant_name": "Zippy",
		"appl_image" : "",
		"validate_solution" : true,
		#job offer
		"work_type" : str(EnumUtils.typeWork.keys()[EnumUtils.typeWork.special_type1]),
		"difficulty" : str(EnumUtils.dificulty.keys()[EnumUtils.dificulty.easy]),
		"level_day" : str(EnumUtils.levels.keys()[EnumUtils.levels.level_1]),
		"time_limit" : 5,
		"requisites_answers": {
			"requisite1": "question 1 player | answer 1 applicant",
			"requisite2": "question 2 player | answer 2 applicant",
			"requisite3": "question 3 player | answer 3 applicant"
		},
		"cross_questions": {
			"requisite1|requisite2": "question 1 player | answer 1 applicant",
		},
		"salary_offer" : 15000,
		"special_condition" : "first job",
		#curriculum
		"skills_answers": {
			"Skill1": "question 1 player | answer 1 applicant",
			"Skill2": "question 2 player | answer 2 applicant",
			"Skill3": "question 3 player | answer 3 applicant"
		},
		"timeline_jobs": {
			"job1": "from date to date",
			"job2": "from date to date",
			"job3": "from date to date"
		},
		"min_salary" : 18000
	}

func save_puzzle():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(JSON.print(puzzle,"\t"))
	file.close()

#func save_puzzle(_puzzle):
#	var file = File.new()
#	file.open(FILE_NAME, File.WRITE)
#	file.store_string(JSON.print(_puzzle,"\t"))
#	file.close()

func load_puzzle():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			puzzle = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")
