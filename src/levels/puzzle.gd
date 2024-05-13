extends Resource

class_name Puzzle

#Additional info
export(Array, Resource) var validation_response
export var description = "description for design"
export(Array, Resource) var dummy_comments
# applicant
export var applicant_name = "Rival"
export var appl_image = "rival.png"  #TODO ruta recursos imagenes
export var validate_solution = true
# additional info
export var company_name = "test company"
export var category_job = "test category"
export var payment_salary = 200
#job offer
export(EnumUtils.TypeWork) var work_type = EnumUtils.TypeWork.SPECIAL_TYPE1
export(EnumUtils.Dificulty) var difficulty = EnumUtils.Dificulty.EASY
export(EnumUtils.Levels) var level_day = EnumUtils.Levels.LEVEL_1
export var time_limit = 5  #se mide en acciones, no en tiempo real
export(Array, Resource) var requisites_answers
export(Array, Resource) var cross_questions
export var salary_offer = 15000
export(Resource) var special_condition  #no invalida al candidato, es un plus si se cumple
#Curriculum
export(Array, Resource) var skills_answers
export(Array, Resource) var timeline_jobs
export var min_salary = 18000

export(Array, Resource) var detail_validations


func instantiate(
	_applicant_name,
	_appl_image,
	_validate_solution,
	_description,
	_dummy_comments,
	_work_type,
	_difficulty,
	_level_day,
	_time_limit,
	_requisites_answers,
	_cross_questions,
	_salary_offer,
	_special_condition,
	_skills_answers,
	_timeline_jobs,
	_min_salary,
	_validation_response,
	_detail_validations,
	_company_name,
	_category_job,
	_payment_salary
):
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
	company_name = _company_name
	category_job = _category_job
	payment_salary = _payment_salary

	skills_answers = _skills_answers
	timeline_jobs = _timeline_jobs
	min_salary = _min_salary

	validation_response = _validation_response

	detail_validations = _detail_validations
