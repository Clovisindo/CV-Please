extends Node

class_name PaymentResume

export(PackedScene) onready var detail_payment

var current_month: int
var bank_negative_days_npay: int = 0

var narrative_message: String

var rent_text: String
var rent_value: int
var rent_value_modifier: int
var rent_days_npay: int = 0  #se inicia en 1 por como se gestiona este valor la primera vez que llegamos a pantalla de resumen

var food_text: String
var food_value: int
var food_value_modifier: int
var food_days_npay: int = 0

var transport_text: String
var transport_value: int
var transport_value_modifier: int
var transport_days_npay: int = 0

var clothes_text: String
var clothes_value: int
var clothes_days_npay: int = 0

var repairs_text: String
var repairs_value: int
var repairs_days_npay: int = 0

var medicine_text: String
var medicine_value: int
var medicine_days_npay: int = 0

var month_salary: String
var current_balance: int = 0

var rent_penalty_text: String
var rent_penalty_value: int
var clothes_penalty_text: String
var clothes_penalty_value: int


func _ready():
	current_month = Global.current_month
	_load_npay_from_global()
	_set_values_by_difficulty()
	_load_payments_ui()


func _load_payments_ui():
	$PaymentPanel/MonthBillsVBoxContainer.add_child(
		_instantiate_new_detail(
			rent_text, rent_value - rent_value_modifier, EnumUtils.TypePayments.RENT
		)
	)
	$PaymentPanel/MonthBillsVBoxContainer.add_child(
		_instantiate_new_detail(
			food_text, food_value - food_value_modifier, EnumUtils.TypePayments.FOOD
		)
	)
	$PaymentPanel/MonthBillsVBoxContainer.add_child(
		_instantiate_new_detail(
			transport_text,
			transport_value - transport_value_modifier,
			EnumUtils.TypePayments.TRANSPORT
		)
	)


func _set_narrative_message(_narrative_message):
	$NarrativeGamePanel/NarrativeGameText.text = _narrative_message


func set_payment_extra_bills(extra_bills):
	for bill in extra_bills:
		$PaymentPanel/ExtraBillsVBoxContainer.add_child(
			_instantiate_new_detail(bill.payment_message, bill.payment_value, bill.type_payment)
		)


func set_penalty_bills(penalty_bills):
	for bill in penalty_bills:
		if check_apply_penalty(bill.type_payment):
			$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(
				_instantiate_new_detail(
					bill.payment_message, bill.payment_value, bill.type_payment, false
				)
			)
			_calculate_selected_payments(bill.payment_value, false, null)


func check_apply_penalty(type_payment):
	if type_payment == EnumUtils.TypePayments.RENT:
		if rent_days_npay - 1 >= 1:
			return true
	if type_payment == EnumUtils.TypePayments.FOOD:
		if food_days_npay - 1 >= 1:
			return true
	if type_payment == EnumUtils.TypePayments.TRANSPORT:
		if transport_days_npay - 1 >= 1:
			return true
	return false


func _instantiate_new_detail(_text, _value, _type_payment, is_active = null) -> DetailResumePanel:
	var new_detail = detail_payment.instance()
	new_detail.set_value(_text, _value, _type_payment, is_active)
	if _type_payment != EnumUtils.TypePayments.PENALTY:
		new_detail.connect("update_payments", self, "_calculate_selected_payments")
	return new_detail


func _update_balance_month(month_balance):  #calculo inicial desde resumeManager
	$PaymentPanel/MonthSalaryNumber.text = String(Global.current_month_salary_amount)
	$PaymentPanel/CurrentBalanceNumber.text = String(Global.current_salary_amount)
	_set_current_balance(month_balance)
	_check_balance_account(month_balance)


func _apply_payments_global():
	Global.current_salary_amount = current_balance
	Global.current_month = current_month + 1
	print(
		(
			" Se aplican los gastos, saldo restante del mes :"
			+ String(current_balance)
			+ "Saldo total acumulado en el banco: "
			+ String(Global.current_salary_amount)
		)
	)


func _load_npay_from_global():  #sumamos un dia mas de no pagar
	if current_month > 1:
		rent_days_npay = Global.rent_days_npay + 1
		food_days_npay = Global.food_days_npay + 1
		transport_days_npay = Global.transport_days_npay + 1
		clothes_days_npay = Global.clothes_days_npay + 1
		repairs_days_npay = Global.repairs_days_npay + 1
		medicine_days_npay = Global.medicine_days_npay + 1
		bank_negative_days_npay = Global.bank_negative_days_npay + 1


func _apply_npays_global():
	Global.set_penalties_npay(
		rent_days_npay,
		food_days_npay,
		transport_days_npay,
		clothes_days_npay,
		repairs_days_npay,
		medicine_days_npay,
		bank_negative_days_npay
	)


func _set_current_balance(_value):
	current_balance = int($PaymentPanel/CurrentBalanceNumber.text)
	print(
		(
			"Actualizando cantidad de sueldo actual:"
			+ String(current_balance)
			+ " sumando la cantidad : "
			+ String(_value)
			+ " total :"
			+ String(current_balance + _value)
		)
	)
	current_balance += _value
	$PaymentPanel/CurrentBalanceNumber.text = String(current_balance)


func _check_balance_account(current_balance):
	if current_balance < 0:
		print(" te quedas sin saldo, no puedes finalizar.")
		# $PaymentPanel/EndPaymentResume.disabled = true
		_apply_penalty_by_type(EnumUtils.TypePayments.BANK_NEGATIVE, 0)
	elif current_balance >= 0:
		print(" Saldo apto de nuevo , habilitado boton.")
		# $PaymentPanel/EndPaymentResume.disabled = false
		_apply_penalty_by_type(EnumUtils.TypePayments.BANK_NEGATIVE, 1)


# calculo desde los distintos elementos que modifican los pagos en pantalla resumen
# se usa type_payment en las llamadas con signal desde los botones del panel
func _calculate_selected_payments(_value, _selected, _type_payment = null):
	_set_current_balance(_value)
	print("Restamos el valor :" + String(_value) + " saldo actual: " + String(current_balance))
	_check_balance_account(current_balance)
	if _type_payment != null:
		_apply_penalty_by_type(_type_payment, _selected)
	#TODO: calcular/deducir que gastos salen en funcion de las variables globales que miden las acciones en pantalla de juego y en resumen pagos


func _apply_penalty_by_type(_type_payment, _selected):
	var value_penalty: int
	if _selected:
		value_penalty = 0
	else:
		value_penalty = 1

	if _type_payment == EnumUtils.TypePayments.RENT:
		rent_days_npay = _apply_detail_npay(Global.rent_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(rent_days_npay)
			)
		)
	if _type_payment == EnumUtils.TypePayments.FOOD:
		food_days_npay = _apply_detail_npay(Global.food_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(food_days_npay)
			)
		)
	if _type_payment == EnumUtils.TypePayments.TRANSPORT:
		transport_days_npay = _apply_detail_npay(Global.transport_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(transport_days_npay)
			)
		)
	if _type_payment == EnumUtils.TypePayments.CLOTHES:
		clothes_days_npay = _apply_detail_npay(Global.clothes_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(clothes_days_npay)
			)
		)
	if _type_payment == EnumUtils.TypePayments.REPAIRS:
		repairs_days_npay = _apply_detail_npay(Global.repairs_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(repairs_days_npay)
			)
		)
	if _type_payment == EnumUtils.TypePayments.MEDICINE:
		medicine_days_npay = _apply_detail_npay(Global.medicine_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(medicine_days_npay)
			)
		)
	if _type_payment == EnumUtils.TypePayments.BANK_NEGATIVE:
		bank_negative_days_npay = _apply_detail_npay(Global.bank_negative_days_npay, value_penalty)
		print(
			(
				"Dias de penalizacion para "
				+ String(EnumUtils.TypePayments.keys()[_type_payment])
				+ " total : "
				+ String(bank_negative_days_npay)
			)
		)


func _apply_detail_npay(global_npay, value_penalty):
	if value_penalty == 1:
		return global_npay + 1
	return value_penalty  # se podria arreglar haciendo global_npay -1 si es el otro valor


func _set_values_by_difficulty():
	# cargamos los gastos fijos
	rent_text = "Rent home: "
	rent_value = -600
	food_text = "Food: "
	food_value = -300
	transport_text = "Transport costs: "
	transport_value = -100

	#aplicamos ajuste avanzando los meses
	if current_month > 1:
		rent_value_modifier += 100
		food_value_modifier += 50
		transport_value_modifier += 50
