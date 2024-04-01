extends Control

class_name ResumeManager

export(PackedScene) onready var detail_applicant

var applicant_result_list:Array 
var current_applicant_index = 0
var current_salary_amount = 0

signal end_applicants_resume()


func _ready():
	$Panel/NextResumeButton.connect("load_next", self, "_load_next_applicant")
	$Panel/NextResumeButton.connect("enabled_next_resume_panel", self, "_enable_payment_panel_button")
	$Panel/PaymentPanelButton.connect("load_payment_panel", self, "_change_to_payment_resume_panel")
	_load_applicants()
	_init_applicant_UI(applicant_result_list[current_applicant_index])


func _load_applicants():#TODO carga dinamica
	for applicant in Global.current_applicants_result:
		
		applicant_result_list.append(applicant)


func _init_applicant_UI(applicant:ApplicantResult):
#	$Panel/resumeContainer/applicantImage.texture = applicant.image_applicant #TODO load from path
	$Panel/resumeContainer/FullNameLabel.text = applicant.full_name
	$Panel/resumeContainer/CategoryCompanyLabel.text = applicant.category_job + " at " + applicant.company_name
	
	#clean panel childs
	if $Panel/resumeContainer/DetailHBoxContainer.get_children().size() > 0:
		for detail_child in $Panel/resumeContainer/DetailHBoxContainer.get_children():
			$Panel/resumeContainer/DetailHBoxContainer.remove_child(detail_child)
	
	for detail in applicant.details_applicant:
		var new_detail:DetailResumePanel = detail_applicant.instance()
		new_detail._set_value(detail.value_text,detail.value)
		$Panel/resumeContainer/DetailHBoxContainer.add_child(new_detail)


func _load_next_applicant():
	_calculate_amount_by_applicant()
	current_applicant_index = current_applicant_index + 1
	_init_applicant_UI(applicant_result_list[current_applicant_index])
	if current_applicant_index + 1 == applicant_result_list.size():
		emit_signal("end_applicants_resume")


func _calculate_amount_by_applicant():
	current_salary_amount +=  applicant_result_list[current_applicant_index].current_salary_applicant


func _enable_payment_panel_button():
	$Panel/PaymentPanelButton.visible = true


func _change_to_payment_resume_panel():
	_calculate_amount_by_applicant()
	$Panel/resumeContainer.visible = false
	$Panel/PaymentPanel.visible = true
