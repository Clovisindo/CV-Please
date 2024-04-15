extends Panel

class_name DetailPaymentPanel

var value_text
var value
var money_balance#TODO: logica para pintar de color verde o rojo si saldo positivo o negativo
var selected:bool = false
export(EnumUtils.TypePayments) var type_payment
export(EnumUtils.typeSpecialCondition) var type_special_condition

signal update_payments(value, selected)


func _set_value(_text, _value, _type_payment) -> void:
	value_text = _text
	value = _value
	if value >= 0:
		money_balance = true
	elif value < 0:
		money_balance = false
	$TextLabel.text = _text + String(value)
	type_payment = _type_payment


func _gui_input(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && selected == false && type_payment != EnumUtils.TypePayments.penalty:
		print(value_text + "selecciona a true")
		selected = true
		emit_signal("update_payments",value, selected, type_payment)
	elif event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && selected == true && type_payment != EnumUtils.TypePayments.penalty:
		print(value_text + "selecciona a false")
		selected = false
		emit_signal("update_payments",-value, selected, type_payment )


