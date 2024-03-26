extends Resource
class_name ResourcePaymentPanel


export var value_text_OK:String
export var value_text_NOK:String
var value_text:String
export var value_OK:int
export var value_NOK:int
var value:int
export (EnumUtils.typeSpecialCondition) var type_special_condition

func _init() -> void:
	self.type_special_condition = type_special_condition
	self.value_text = value_text
	self.value = value

func _set_data(_text_OK,_text_no_OK, _value_OK,_value_NOK,_typePayment,_type_special_condition) -> void:
	value_text_OK = _text_OK
	value_text_NOK = _text_no_OK
	value_OK = _value_OK
	value_NOK = _value_NOK
	type_special_condition = _type_special_condition


func _set_value(_text,_value):
	value_text = _text
	value = _value
