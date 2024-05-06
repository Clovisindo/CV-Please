extends Panel

class_name DetailPaymentPanel

signal update_payments(value, selected)

enum PaymentStatus {
	IDLE,
	SELECTED,
}

export(EnumUtils.TypePayments) var type_payment
export(EnumUtils.TypeSpecialCondition) var type_special_condition
export(PaymentStatus) var current_status

var value_text
var value
var money_balance  #TODO: logica para pintar de color verde o rojo si saldo positivo o negativo
var selected: bool = false

var velocity = 25
var x_limit = 10
var is_hovered = false


func set_value(_text, _value, _type_payment) -> void:
	value_text = _text
	value = _value
	if value >= 0:
		money_balance = true
	elif value < 0:
		money_balance = false
	$TextLabel.text = _text + String(value)
	type_payment = _type_payment


func payment_idle():
	if current_status == PaymentStatus.SELECTED:
		print(value_text + "selecciona a false")
		selected = false
		emit_signal("update_payments", -value, selected, type_payment)

		current_status = PaymentStatus.IDLE
		rect_position.x = 0
		$TextLabel.add_color_override("default_color", Color(1, 1, 1, 1))


func payment_select():
	if current_status == PaymentStatus.IDLE:
		print(value_text + "selecciona a true")
		selected = true
		emit_signal("update_payments", value, selected, type_payment)

		current_status = PaymentStatus.SELECTED
		rect_position.x = 10
		$TextLabel.add_color_override("default_color", Color(0, 0.392157, 0, 1))


func _gui_input(event):
	if current_status == PaymentStatus.IDLE:
		_process_as_idle(event)
	elif current_status == PaymentStatus.SELECTED:
		_process_as_selected(event)


func _process(delta):
	if (
		current_status == PaymentStatus.IDLE
		&& type_payment != EnumUtils.TypePayments.PENALTY
		&& is_hovered
	):
		if rect_position.x >= x_limit || rect_position.x <= -1:
			velocity *= -1
		rect_position.x += velocity * delta


func _process_as_idle(event):
	if (
		event is InputEventMouseButton
		&& Input.is_mouse_button_pressed(BUTTON_LEFT)
		&& selected == false
		&& type_payment != EnumUtils.TypePayments.PENALTY
	):
		payment_select()


func _process_as_selected(event):
	if (
		event is InputEventMouseButton
		&& Input.is_mouse_button_pressed(BUTTON_LEFT)
		&& selected == true
		&& type_payment != EnumUtils.TypePayments.PENALTY
	):
		payment_idle()


func _on_DetaiPaymentlPanel_mouse_exited() -> void:
	is_hovered = false
	rect_position.x = 0


func _on_DetaiPaymentlPanel_mouse_entered() -> void:
	is_hovered = true
