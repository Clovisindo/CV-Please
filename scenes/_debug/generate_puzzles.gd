extends Button
#applicant
var applicant_name:String
var applicant_image:String
var validate_solution:bool
#job offer
var work_type
var difficulty
var level_day
var time_limit:int 
var requisites_answers:Dictionary
var cross_questions:Dictionary
var salary_offer:int
var special_condition:String
#Curriculum
var skills_answers:Dictionary
var timeline_jobs:Dictionary
var min_salary:int

var mouse_over = false
var event_fired = false


func _ready():
	# Validation_solution menu
	$"../Panel/ValSolOptionButton".get_popup().add_item("True")
	$"../Panel/ValSolOptionButton".get_popup().add_item("False")
	
	for typeWork in EnumUtils.typeWork:
		$"../../JobOfferPanel/WorkTypeOptionMenu".get_popup().add_item(str(typeWork))
	for dificculty in EnumUtils.dificulty:
		$"../../JobOfferPanel/DifficultyOpMenu".get_popup().add_item(str(dificculty))
	for level in EnumUtils.levels:
		$"../../JobOfferPanel/LevelOpMenu".get_popup().add_item(str(level))
	# Carga de ficheros de recursos
	for level_tres in PuzzleManager.get_all_puzzle():
		$"../LoadedLevelsOpButton".get_popup().add_item(str(level_tres.applicant_name))

func _load_data_form():
	#applicant
	applicant_name = $"../Panel/AppNameLineEdit".text
	applicant_image = $"../Panel/ImageLineEdit".text
	validate_solution = $"../Panel/ValSolOptionButton".get_item_text($"../Panel/ValSolOptionButton".get_selected_id()) == "True"
	#job offer
	work_type = $"../../JobOfferPanel/WorkTypeOptionMenu".get_item_text($"../../JobOfferPanel/WorkTypeOptionMenu".get_selected_id())
	difficulty = $"../../JobOfferPanel/DifficultyOpMenu".get_item_text($"../../JobOfferPanel/DifficultyOpMenu".get_selected_id())
	level_day = $"../../JobOfferPanel/LevelOpMenu".get_item_text($"../../JobOfferPanel/LevelOpMenu".get_selected_id())
	time_limit = int($"../../JobOfferPanel/TimeLimitLineEdit".text)
	#dictionary requisites
	if $"../../JobOfferPanel/ReqAnswerLineEdit".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/ReqAnswerLineEdit".text.split("|")
		requisites_answers[req_ans_split[0]] = req_ans_split[1] + "|" + req_ans_split[2]
	if $"../../JobOfferPanel/ReqAnswerLineEdit2".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/ReqAnswerLineEdit2".text.split("|")
		requisites_answers[req_ans_split[0]] = req_ans_split[1] + "|" + req_ans_split[2]
	if $"../../JobOfferPanel/ReqAnswerLineEdit3".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/ReqAnswerLineEdit3".text.split("|")
		requisites_answers[req_ans_split[0]] = req_ans_split[1] + "|" + req_ans_split[2]
	if $"../../JobOfferPanel/ReqAnswerLineEdit4".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/ReqAnswerLineEdit4".text.split("|")
		requisites_answers[req_ans_split[0]] = req_ans_split[1] + "|" + req_ans_split[2]
	if $"../../JobOfferPanel/ReqAnswerLineEdit5".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/ReqAnswerLineEdit5".text.split("|")
		requisites_answers[req_ans_split[0]] = req_ans_split[1] + "|" + req_ans_split[2]
	
	if $"../../JobOfferPanel/CrossQuestionsLineEdit".text.length() != 0:
		var cross_ans_split = $"../../JobOfferPanel/CrossQuestionsLineEdit".text.split("|")
		cross_questions[cross_ans_split[0] + "|" + cross_ans_split[1]] = cross_ans_split[2] + "|" + cross_ans_split[3]
	salary_offer = int($"../../JobOfferPanel/SalaryOfferLineEdit".text)
	special_condition = $"../../JobOfferPanel/SpecialConditionLineEdit".text
	#Curriculum 
	if $"../../CurriculumPanel/SkillAnswerLineEdit".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/SkillAnswerLineEdit".text.split("|")
		skills_answers[skill_ans_split[0]] = skill_ans_split[1] + "|" + skill_ans_split[2]
	if $"../../CurriculumPanel/SkillAnswerLineEdit2".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/SkillAnswerLineEdit2".text.split("|")
		skills_answers[skill_ans_split[0]] = skill_ans_split[1] + "|" + skill_ans_split[2]
	if $"../../CurriculumPanel/SkillAnswerLineEdit3".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/SkillAnswerLineEdit3".text.split("|")
		skills_answers[skill_ans_split[0]] = skill_ans_split[1] + "|" + skill_ans_split[2]
	if $"../../CurriculumPanel/SkillAnswerLineEdit4".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/SkillAnswerLineEdit4".text.split("|")
		skills_answers[skill_ans_split[0]] = skill_ans_split[1] + "|" + skill_ans_split[2]
	if $"../../CurriculumPanel/SkillAnswerLineEdit5".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/SkillAnswerLineEdit5".text.split("|")
		skills_answers[skill_ans_split[0]] = skill_ans_split[1] + "|" + skill_ans_split[2]
	
	if $"../../CurriculumPanel/TimelineJobLineEdit".text.length() != 0:
		var timeline = $"../../CurriculumPanel/TimelineJobLineEdit".text.split("|")
		timeline_jobs[timeline[0]] = timeline[1] 
	if $"../../CurriculumPanel/TimelineJobLineEdit2".text.length() != 0:
		var timeline = $"../../CurriculumPanel/TimelineJobLineEdit2".text.split("|")
		timeline_jobs[timeline[0]] = timeline[1] 
	if $"../../CurriculumPanel/TimelineJobLineEdit3".text.length() != 0:
		var timeline = $"../../CurriculumPanel/TimelineJobLineEdit3".text.split("|")
		timeline_jobs[timeline[0]] = timeline[1] 
	if $"../../CurriculumPanel/TimelineJobLineEdit4".text.length() != 0:
		var timeline = $"../../CurriculumPanel/TimelineJobLineEdit4".text.split("|")
		timeline_jobs[timeline[0]] = timeline[1] 
	if $"../../CurriculumPanel/TimelineJobLineEdit5".text.length() != 0:
		var timeline = $"../../CurriculumPanel/TimelineJobLineEdit5".text.split("|")
		timeline_jobs[timeline[0]] = timeline[1] 
	
	min_salary = int($"../../CurriculumPanel/MinSalaryLineEdit".text)


func _generate_puzzle():
	var puzzle = Puzzle.new()
	puzzle.instantiate(applicant_name, applicant_image, validate_solution, work_type, difficulty, level_day,time_limit, requisites_answers,
	cross_questions,salary_offer,special_condition,skills_answers,timeline_jobs,min_salary)
	
	PuzzleManager.save_puzzle(puzzle)


func _on_Button_gui_input(event):
	if event is InputEventMouseButton:
		if mouse_over == true && event_fired == false:
			event_fired = true
			_load_data_form()
			_generate_puzzle()


func _on_Button_mouse_entered():
	mouse_over = true
func _on_Button_mouse_exited():
	mouse_over = false
	event_fired = false
