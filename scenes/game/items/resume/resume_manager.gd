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
	var details_app:Array
	var detail1 = DetailApplicantResume.new()
	detail1._set_value("The company is very pleased  with the applicant: ", 50, true)
	details_app.append(detail1)
	var detail2 = DetailApplicantResume.new()
	detail2._set_value("The company has paid a bonus for meeting your special requirements. ", 50, true)
	details_app.append(detail2)
	var detail3 = DetailApplicantResume.new()
	detail3._set_value("Bonus for finishing the interview quickly. ", 50, true)
	details_app.append(detail3)
	
	
	var applicant_result = ApplicantResult.new("Damian Mendez Gonzalez","image.png","Junior programmer"," at Nunogal S.A",ApplicantResult.Status.VALID,details_app)
	applicant_result_list.append(applicant_result)
	
	var details_app2:Array

	var detail4 = DetailApplicantResume.new()
	detail4._set_value("The company is very upset  with the applicant: ", 50, false)
	details_app2.append(detail4)
	var detail5 = DetailApplicantResume.new()
	detail5._set_value("the company penalizes you for the time lost. ", 50, false)
	details_app2.append(detail5)
	var detail6 = DetailApplicantResume.new()
	detail6._set_value("test.", 50, true)
	details_app2.append(detail6)
	
	var applicant_result2 = ApplicantResult.new("Adrian Novoa","image.png","Sennior programmer"," at Kyndell S.A",ApplicantResult.Status.NOT_VALID,details_app2)
	applicant_result_list.append(applicant_result2)
	applicant_result_list.append(applicant_result)


func _init_applicant_UI(applicant:ApplicantResult):
#	$Panel/resumeContainer/applicantImage.texture = applicant.image_applicant #TODO load from path
	$Panel/resumeContainer/FullNameLabel.text = applicant.full_name
	$Panel/resumeContainer/CategoryCompanyLabel.text = applicant.category_job + applicant.company_name
	
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
