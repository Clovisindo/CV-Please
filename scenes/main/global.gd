extends Node

#var current_applicants_result:ApplicantResult
var current_applicants_result = []

var current_salary_amount = 0
var current_month_salary_amount = 0

func set_applicants_result_for_day(app_list):
	current_applicants_result = app_list
