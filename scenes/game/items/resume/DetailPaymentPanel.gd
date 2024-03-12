extends Panel

class_name detailPaymentPanel

var value_text
var value
var money_balance#TODO: logica para pintar de color verde o rojo si saldo positivo o negativo
var selected:bool = false

signal update_payments(value)

func _ready() -> void:
	pass

func _set_value(_text, _value) -> void:
	value_text = _text
	value = _value
	if value >= 0:
		money_balance = true
	elif value < 0:
		money_balance = false
	$TextLabel.text = _text + String(value)


func _gui_input(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && selected == false:
		print(value_text + "selecciona a true")
		selected = true
		emit_signal("update_payments",value)
	elif event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && selected == true:
		print(value_text + "selecciona a false")
		selected = false
		emit_signal("update_payments",-value )


