extends Node
class_name applicationResult

var timeInterview
export (EnumUtils.ApplicantResult) var solution  = EnumUtils.ApplicantResult.VALID
var result = false

func _init_appl_result(_solution):
	solution =  _solution

func _validate_result_applicant(resultPlayer, timeSpent):
	if(resultPlayer == solution):
		result = true
	timeInterview = timeSpent
