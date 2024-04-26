extends Panel

class_name DetailResumePanel

var value_text
var value
var money_balance  #TODO: logica para pintar de color verde o rojo si saldo positivo o negativo


func set_value(_text, _value) -> void:
	value_text = _text
	value = _value
	if value >= 0:
		money_balance = true
	elif value < 0:
		money_balance = false
	$DetailApplicantLabel.text = _text + " " + String(value)
