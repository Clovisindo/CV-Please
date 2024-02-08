extends Node

var timeInterview
var solution 
var result = false

func _init_appl_result(_solution):
	solution =  _solution

func _checkResultApplicant(resultPlayer, timeSpent):
	if(resultPlayer == solution):
		solution = true
	timeInterview = timeSpent
