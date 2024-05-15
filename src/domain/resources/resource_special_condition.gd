extends Resource

class_name ResourceSpecialCondition

export(EnumUtils.TypeSpecialCondition) var special_condition
export var condition_name: String
export var question_player: String
export var response_applicant: String


func _init() -> void:
	self.special_condition = special_condition
	self.condition_name = condition_name
	self.question_player = question_player
	self.response_applicant = response_applicant


func set_data(_special_condition, _condition_name, _question_player, _response_applicant):
	special_condition = _special_condition
	condition_name = _condition_name
	question_player = _question_player
	response_applicant = _response_applicant
