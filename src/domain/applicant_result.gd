extends Node

class_name ApplicantResult

enum Status {
	VALID,
	NOT_VALID,
}

var full_name
var image_applicant
var category_job
var company_name
var current_status
var details_applicant 
var current_salary_applicant = 0


func _init(_full_name, _image, _category, _company_name, _status, _salary, _details_app) -> void:
	full_name = _full_name
	image_applicant = _image
	category_job = _category
	company_name = _company_name
	current_status = _status
	current_salary_applicant = _salary
	if _details_app:
		details_applicant = _details_app
		for detail in details_applicant:
			if detail.money_balance:
				current_salary_applicant = current_salary_applicant + detail.value
			else:
				current_salary_applicant = current_salary_applicant - detail.value


func update_current_salary_by_details():
	for detail in details_applicant:
		current_salary_applicant += detail.value
