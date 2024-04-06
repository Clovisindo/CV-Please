extends Node

class_name PaymentResume

export(PackedScene) onready var detail_payment

var current_month:int

var narrative_message:String

var rent_text:String
var rent_value:int
var rent_days_npay:int = 1#se inicia en 1 por como se gestiona este valor la primera vez que llegamos a pantalla de resumen

var food_text:String
var food_value:int
var food_days_npay:int = 1

var transport_text:String
var transport_value:int
var transport_days_npay:int = 1

var clothes_text:String
var clothes_value:int
var clothes_days_npay:int = 1

var repairs_text:String
var repairs_value:int
var repairs_days_npay:int = 1

var medicine_text:String
var medicine_value:int
var medicine_days_npay:int = 1

var month_salary:String
var current_balance:int = 0

var rent_penalty_text:String
var rent_penalty_value:int
var clothes_penalty_text:String
var clothes_penalty_value:int


func _ready():
	current_month = Global.current_month
	_load_npay_from_global()
	_set_values_by_difficulty()
	_load_payments_UI()


func _load_payments_UI():
	$NarrativeGamePanel/NarrativeGameText.text = narrative_message
	#TODO: cuando todo esto venga cargado de global, comprobarás primero que cosas no tienen datos, e instancias solo lo que el global te indica que toca para ese nivel
	$PaymentPanel/MonthBillsVBoxContainer.add_child(_instantiate_new_detail(rent_text, rent_value,EnumUtils.TypePayments.rent))
	$PaymentPanel/MonthBillsVBoxContainer.add_child(_instantiate_new_detail(food_text, food_value,EnumUtils.TypePayments.food))
	$PaymentPanel/MonthBillsVBoxContainer.add_child(_instantiate_new_detail(transport_text, transport_value,EnumUtils.TypePayments.transport))
	
	$PaymentPanel/ExtraBillsVBoxContainer.add_child(_instantiate_new_detail(clothes_text, clothes_value,EnumUtils.TypePayments.clothes))
	$PaymentPanel/ExtraBillsVBoxContainer.add_child(_instantiate_new_detail(repairs_text, repairs_value,EnumUtils.TypePayments.repairs))
	$PaymentPanel/ExtraBillsVBoxContainer.add_child(_instantiate_new_detail(medicine_text, medicine_value,EnumUtils.TypePayments.medicine))
	
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(_instantiate_new_detail(rent_penalty_text, rent_penalty_value,EnumUtils.TypePayments.penalty))
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(_instantiate_new_detail(clothes_penalty_text, clothes_penalty_value,EnumUtils.TypePayments.penalty))


func _instantiate_new_detail(_text, _value, _type_payment ) -> DetailResumePanel:
	var new_detail = detail_payment.instance()
	new_detail._set_value(_text, _value,_type_payment)
	if _type_payment != EnumUtils.TypePayments.penalty:
		new_detail.connect("update_payments", self, "_calculate_selected_payments")
	return new_detail


func _update_balance_month(month_balance):
	$PaymentPanel/MonthSalaryNumber.text = String(Global.current_month_salary_amount)
	$PaymentPanel/CurrentBalanceNumber.text =  String(Global.current_salary_amount)
	_set_current_balance(month_balance)
	if rent_penalty_value < 0:#ToDO comprobacion dinamica de los penalizadores
		_calculate_selected_payments(rent_penalty_value, false,null)
	if clothes_penalty_value < 0:
		_calculate_selected_payments(clothes_penalty_value, false,null)
	_check_balance_account(month_balance)


func _apply_payments_global():
	Global.current_salary_amount = current_balance
	Global.current_month = current_month  + 1
	print(" Se aplican los gastos, saldo restante del mes :" + String(current_balance) + "Saldo total acumulado en el banco: " + String(Global.current_salary_amount))


func _load_npay_from_global():#sumamos un dia mas de no pagar
	if current_month > 1:
		rent_days_npay =  Global.rent_days_npay + 1
		food_days_npay = Global.food_days_npay  + 1
		transport_days_npay = Global.transport_days_npay + 1
		clothes_days_npay = Global.clothes_days_npay + 1
		repairs_days_npay = Global.repairs_days_npay + 1
		medicine_days_npay = Global.medicine_days_npay + 1

func _apply_npays_global():
	Global.set_penalties_npay(rent_days_npay, food_days_npay, transport_days_npay, clothes_days_npay, repairs_days_npay, medicine_days_npay)

func _set_current_balance(_value):
	current_balance = int ($PaymentPanel/CurrentBalanceNumber.text)
	print("Actualizando cantidad de sueldo actual:" + String(current_balance) + " sumando la cantidad : " + String(_value) + " total :" + String(current_balance + _value))
	current_balance += _value
	$PaymentPanel/CurrentBalanceNumber.text = String(current_balance)


func _check_balance_account(current_balance):
	if current_balance < 0:
		print(" te quedas sin saldo, no puedes finalizar.")
		$PaymentPanel/EndPaymentResume.disabled = true
	elif current_balance >= 0 && $PaymentPanel/EndPaymentResume.disabled == true:
		print(" Saldo apto de nuevo , habilitado boton.")
		$PaymentPanel/EndPaymentResume.disabled = false


func _calculate_selected_payments(_value, _selected, _type_payment = null):
	_set_current_balance(_value)
	print("Restamos el valor :" + String(_value) + " saldo actual: "+ String(current_balance))
	_check_balance_account(current_balance)
	if _type_payment != null:
		_apply_penalty_by_type(_type_payment,_selected)
	#TODO: calcular/deducir que gastos salen en funcion de las variables globales que miden las acciones en pantalla de juego y en resumen pagos


func _apply_penalty_by_type(_type_payment, _selected):
	var value_penalty:int
	if _selected:
		value_penalty = 0
	else:
		value_penalty = 1
	
	if _type_payment == EnumUtils.TypePayments.rent:
		rent_days_npay = _apply_detail_npay(Global.rent_days_npay, value_penalty)
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(rent_days_npay))
	if _type_payment == EnumUtils.TypePayments.food:
		food_days_npay = _apply_detail_npay(Global.food_days_npay, value_penalty)
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(food_days_npay))
	if _type_payment == EnumUtils.TypePayments.transport:
		transport_days_npay = _apply_detail_npay(Global.transport_days_npay, value_penalty)
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(transport_days_npay))
	if _type_payment == EnumUtils.TypePayments.clothes:
		clothes_days_npay = _apply_detail_npay(Global.clothes_days_npay, value_penalty)
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(clothes_days_npay))
	if _type_payment == EnumUtils.TypePayments.repairs:
		repairs_days_npay = _apply_detail_npay(Global.repairs_days_npay, value_penalty)
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(repairs_days_npay))
	if _type_payment == EnumUtils.TypePayments.medicine:
		medicine_days_npay = _apply_detail_npay(Global.medicine_days_npay, value_penalty)
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(medicine_days_npay))


func _apply_detail_npay( global_npay, value_penalty):
	if value_penalty == 1:
		return  global_npay + 1
	elif value_penalty == 0:
		return 0


func _set_values_by_difficulty():#TODO:carga global escena externa
	#TODO: control de si en global ya hay valores, inicializar manager con esos valores( los dias sin pagar)
	narrative_message = "Company is pleased  with your work, a promotion may be coming your way."
	
	rent_text = "Rent home: "
	rent_value = -600
	
	food_text = "Food: "
	food_value = -300
	
	transport_text = "Transport costs: "
	transport_value = -200
	
	clothes_text = "Clothes: "
	clothes_value = -40
	repairs_text = "Repair washing machine: "
	repairs_value = -150
	medicine_text = "Medicines: "
	medicine_value = -40
		
	rent_penalty_text = "you owe one month's rent."
	rent_penalty_value = -50
	clothes_penalty_text = "you got sick for not buying winter clothes."
	clothes_penalty_value = -60
