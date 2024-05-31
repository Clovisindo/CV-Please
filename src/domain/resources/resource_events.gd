extends Resource
class_name ResourceEvents

export(EnumUtils.TypeEvent) var type_event
export var date_month: int
export(String, MULTILINE) var event_message


func _init() -> void:
	self.type_event = type_event
	self.date_month = date_month
	self.event_message = event_message


func set_data(_type_event, _date_month, _event_message, _event_text) -> void:
	type_event = _type_event
	date_month = _date_month
	event_message = _event_message
