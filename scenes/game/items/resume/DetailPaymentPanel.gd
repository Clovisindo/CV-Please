extends Panel

class_name detailPaymentPanel

var value_text
var value
var money_balance#TODO: logica para pintar de color verde o rojo si saldo positivo o negativo

func _ready() -> void:
	pass

func _set_value(_text, _value, _balance) -> void:
	value_text = _text
	value =_value
	$TextLabel.text = _text + String(value)
	money_balance = _balance
