extends Control

class_name ResumeManager

signal end_applicants_resume
signal update_month_balance(month_balance)
signal set_event_message(event_message)
signal send_extra_payment_events(payment_events)
signal send_penalty_payment_events(penalty_events)

export(PackedScene) onready var detail_applicant

var applicant_result_list: Array
var events_file: MonthEvents
var extra_events_file: EventsExtra
var events_penalty: EventsExtra
var current_applicant_index = 0
var current_salary_amount = 0


func _ready():
	$Panel/CurrentMonth.text = "Current month: " + String(Global.current_month)
	$Panel/NextResumeButton.connect("load_next", self, "_load_next_applicant")
	$Panel/NextResumeButton.connect(
		"enabled_next_resume_panel", self, "_enable_payment_panel_button"
	)
	$Panel/PaymentPanelButton.connect("load_payment_panel", self, "_change_to_payment_resume_panel")
	self.connect("update_month_balance", $Panel/PaymentPanel, "_update_balance_month")  #actualizar parametros antes de cargar el panel de resumen pagos
	self.connect("set_event_message", $Panel/PaymentPanel, "_set_narrative_message")
	self.connect("send_extra_payment_events", $Panel/PaymentPanel, "set_payment_extra_bills")
	self.connect("send_penalty_payment_events", $Panel/PaymentPanel, "set_penalty_bills")
	_load_applicants()
	_init_applicant_ui(applicant_result_list[current_applicant_index])


func _load_applicants():  #TODO carga dinamica
	for applicant in Global.current_applicants_result:
		applicant_result_list.append(applicant)


func _init_applicant_ui(applicant: ApplicantResult):
#	$Panel/resumeContainer/applicantImage.texture = applicant.image_applicant #TODO load from path
	$Panel/resumeContainer/FullNameLabel.text = applicant.full_name
	$Panel/resumeContainer/CategoryCompanyLabel.text = (
		applicant.category_job
		+ " at "
		+ applicant.company_name
	)
	$Panel/resumeContainer/PaymentAmountLabel.text = String(applicant.current_salary_applicant)
	#clean panel childs
	if $Panel/resumeContainer/DetailHBoxContainer.get_children().size() > 0:
		for detail_child in $Panel/resumeContainer/DetailHBoxContainer.get_children():
			$Panel/resumeContainer/DetailHBoxContainer.remove_child(detail_child)

	for detail in applicant.details_applicant:
		var new_detail: DetailResumePanel = detail_applicant.instance()
		new_detail.set_value(detail.value_text, detail.value)
		$Panel/resumeContainer/DetailHBoxContainer.add_child(new_detail)
	applicant.update_current_salary_by_details()


func _load_next_applicant():
	_calculate_amount_by_applicant()
	current_applicant_index = current_applicant_index + 1
	_init_applicant_ui(applicant_result_list[current_applicant_index])
	if current_applicant_index + 1 == applicant_result_list.size():
		emit_signal("end_applicants_resume")


func _calculate_amount_by_applicant():
	current_salary_amount += applicant_result_list[current_applicant_index].current_salary_applicant


func _enable_payment_panel_button():
	$Panel/PaymentPanelButton.visible = true


func _change_to_payment_resume_panel():
	events_file = Global.get_events_by_month(EnumUtils.TypeFolder.RESUME)
	var current_event = Global.get_message_from_event(events_file.get_event_list())
	_apply_message_event(current_event)

	extra_events_file = Global.get_events_by_month(EnumUtils.TypeFolder.EXTRA)
	if extra_events_file:
		_send_extra_events(extra_events_file.events_list)

	_calculate_amount_by_applicant()

	print(
		(
			"Tu sueldo de este mes es : "
			+ String(current_salary_amount)
			+ "en el banco tienes: "
			+ String(Global.current_salary_amount)
		)
	)
	_set_values_by_difficulty()
	Global.current_month_salary_amount = current_salary_amount
	emit_signal("update_month_balance", current_salary_amount)
	print(
		(
			"Tu sueldo de este mes es : "
			+ String(current_salary_amount)
			+ "en el banco tienes: "
			+ String(Global.current_salary_amount)
		)
	)

	events_penalty = Global.get_penalty_payments()  # se pasan aqui por que tienen que aplicarse sobre el saldo actual
	if events_penalty:
		_send_penalty_events(events_penalty.events_list)

	$Panel/resumeContainer.visible = false
	$Panel/PaymentPanel.visible = true


func _set_values_by_difficulty():
	#control brujula para dar dinero adicional o quitarlo
	if Global.moral_compass_applicants == Global.moral_compass_company:
		pass
	if Global.moral_compass_applicants > Global.moral_compass_company:
		current_salary_amount -= _get_modifier_salary_by_difficulty()
		print(
			(
				" se le resta a tu sueldo "
				+ String(_get_modifier_salary_by_difficulty())
				+ "por ayudar a los candidatos. "
			)
		)
	if Global.moral_compass_applicants < Global.moral_compass_company:
		current_salary_amount += _get_modifier_salary_by_difficulty()
		print(
			(
				" se le suma a tu sueldo "
				+ String(_get_modifier_salary_by_difficulty())
				+ "por ayudar a las empresas. "
			)
		)


func _get_modifier_salary_by_difficulty():
	match Global.current_month:
		Time.MONTH_JANUARY:
			return 0
		Time.MONTH_FEBRUARY:
			return 150
		Time.MONTH_MARCH:
			return 300
		Time.MONTH_APRIL:
			return 450
		Time.MONTH_MAY:
			return 600
		Time.MONTH_JUNE:
			return 850


func _apply_message_event(current_event):
	emit_signal("set_event_message", current_event.event_message)


func _send_extra_events(extra_events):
	emit_signal("send_extra_payment_events", extra_events)


func _send_penalty_events(penalty_events):
	emit_signal("send_penalty_payment_events", penalty_events)
