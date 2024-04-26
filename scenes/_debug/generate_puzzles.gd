extends Button
#applicant
var applicant_name: String
var applicant_image: String
var validate_solution: bool
#additional info
var validation_response: Array
var description: String
var dummy_comments: Array
var payment_salary: int
#job offer
var work_type
var difficulty
var level_day
var time_limit: int
var company_name: String
var category_job: String
var requisites_answers: Array
var cross_questions: Array
var salary_offer: int
var special_condition: String
var detail_validations: Array

#Curriculum
var skills_answers: Array
var timeline_jobs: Array
var min_salary: int

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
	for specialCondition in EnumUtils.typeSpecialCondition:
		$"../../PanelSecondaryInfo/detailValidationPanel1/TypeSpecialConditionOptionMenu".get_popup().add_item(
			str(specialCondition)
		)
		$"../../PanelSecondaryInfo/detailValidationPanel2/TypeSpecialConditionOptionMenu".get_popup().add_item(
			str(specialCondition)
		)
		$"../../PanelSecondaryInfo/detailValidationPanel3/TypeSpecialConditionOptionMenu".get_popup().add_item(
			str(specialCondition)
		)
		$"../../PanelSecondaryInfo/detailValidationPanel4/TypeSpecialConditionOptionMenu".get_popup().add_item(
			str(specialCondition)
		)
		$"../../PanelSecondaryInfo/detailValidationPanel5/TypeSpecialConditionOptionMenu".get_popup().add_item(
			str(specialCondition)
		)


#	# Carga de ficheros de recursos
#	for level_tres in PuzzleManager.get_all_puzzle():
#		$"../LoadedLevelsOpButton".get_popup().add_item(str(level_tres.applicant_name))


func _load_data_form():
	#applicant
	applicant_name = $"../Panel/AppNameLineEdit".text
	applicant_image = $"../Panel/ImageLineEdit".text
	validate_solution = (
		$"../Panel/ValSolOptionButton".get_item_text(
			$"../Panel/ValSolOptionButton".get_selected_id()
		)
		== "True"
	)
	#additional info
	var responseOK: String
	var responseNOK: String
	if $"../../AdditionalInfoPanel/ValidationResponseLineEdit".text.length() != 0:
		responseOK = $"../../AdditionalInfoPanel/ValidationResponseLineEdit".text
	if $"../../AdditionalInfoPanel/ValidationResponseLineEdit2".text.length() != 0:
		responseNOK = $"../../AdditionalInfoPanel/ValidationResponseLineEdit2".text
	var response = ResourceValidationResponse.new()
	response.set_data(responseOK, responseNOK)
	validation_response.append(response)

	if $"../../JobOfferPanel/PaymentSalaryLineEdit".text.length() != 0:
		payment_salary = int($"../../JobOfferPanel/PaymentSalaryLineEdit".text)

	description = $"../../AdditionalInfoPanel/DescriptionLineEdit".text

	var dummy1: String
	var dummy2: String
	if $"../../AdditionalInfoPanel/DummyCommentLineEdit".text.length() != 0:
		dummy1 = $"../../AdditionalInfoPanel/DummyCommentLineEdit".text
	if $"../../AdditionalInfoPanel/DummyCommentLineEdit2".text.length() != 0:
		dummy2 = $"../../AdditionalInfoPanel/DummyCommentLineEdit2".text
	var dummy_comment = ResourceDummyResponse.new()
	dummy_comment.set_data(dummy1, dummy2)
	dummy_comments.append(dummy_comment)
	#job offer
	work_type = $"../../JobOfferPanel/WorkTypeOptionMenu".get_selected_id()
	difficulty = $"../../JobOfferPanel/DifficultyOpMenu".get_selected_id()
	level_day = $"../../JobOfferPanel/LevelOpMenu".get_selected_id()
	time_limit = int($"../../JobOfferPanel/TimeLimitLineEdit".text)
	company_name = $"../../JobOfferPanel/CompanyNameLineEdit".text
	category_job = $"../../JobOfferPanel/CategoryJobLineEdit".text
	#dictionary requisites
	if $"../../JobOfferPanel/linepanel1/ReqAnswerLineEdit".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/linepanel1/ReqAnswerLineEdit".text
		var req_ans_split2 = $"../../JobOfferPanel/linepanel1/ReqAnswerLineEdit2".text
		var req_ans_split3 = $"../../JobOfferPanel/linepanel1/ReqAnswerLineEdit3".text
		var req_answer = ResourceQuestAnsw.new()
		req_answer.set_data(req_ans_split, req_ans_split2, req_ans_split3)
		requisites_answers.append(req_answer)
	if $"../../JobOfferPanel/linepanel2/ReqAnswerLineEdit".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/linepanel2/ReqAnswerLineEdit".text
		var req_ans_split2 = $"../../JobOfferPanel/linepanel2/ReqAnswerLineEdit2".text
		var req_ans_split3 = $"../../JobOfferPanel/linepanel2/ReqAnswerLineEdit3".text
		var req_answer = ResourceQuestAnsw.new()
		req_answer.set_data(req_ans_split, req_ans_split2, req_ans_split3)
		requisites_answers.append(req_answer)
	if $"../../JobOfferPanel/linepanel3/ReqAnswerLineEdit".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/linepanel3/ReqAnswerLineEdit".text
		var req_ans_split2 = $"../../JobOfferPanel/linepanel3/ReqAnswerLineEdit2".text
		var req_ans_split3 = $"../../JobOfferPanel/linepanel3/ReqAnswerLineEdit3".text
		var req_answer = ResourceQuestAnsw.new()
		req_answer.set_data(req_ans_split, req_ans_split2, req_ans_split3)
		requisites_answers.append(req_answer)
	if $"../../JobOfferPanel/linepanel4/ReqAnswerLineEdit".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/linepanel4/ReqAnswerLineEdit".text
		var req_ans_split2 = $"../../JobOfferPanel/linepanel4/ReqAnswerLineEdit2".text
		var req_ans_split3 = $"../../JobOfferPanel/linepanel4/ReqAnswerLineEdit3".text
		var req_answer = ResourceQuestAnsw.new()
		req_answer.set_data(req_ans_split, req_ans_split2, req_ans_split3)
		requisites_answers.append(req_answer)
	if $"../../JobOfferPanel/linepanel5/ReqAnswerLineEdit".text.length() != 0:
		var req_ans_split = $"../../JobOfferPanel/linepanel5/ReqAnswerLineEdit".text
		var req_ans_split2 = $"../../JobOfferPanel/linepanel5/ReqAnswerLineEdit2".text
		var req_ans_split3 = $"../../JobOfferPanel/linepanel5/ReqAnswerLineEdit3".text
		var req_answer = ResourceQuestAnsw.new()
		req_answer.set_data(req_ans_split, req_ans_split2, req_ans_split3)
		requisites_answers.append(req_answer)
	if $"../../JobOfferPanel/CrossPanel/CrossQuestionsLineEdit".text.length() != 0:
		var cross_ans_split = $"../../JobOfferPanel/CrossPanel/CrossQuestionsLineEdit".text
		var cross_ans_split2 = $"../../JobOfferPanel/CrossPanel/CrossQuestionsLineEdit2".text
		var cross_ans_split3 = $"../../JobOfferPanel/CrossPanel/CrossQuestionsLineEdit3".text
		var cross_ans_split4 = $"../../JobOfferPanel/CrossPanel/CrossQuestionsLineEdit4".text
		var cross_question = ResourceQuestAnsw.new()
		cross_question.set_data(
			cross_ans_split, cross_ans_split3, cross_ans_split4, cross_ans_split2
		)
		cross_questions.append(cross_question)
	salary_offer = int($"../../JobOfferPanel/SalaryOfferLineEdit".text)
	special_condition = $"../../JobOfferPanel/SpecialConditionLineEdit".text
	#Curriculum
	if $"../../CurriculumPanel/skillpanel/ReqAnswerLineEdit".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/skillpanel/ReqAnswerLineEdit".text
		var skill_ans_split2 = $"../../CurriculumPanel/skillpanel/ReqAnswerLineEdit2".text
		var skill_ans_split3 = $"../../CurriculumPanel/skillpanel/ReqAnswerLineEdit3".text
		var skill_answer = ResourceQuestAnsw.new()
		skill_answer.set_data(skill_ans_split, skill_ans_split2, skill_ans_split3)
		skills_answers.append(skill_answer)
	if $"../../CurriculumPanel/skillpanel2/ReqAnswerLineEdit".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/skillpanel2/ReqAnswerLineEdit".text
		var skill_ans_split2 = $"../../CurriculumPanel/skillpanel2/ReqAnswerLineEdit2".text
		var skill_ans_split3 = $"../../CurriculumPanel/skillpanel2/ReqAnswerLineEdit3".text
		var skill_answer = ResourceQuestAnsw.new()
		skill_answer.set_data(skill_ans_split, skill_ans_split2, skill_ans_split3)
		skills_answers.append(skill_answer)
	if $"../../CurriculumPanel/skillpanel3/ReqAnswerLineEdit".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/skillpanel3/ReqAnswerLineEdit".text
		var skill_ans_split2 = $"../../CurriculumPanel/skillpanel3/ReqAnswerLineEdit2".text
		var skill_ans_split3 = $"../../CurriculumPanel/skillpanel3/ReqAnswerLineEdit3".text
		var skill_answer = ResourceQuestAnsw.new()
		skill_answer.set_data(skill_ans_split, skill_ans_split2, skill_ans_split3)
		skills_answers.append(skill_answer)
	if $"../../CurriculumPanel/skillpanel4/ReqAnswerLineEdit".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/skillpanel4/ReqAnswerLineEdit".text
		var skill_ans_split2 = $"../../CurriculumPanel/skillpanel4/ReqAnswerLineEdit2".text
		var skill_ans_split3 = $"../../CurriculumPanel/skillpanel4/ReqAnswerLineEdit3".text
		var skill_answer = ResourceQuestAnsw.new()
		skill_answer.set_data(skill_ans_split, skill_ans_split2, skill_ans_split3)
		skills_answers.append(skill_answer)
	if $"../../CurriculumPanel/skillpanel5/ReqAnswerLineEdit".text.length() != 0:
		var skill_ans_split = $"../../CurriculumPanel/skillpanel5/ReqAnswerLineEdit".text
		var skill_ans_split2 = $"../../CurriculumPanel/skillpanel5/ReqAnswerLineEdit2".text
		var skill_ans_split3 = $"../../CurriculumPanel/skillpanel5/ReqAnswerLineEdit3".text
		var skill_answer = ResourceQuestAnsw.new()
		skill_answer.set_data(skill_ans_split, skill_ans_split2, skill_ans_split3)
		skills_answers.append(skill_answer)
	if $"../../CurriculumPanel/timelinejobPanel/TimelineJobLineEdit".text.length() != 0:
		var timeline = $"../../CurriculumPanel/timelinejobPanel/TimelineJobLineEdit".text
		var timeline2 = $"../../CurriculumPanel/timelinejobPanel/TimelineJobLineEdit2".text
		var timeline_job = ResourceTimelineJob.new()
		timeline_job.set_data(timeline, timeline2)
		timeline_jobs.append(timeline_job)
	if $"../../CurriculumPanel/timelinejobPanel2/TimelineJobLineEdit".text.length() != 0:
		var timeline = $"../../CurriculumPanel/timelinejobPanel2/TimelineJobLineEdit".text
		var timeline2 = $"../../CurriculumPanel/timelinejobPanel2/TimelineJobLineEdit2".text
		var timeline_job = ResourceTimelineJob.new()
		timeline_job.set_data(timeline, timeline2)
		timeline_jobs.append(timeline_job)
	if $"../../CurriculumPanel/timelinejobPanel3/TimelineJobLineEdit".text.length() != 0:
		var timeline = $"../../CurriculumPanel/timelinejobPanel3/TimelineJobLineEdit".text
		var timeline2 = $"../../CurriculumPanel/timelinejobPanel3/TimelineJobLineEdit2".text
		var timeline_job = ResourceTimelineJob.new()
		timeline_job.set_data(timeline, timeline2)
		timeline_jobs.append(timeline_job)
	if $"../../CurriculumPanel/timelinejobPanel4/TimelineJobLineEdit".text.length() != 0:
		var timeline = $"../../CurriculumPanel/timelinejobPanel4/TimelineJobLineEdit".text
		var timeline2 = $"../../CurriculumPanel/timelinejobPanel4/TimelineJobLineEdit2".text
		var timeline_job = ResourceTimelineJob.new()
		timeline_job.set_data(timeline, timeline2)
		timeline_jobs.append(timeline_job)
	if $"../../CurriculumPanel/timelinejobPanel5/TimelineJobLineEdit".text.length() != 0:
		var timeline = $"../../CurriculumPanel/timelinejobPanel5/TimelineJobLineEdit".text
		var timeline2 = $"../../CurriculumPanel/timelinejobPanel5/TimelineJobLineEdit2".text
		var timeline_job = ResourceTimelineJob.new()
		timeline_job.set_data(timeline, timeline2)
		timeline_jobs.append(timeline_job)
	min_salary = int($"../../CurriculumPanel/MinSalaryLineEdit".text)

	#additional panels
	var detail_payment = ResourcePaymentPanel.new()
	var text_ok
	var text_nok
	var value_ok
	var value_nok
	var special_condition
	if $"../../PanelSecondaryInfo/detailValidationPanel1/TextOKLineEdit".text.length() != 0:
		text_ok = $"../../PanelSecondaryInfo/detailValidationPanel1/TextOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel1/TextNOKLineEdit".text.length() != 0:
		text_nok = $"../../PanelSecondaryInfo/detailValidationPanel1/TextNOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel1/TextOKLineEdit".text.length() != 0:
		value_ok = $"../../PanelSecondaryInfo/detailValidationPanel1/ValueOK".text
	if $"../../PanelSecondaryInfo/detailValidationPanel1/ValueNOK".text.length() != 0:
		value_nok = $"../../PanelSecondaryInfo/detailValidationPanel1/ValueNOK".text
	if (
		$"../../PanelSecondaryInfo/detailValidationPanel1/TypeSpecialConditionOptionMenu".get_selected_id()
		!= -1
	):
		special_condition = $"../../PanelSecondaryInfo/detailValidationPanel1/TypeSpecialConditionOptionMenu".get_selected_id()
		detail_payment._set_data(
			text_ok, text_nok, int(value_ok), int(value_nok), special_condition
		)
		detail_validations.append(detail_payment)

	if $"../../PanelSecondaryInfo/detailValidationPanel2/TextOKLineEdit".text.length() != 0:
		text_ok = $"../../PanelSecondaryInfo/detailValidationPanel2/TextOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel2/TextNOKLineEdit".text.length() != 0:
		text_nok = $"../../PanelSecondaryInfo/detailValidationPanel2/TextNOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel2/TextOKLineEdit".text.length() != 0:
		value_ok = $"../../PanelSecondaryInfo/detailValidationPanel2/ValueOK".text
	if $"../../PanelSecondaryInfo/detailValidationPanel2/ValueNOK".text.length() != 0:
		value_nok = $"../../PanelSecondaryInfo/detailValidationPanel2/ValueNOK".text
	if (
		$"../../PanelSecondaryInfo/detailValidationPanel2/TypeSpecialConditionOptionMenu".get_selected_id()
		!= -1
	):
		special_condition = $"../../PanelSecondaryInfo/detailValidationPanel2/TypeSpecialConditionOptionMenu".get_selected_id()
		detail_payment._set_data(
			text_ok, text_nok, int(value_ok), int(value_nok), special_condition
		)
		detail_validations.append(detail_payment)

	if $"../../PanelSecondaryInfo/detailValidationPanel3/TextOKLineEdit".text.length() != 0:
		text_ok = $"../../PanelSecondaryInfo/detailValidationPanel3/TextOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel3/TextNOKLineEdit".text.length() != 0:
		text_nok = $"../../PanelSecondaryInfo/detailValidationPanel3/TextNOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel3/TextOKLineEdit".text.length() != 0:
		value_ok = $"../../PanelSecondaryInfo/detailValidationPanel3/ValueOK".text
	if $"../../PanelSecondaryInfo/detailValidationPanel3/ValueNOK".text.length() != 0:
		value_nok = $"../../PanelSecondaryInfo/detailValidationPanel3/ValueNOK".text
	if (
		$"../../PanelSecondaryInfo/detailValidationPanel3/TypeSpecialConditionOptionMenu".get_selected_id()
		!= -1
	):
		special_condition = $"../../PanelSecondaryInfo/detailValidationPanel3/TypeSpecialConditionOptionMenu".get_selected_id()
		detail_payment._set_data(
			text_ok, text_nok, int(value_ok), int(value_nok), special_condition
		)
		detail_validations.append(detail_payment)

	if $"../../PanelSecondaryInfo/detailValidationPanel4/TextOKLineEdit".text.length() != 0:
		text_ok = $"../../PanelSecondaryInfo/detailValidationPanel4/TextOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel4/TextNOKLineEdit".text.length() != 0:
		text_nok = $"../../PanelSecondaryInfo/detailValidationPanel4/TextNOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel4/TextOKLineEdit".text.length() != 0:
		value_ok = $"../../PanelSecondaryInfo/detailValidationPanel4/ValueOK".text
	if $"../../PanelSecondaryInfo/detailValidationPanel4/ValueNOK".text.length() != 0:
		value_nok = $"../../PanelSecondaryInfo/detailValidationPanel4/ValueNOK".text
	if (
		$"../../PanelSecondaryInfo/detailValidationPanel4/TypeSpecialConditionOptionMenu".get_selected_id()
		!= -1
	):
		special_condition = $"../../PanelSecondaryInfo/detailValidationPanel4/TypeSpecialConditionOptionMenu".get_selected_id()
		detail_payment._set_data(
			text_ok, text_nok, int(value_ok), int(value_nok), special_condition
		)
		detail_validations.append(detail_payment)

	if $"../../PanelSecondaryInfo/detailValidationPanel5/TextOKLineEdit".text.length() != 0:
		text_ok = $"../../PanelSecondaryInfo/detailValidationPanel5/TextOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel5/TextNOKLineEdit".text.length() != 0:
		text_nok = $"../../PanelSecondaryInfo/detailValidationPanel5/TextNOKLineEdit".text
	if $"../../PanelSecondaryInfo/detailValidationPanel5/TextOKLineEdit".text.length() != 0:
		value_ok = $"../../PanelSecondaryInfo/detailValidationPanel5/ValueOK".text
	if $"../../PanelSecondaryInfo/detailValidationPanel5/ValueNOK".text.length() != 0:
		value_nok = $"../../PanelSecondaryInfo/detailValidationPanel5/ValueNOK".text
	if (
		$"../../PanelSecondaryInfo/detailValidationPanel5/TypeSpecialConditionOptionMenu".get_selected_id()
		!= -1
	):
		special_condition = $"../../PanelSecondaryInfo/detailValidationPanel5/TypeSpecialConditionOptionMenu".get_selected_id()
		detail_payment._set_data(
			text_ok, text_nok, int(value_ok), int(value_nok), special_condition
		)
		detail_validations.append(detail_payment)


func _generate_question_answer(dictionary, _key, _question, _answer):
	dictionary[_key] = {key = _key, question = _question, answer = _answer}


func _generate_puzzle():
	var puzzle = Puzzle.new()
	puzzle.instantiate(
		applicant_name,
		applicant_image,
		validate_solution,
		description,
		dummy_comments,
		work_type,
		difficulty,
		level_day,
		time_limit,
		requisites_answers,
		cross_questions,
		salary_offer,
		special_condition,
		skills_answers,
		timeline_jobs,
		min_salary,
		validation_response,
		detail_validations,
		company_name,
		category_job,
		payment_salary
	)

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
