extends Control
class_name resumeManager

export(PackedScene) onready var detail_applicant

var applicant_result_list:Array 
var current_applicant_index = 0


func _ready():
	
	_load_applicants()
	_init_first_applicant_UI(applicant_result_list[0])

func _load_applicants():
	var details_app = [	"The company is very pleased  with the applicant: +50€",
	"The company has paid a bonus for meeting your special requirements. + 50",
	"Bonus for finishing the interview quickly. + 50€"]
	var applicant_result = ApplicantResult.new("Damian Mendez Gonzalez","image.png","Junior programmer","at Nunogal S.A",ApplicantResult.Status.VALID,details_app)
	applicant_result_list.append(applicant_result)
	applicant_result_list.append(applicant_result)
	applicant_result_list.append(applicant_result)


func _init_first_applicant_UI(applicant:ApplicantResult):
#	$Panel/resumeContainer/applicantImage.texture = applicant.image_applicant #TODO load from path
	$Panel/resumeContainer/FullNameLabel.text = applicant.full_name
	$Panel/resumeContainer/CategoryCompanyLabel.text = applicant.category_job + applicant.company_name
	
