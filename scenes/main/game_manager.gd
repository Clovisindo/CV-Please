extends Node2D
class_name GameManager

signal company_alert_message
signal emit_message_to_player_dialog_box
signal emit_message_to_applicant_dialog_box

const TURN_VALUE_REQUISITE = 1
const TURN_VALUE_SKILL = 1
const TURN_VALUE_CROSS = 2

export(PackedScene) onready var applicant_scene
export(PackedScene) onready var decision_applicant_scene
export(PackedScene) onready var interaction_dialog_scene

var applicant_list = []
var current_applicant_index = 0
var main_computer
var company_computer
var company_computer_decision: ValidationCompanyComputer
var current_interaction_dialog: InteractionDialog
var computer_interaction_dialog
var player_dialog_box: DialogBox
var applicant_dialog_box: DialogBox
var datetime_panel: DateTimePanel

var events_file: MonthEvents


func _ready():
	$MainScene/CurrentMonth.text = "Current month: " + String(Global.current_month)
	player_dialog_box = $MainScene/PlayerDialogBox
	applicant_dialog_box = $MainScene/ApplicantDialogBox
	computer_interaction_dialog = $MainScene/ChatLogKeyboard
	main_computer = $MainScene/MainComputer
	company_computer = $MainScene/CompanyComputer
	datetime_panel = $MainScene/DateTimePanel
	datetime_panel.set_current_month(Global.current_month)
	_instantiate_panels()
	_wire_events()
	_load_next_applicant()
	_load_initial_event_message()


func _load_initial_event_message():
	events_file = Global.get_events_by_month(EnumUtils.TypeFolder.MAIN)
	var current_event = Global.get_message_from_event(events_file.get_event_list())
	emit_signal("company_alert_message", current_event.event_message)  # mandar mensaje a popup


func _wire_events():
	company_computer_decision.connect("decision_made", self, "_apply_applicant_decision")
	company_computer_decision.connect("decision_cancel", self, "on_unload_company_validation")
	$MainScene/EndWorkingDayButton.connect("pressed", self, "_on_working_day_ended")
	current_interaction_dialog.connect("reference_used", self, "_on_reference_used")
	$MainScene/MainComputer.connect("interaction_started", self, "_on_interaction_started")
	$MainScene/MainComputer.connect("interaction_ended", self, "_on_interaction_ended")
	$MainScene/CompanyComputer.connect(
		"show_computer_validation", self, "on_load_company_validation"
	)  # mostrar panel decision
	$MainScene/CompanyComputer.connect(
		"end_computer_validation", self, "on_unload_company_validation"
	)  #ocultar panel decision
	self.connect("company_alert_message", $MainScene/CompanyAlertsPanel, "_show_panel_alert")
	self.connect("emit_message_to_player_dialog_box", player_dialog_box, "_show_current_message")
	self.connect(
		"emit_message_to_applicant_dialog_box", applicant_dialog_box, "_show_current_message"
	)
	player_dialog_box.connect("finished_displaying", self, "_on_player_dialog_finished")
	applicant_dialog_box.connect("finished_displaying", self, "_on_player_dialog_finished")
	computer_interaction_dialog.connect(
		"show_chat_log", current_interaction_dialog, "_show_window_chat"
	)
	computer_interaction_dialog.connect(
		"hide_chat_log", current_interaction_dialog, "_hide_window_chat"
	)
	$MainScene/ApplicantCrossMode.connect("enable_cross_mode", self, "on_enabled_cross_mode")
	$MainScene/ApplicantCrossMode.connect("disable_cross_mode", self, "on_disabled_cross_mode")


func on_new_applicant_computer(applicant):  #inicia mainComputer con el applicant actual
	$MainScene/MainComputer.load_applicant_computer(applicant)


func on_unload_applicant_computer(applicant):  #inicia mainComputer con el applicant actual
	$MainScene/MainComputer.unload_applicant_computer()
	_on_interaction_ended(applicant)


func on_load_company_validation():
	open_panel_tween(company_computer_decision, company_computer)
	set_process_unhandled_input(true)


func on_unload_company_validation():
	close_panel_tween(company_computer_decision, company_computer)
	set_process_unhandled_input(true)


func open_panel_tween(panel_node, target_event_fired):
	panel_node.rect_scale.x = 0
	panel_node.rect_scale.y = 0
	panel_node.visible = true
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(panel_node, "rect_scale", Vector2(1, 1), 1)
	yield(tween, "finished")
	target_event_fired.event_fired = false


func close_panel_tween(panel_node, target_event_fired):
	panel_node.rect_scale.x = 1
	panel_node.rect_scale.y = 1
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(panel_node, "rect_scale", Vector2(0, 0), 1)
	yield(tween, "finished")
	panel_node.visible = false
	target_event_fired.event_fired = false


func on_load_company_computer():  #inicia mainComputer con el applicant actual
	$MainScene/CompanyComputer.load_company_computer()


func on_unload_company_computer():  #quita mainComputer con el applicant actual
	$MainScene/CompanyComputer.unload_company_computer()


func on_load_cross_mode():
	$MainScene/ApplicantCrossMode.on_enable_button_cross_mode()


func on_unload_cross_mode():
	$MainScene/ApplicantCrossMode.on_disable_button_cross_mode()


func on_enabled_cross_mode():
	applicant_list[current_applicant_index].get_cv().save_previous_state()
	applicant_list[current_applicant_index].get_cv().enable_cross_skills()
	applicant_list[current_applicant_index].get_job_offer().save_previous_state()
	applicant_list[current_applicant_index].get_job_offer().enable_cross_requisites()


func on_disabled_cross_mode():
	applicant_list[current_applicant_index].get_cv().disable_cross_skills()
	applicant_list[current_applicant_index].get_job_offer().disable_cross_requisites()


func execute_cross_question():
	$MainScene/CompanyComputer.disabled = true
	$MainScene/ApplicantCrossMode.on_disable_button_cross_mode()
	# mirar si tenemos una de requisitos y otra de skills en cross_in_progress , arrancamos la pregunta
	#deshabilitamos todos los demas de ese grupo, solo se puede elegir en modo cross una
	var cross_requisite = applicant_list[current_applicant_index].get_job_offer().get_cross_requisite()
	var cross_skill = applicant_list[current_applicant_index].get_cv().get_cross_skill()

	if cross_requisite != null && cross_skill != null:
		#buscamos si existe la cross question
		#vamos a ver si esta cargado en el applicant y como matcheamos
		var result_cross = applicant_list[current_applicant_index].get_cross_question(
			cross_requisite.requisite_name, cross_skill.skill_name
		)
		current_interaction_dialog.add_interaction_line(
			QuestionAnswer.new(cross_requisite.requisite_name, cross_skill.skill_name)
		)
		if result_cross != null:
			current_interaction_dialog.add_interaction_line(
				QuestionAnswer.new(result_cross.question, result_cross.answer)
			)
			applicant_list[current_applicant_index].add_turn_count(TURN_VALUE_CROSS)
			emit_signal(
				"emit_message_to_player_dialog_box",
				applicant_list[current_applicant_index].applicant_name,
				result_cross.question,
				result_cross.answer,
				EnumUtils.TypeDialogBox.PLAYER
			)
		#mandamos al acabar todas las skills y requisites al estado previo
		else:
			current_interaction_dialog.add_interaction_line(
				QuestionAnswer.new("dummy", "dummy response")
			)
			emit_signal(
				"emit_message_to_player_dialog_box",
				applicant_list[current_applicant_index].applicant_name,
				"dummy",
				"dummy response",
				EnumUtils.TypeDialogBox.PLAYER
			)
			applicant_list[current_applicant_index].add_turn_count(TURN_VALUE_SKILL)  #castigamos solo con un turno
		applicant_list[current_applicant_index].get_job_offer().previous_state_skills()
		applicant_list[current_applicant_index].get_cv().previous_state_skills()
		$MainScene/ApplicantCrossMode.on_disable_button_cross_mode()
		$MainScene/CompanyComputer.disabled = false


func _on_player_dialog_finished(applicant_name, applicant_message, type_dialog_box):
	if type_dialog_box == EnumUtils.TypeDialogBox.APPLICANT:
		emit_signal(
			"emit_message_to_applicant_dialog_box",
			applicant_name,
			applicant_message,
			"",
			type_dialog_box
		)
	else:
		applicant_list[current_applicant_index].get_cv().enable_skills()
		applicant_list[current_applicant_index].get_job_offer().enable_requisites()
		$MainScene/ApplicantCrossMode.on_enable_button_cross_mode()
		$MainScene/CompanyComputer.disabled = false


func _on_interaction_started(applicant):
	open_panel_tween($MainScene/CVContainer, main_computer)
	$MainScene/CVContainer.add_child(applicant.get_cv())
	open_panel_tween($MainScene/JobOfferContainer, main_computer)
	$MainScene/JobOfferContainer.add_child(applicant.get_job_offer())
	applicant.get_cv().connect("skill_selected", self, "_on_skill_selected")
	applicant.get_job_offer().connect("job_requisite_selected", self, "_on_job_requisite_selected")
	applicant.get_job_offer().connect("job_condition_selected", self, "_on_job_condition_selected")
	on_load_cross_mode()
	set_process_unhandled_input(true)


func _on_interaction_ended(applicant):
	close_panel_tween($MainScene/CVContainer, main_computer)
	$MainScene/CVContainer.remove_child(applicant.get_cv())
	close_panel_tween($MainScene/JobOfferContainer, main_computer)
	$MainScene/JobOfferContainer.remove_child(applicant.get_job_offer())
	on_unload_cross_mode()
	set_process_unhandled_input(true)


func _on_skill_selected(skill: SkillPanel):
	$MainScene/CompanyComputer.disabled = true
	# No pasamos parametro por que la actual se va a otro estando distinto por el input
	applicant_list[current_applicant_index].get_cv().disable_skills()
	applicant_list[current_applicant_index].get_job_offer().disable_requisites()
	$MainScene/ApplicantCrossMode.on_disable_button_cross_mode()
	applicant_list[current_applicant_index].add_turn_count(TURN_VALUE_SKILL)
	current_interaction_dialog.add_interaction_line(
		QuestionAnswer.new(skill.skill_question, skill.skill_answer)
	)
	emit_signal(
		"emit_message_to_player_dialog_box",
		applicant_list[current_applicant_index].applicant_name,
		skill.skill_question,
		skill.skill_answer,
		EnumUtils.TypeDialogBox.PLAYER
	)


func _on_job_requisite_selected(job_requisite: JobRequisite):
	$MainScene/CompanyComputer.disabled = true
	applicant_list[current_applicant_index].get_job_offer().disable_requisites()
	applicant_list[current_applicant_index].get_cv().disable_skills()
	$MainScene/ApplicantCrossMode.on_disable_button_cross_mode()
	applicant_list[current_applicant_index].add_turn_count(TURN_VALUE_REQUISITE)
	current_interaction_dialog.add_interaction_line(
		QuestionAnswer.new(job_requisite.requisite_question, job_requisite.requisite_answer)
	)
	emit_signal(
		"emit_message_to_player_dialog_box",
		applicant_list[current_applicant_index].applicant_name,
		job_requisite.requisite_question,
		job_requisite.requisite_answer,
		EnumUtils.TypeDialogBox.PLAYER
	)


func _on_job_condition_selected(job_condition: JobSpecialCondition):
	applicant_list[current_applicant_index].get_job_offer().disable_requisites()
	applicant_list[current_applicant_index].get_cv().disable_skills()
	$MainScene/ApplicantCrossMode.on_disable_button_cross_mode()
	applicant_list[current_applicant_index].add_turn_count(TURN_VALUE_REQUISITE)
	current_interaction_dialog.add_interaction_line(
		QuestionAnswer.new(job_condition.question_player, job_condition.response_applicant)
	)
	emit_signal(
		"emit_message_to_player_dialog_box",
		applicant_list[current_applicant_index].applicant_name,
		job_condition.question_player,
		job_condition.response_applicant,
		EnumUtils.TypeDialogBox.PLAYER
	)


func _apply_applicant_decision(evaluation_status: String):
	var current_applicant = applicant_list[current_applicant_index]
	if (
		current_applicant.get_status() is StateApplicantReviewing
		and current_applicant.get_cv().get_status() is StateCVActive
	):
		_process_applicant(current_applicant, evaluation_status)
	else:
		emit_signal("company_alert_message", "Ask something about CV.")


func _instantiate_panels():
	# Static Panels
	company_computer_decision = get_node("MainScene/ValidationCompanyComputer")
	current_interaction_dialog = interaction_dialog_scene.instance()
	$MainScene/InteractionDialogContainer.add_child(current_interaction_dialog)

	# Dynamic Panels
	for puzzle in PuzzleManager.get_all_puzzle():
		var new_applicant = applicant_scene.instance()
		new_applicant.add_data(
			puzzle.applicant_name,
			puzzle.skills_answers,
			puzzle.requisites_answers,
			puzzle.company_name,
			puzzle.timeline_jobs,
			puzzle.special_condition,
			puzzle.cross_questions,
			puzzle.category_job,
			puzzle.validate_solution,
			puzzle.payment_salary,
			puzzle.min_salary,
			puzzle.salary_offer,
			puzzle.detail_validations,
			puzzle.time_limit
		)
		new_applicant.set_positions_applicant(
			$MainScene/ApplicantContainer/ApplicantEntrancePosition.position,
			$MainScene/ApplicantContainer/ApplicantMiddlePosition.position,
			$MainScene/ApplicantContainer/ApplicantInterviewPosition.position
		)
		applicant_list.append(new_applicant)
		wired_events_applicant(new_applicant)
		new_applicant.get_cv().wired_events(self)
		new_applicant.get_job_offer().wired_events(self)


func wired_events_applicant(new_applicant: Applicant):
	new_applicant.connect("load_computer_applicant", self, "on_new_applicant_computer")
	new_applicant.connect("unload_computer_applicant", self, "on_unload_applicant_computer")
	new_applicant.connect("load_company_computer_applicant", self, "on_load_company_computer")
	new_applicant.connect("unload_company_computer_applicant", self, "on_unload_company_computer")


func _on_working_day_ended():
	var list_applicant_result = []
	for applicant in applicant_list:
		list_applicant_result.append(applicant.evaluation)
		if applicant.get_status() is StateApplicantEvaluated:
			if applicant.get_cv().get_status() is StateCVApproved:
				print(
					(
						"Applicant %s is accepted, it was valid?: %s"
						% [applicant.applicant_name, applicant.is_valid_applicant]
					)
				)
			elif applicant.get_cv().get_status() is StateCVRejected:
				print(
					(
						"Applicant %s is rejected, it was valid?: %s"
						% [applicant.applicant_name, applicant.is_valid_applicant]
					)
				)
	Global.set_applicants_result_for_day(list_applicant_result)
	LoadManager.load_scene(self, "res://scenes/game/items/resume/applicant_resume.tscn")


func _process_applicant(applicant: Applicant, evaluation_status: String):
	applicant.process_applicant(evaluation_status)
	process_validations_applicant(applicant)
	current_applicant_index += 1
	on_unload_company_validation()
	_load_next_applicant()


func process_validations_applicant(applicant: Applicant):
	for detail in applicant.detail_validations:
		if detail.type_special_condition == EnumUtils.TypeSpecialCondition.CORRECT_APPLICANT:
			if (
				applicant.is_valid_applicant == true
				&& (
					applicant.evaluation.current_status
					== ApplicantResult.Status.keys()[ApplicantResult.Status.VALID]
				)
			):
				detail.set_value(detail.value_text_ok, detail.value_ok)
			else:
				detail.set_value(detail.value_text_nok, detail.value_nok)
		if detail.type_special_condition == EnumUtils.TypeSpecialCondition.INCORRECT_APPLICANT:
			if (
				applicant.is_valid_applicant == false
				&& (
					applicant.evaluation.current_status
					== ApplicantResult.Status.keys()[ApplicantResult.Status.NOT_VALID]
				)
			):
				detail.set_value(detail.value_text_ok, detail.value_ok)
			else:
				detail.set_value(detail.value_text_nok, detail.value_nok)
		if detail.type_special_condition == EnumUtils.TypeSpecialCondition.TIME_CHECK:
			if applicant.turns_count <= applicant.validation_turns:
				detail.set_value(detail.value_text_ok, detail.value_ok)
				datetime_panel.set_datetime_by_validation(true)
			else:
				detail.set_value(detail.value_text_nok, detail.value_nok)
				datetime_panel.set_datetime_by_validation(false)
		if detail.type_special_condition == EnumUtils.TypeSpecialCondition.APPLICANT_NO_EXPERIENCE:
			# hay que tener en cuenta si lo acepta o no
			if (
				applicant.is_valid_applicant == true
				&& (
					applicant.evaluation.current_status
					== ApplicantResult.Status.keys()[ApplicantResult.Status.VALID]
				)
			):
				detail.set_value(detail.value_text_nok, detail.value_nok)
				Global.moral_compass_applicants = 1
				Global.moral_compass_company = -1
			else:
				detail.set_value(detail.value_text_ok, detail.value_ok)
				Global.moral_compass_applicants = -1
				Global.moral_compass_company = 1

		applicant.evaluation.details_applicant = applicant.detail_validations


func _load_next_applicant():
	if applicant_list.size() - 1 >= current_applicant_index:
		$MainScene/ApplicantContainer.add_child(applicant_list[current_applicant_index])
	else:
		$MainScene/EndWorkingDayButton.visible = true
