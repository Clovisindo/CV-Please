extends Control
class_name resumeManager

export(PackedScene) onready var detail_applicant

var applicant_result_list:Array 
var current_applicant_index = 0

signal end_applicants_resume()

func _ready():
	$Panel/NextResumeButton.connect("load_next", self, "_load_next_applicant")
	$Panel/NextResumeButton.connect("enabled_next_resume_panel", self, "_enable_payment_panel_button")
	$Panel/PaymentPanelButton.connect("load_payment_panel", self, "_change_to_payment_resume_panel")
	_load_applicants()
	_load_payment_resume()
	_init_first_applicant_UI(applicant_result_list[current_applicant_index])


func _load_applicants():#TODO carga dinamica
	var details_app = [	"The company is very pleased  with the applicant: +50€",
	"The company has paid a bonus for meeting your special requirements. + 50",
	"Bonus for finishing the interview quickly. + 50€"]
	var applicant_result = ApplicantResult.new("Damian Mendez Gonzalez","image.png","Junior programmer"," at Nunogal S.A",ApplicantResult.Status.VALID,details_app)
	applicant_result_list.append(applicant_result)
	var details_app2 = [	"The company is very upset  with the applicant: -50€",
	"the company penalizes you for the time lost. -50€",
	"test"]
	var applicant_result2 = ApplicantResult.new("Adrian Novoa","image.png","Sennior programmer"," at Kyndell S.A",ApplicantResult.Status.NOT_VALID,details_app2)
	applicant_result_list.append(applicant_result2)
	applicant_result_list.append(applicant_result)


func _load_payment_resume():
	payment_resume.new()


func _init_first_applicant_UI(applicant:ApplicantResult):
#	$Panel/resumeContainer/applicantImage.texture = applicant.image_applicant #TODO load from path
	$Panel/resumeContainer/FullNameLabel.text = applicant.full_name
	$Panel/resumeContainer/CategoryCompanyLabel.text = applicant.category_job + applicant.company_name
	$Panel/resumeContainer/DetailHBoxContainer/DetailApplicantPanel/DetailApplicantLabel.text = applicant.details_applicant[0]
	$Panel/resumeContainer/DetailHBoxContainer/DetailApplicantPanel2/DetailApplicantLabel.text = applicant.details_applicant[1]
	$Panel/resumeContainer/DetailHBoxContainer/DetailApplicantPanel3/DetailApplicantLabel.text = applicant.details_applicant[2]


func _load_next_applicant():
	current_applicant_index = current_applicant_index + 1
	_init_first_applicant_UI(applicant_result_list[current_applicant_index])
	if current_applicant_index + 1 == applicant_result_list.size():
		emit_signal("end_applicants_resume")


func _enable_payment_panel_button():
	$Panel/PaymentPanelButton.visible = true


func _change_to_payment_resume_panel():
	$Panel/resumeContainer.visible = false
	$Panel/PaymentPanel.visible = true
