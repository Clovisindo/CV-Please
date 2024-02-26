extends Resource

class_name Puzzle

#Additional info
export var validation_response = {
	"validationOK": "message OK",
	"validationNOK": "message NOK"
}
export var description = "description for design"
export var dummy_comments = {
	"dummy1": "Dummy message 1",
	"dummy2": "Dummy message 2"
}
# applicant
export var applicant_name = "Rival"
export var appl_image = "rival.png"#TODO ruta recursos imagenes
export var validate_solution = true
#job offer
export(EnumUtils.typeWork) var work_type = EnumUtils.typeWork.special_type1
export(EnumUtils.dificulty) var difficulty = EnumUtils.dificulty.easy
export(EnumUtils.levels) var level_day = EnumUtils.levels.level_1
export var time_limit = 5 #se mide en acciones, no en tiempo real
export var requisites_answers = {
		"requisite1": "question 1 player | answer 1 applicant",
		"requisite2": "question 2 player | answer 2 applicant",
		"requisite3": "question 3 player | answer 3 applicant"
	}
export var cross_questions = {
		"requisite1|requisite2": "question 1 player | answer 1 applicant",
	}#TODO esto tiene sentido asi?no hace falta definir todos, avisar de cuales no dicen nada
export var salary_offer = 15000
export var special_condition ="first job for applicant"#no invalida al candidato, es un plus si se cumple
#Curriculum
export var skills_answers = {
		"Skill1": "question 1 player | answer 1 applicant",
		"Skill2": "question 2 player | answer 2 applicant",
		"Skill3": "question 3 player | answer 3 applicant"
	}
export var timeline_jobs = {
		"job1": "from date to date",
		"job2": "from date to date",
		"job3": "from date to date"
	}
export var min_salary = 18000


func instantiate(_applicant_name, _appl_image, _validate_solution, _description, _dummy_comments, _work_type, _difficulty, _level_day, _time_limit, _requisites_answers, _cross_questions, _salary_offer, _special_condition, 
_skills_answers, _timeline_jobs, _min_salary, _validation_response):
	applicant_name = _applicant_name
	appl_image = _appl_image
	validate_solution = _validate_solution
	
	description = _description
	dummy_comments = _dummy_comments
	
	work_type = _work_type
	difficulty = _difficulty
	level_day = _level_day
	time_limit = _time_limit
	requisites_answers = _requisites_answers
	cross_questions = _cross_questions
	salary_offer = _salary_offer
	special_condition = _special_condition
	
	skills_answers = _skills_answers
	timeline_jobs = _timeline_jobs
	min_salary = _min_salary
	
	validation_response = _validation_response

