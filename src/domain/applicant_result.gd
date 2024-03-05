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

func _init(_full_name, _image, _category, _company_name, _status, _details_app) -> void:
	full_name = _full_name
	image_applicant = _image
	category_job = _category
	company_name = _company_name
	current_status = _status
	details_applicant = _details_app
