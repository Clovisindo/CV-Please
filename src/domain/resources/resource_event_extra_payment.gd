extends Resource
class_name ResourceExtraPayments

export(EnumUtils.TypePayments) var type_payment
export var date_month: int
export var payment_message: String
export var payment_value: int


func _init() -> void:
	self.type_payment = type_payment
	self.date_month = date_month
	self.payment_message = payment_message
	self.payment_value = payment_value


func set_data(_type_payment, _date_month, _payment_message, _payment_value) -> void:
	type_payment = _type_payment
	date_month = _date_month
	payment_message = _payment_message
	payment_value = _payment_value
