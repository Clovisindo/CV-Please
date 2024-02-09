extends Node
class_name applicationResult

var timeInterview
var solution# EnumUtils.ApplicationResult
var result = false


func _init_appl_result(_solution):
	solution =  _solution

func _checkResultApplicant(resultPlayer, timeSpent):
	if(resultPlayer == solution):
		result = true
	timeInterview = timeSpent
