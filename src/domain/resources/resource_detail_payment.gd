extends Resource
class_name ResourcePaymentPanel

export(EnumUtils.TypeSpecialCondition) var type_special_condition
export var value_text_ok: String
export var value_text_nok: String
export var value_ok: int
export var value_nok: int
var value_text: String
var value: int


func _init() -> void:
	self.type_special_condition = type_special_condition
	self.value_text = value_text
	self.value = value


func set_data(_text_ok, _text_no_ok, _value_ok, _value_nok, _type_special_condition) -> void:
	value_text_ok = _text_ok
	value_text_nok = _text_no_ok
	value_ok = _value_ok
	value_nok = _value_nok
	type_special_condition = _type_special_condition


func set_value(_text, _value):
	value_text = _text
	value = _value
