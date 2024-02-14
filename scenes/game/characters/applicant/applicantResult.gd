extends Node
class_name applicationResult

var timeInterview
export (EnumUtils.applicantSolution) var solution  = EnumUtils.applicantSolution.valid
var result = false

func _init_appl_result(_solution):
	solution =  _solution

func _validate_result_applicant(resultPlayer, timeSpent):
	if(resultPlayer == solution):
		result = true
	timeInterview = timeSpent
