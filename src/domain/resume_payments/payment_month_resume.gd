extends Node

class_name PaymentResume

export(PackedScene) onready var detail_payment

var narrative_message:String

var rent_text:String
var rent_value:int
var rent_days_npay:int = 0

var food_text:String
var food_value:int
var food_days_npay:int = 0

var transport_text:String
var transport_value:int
var transport_days_npay:int = 0

var clothes_text:String
var clothes_value:int
var clothes_days_npay:int = 0

var repairs_text:String
var repairs_value:int
var repairs_days_npay:int = 0

var medicine_text:String
var medicine_value:int
var medicine_days_npay:int = 0

var month_salary:String
var current_balance:int

var rent_penalty_text:String
var rent_penalty_value:int
var clothes_penalty_text:String
var clothes_penalty_value:int


func _ready():
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
	
	$PaymentPanel/MonthSalaryNumber.text = month_salary
	$PaymentPanel/CurrentBalanceNumber.text = String(current_balance)
	
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(_instantiate_new_detail(rent_penalty_text, rent_penalty_value,EnumUtils.TypePayments.penalty))
	calculate_selected_payments(rent_penalty_value, false,null)
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(_instantiate_new_detail(clothes_penalty_text, clothes_penalty_value,EnumUtils.TypePayments.penalty))
	calculate_selected_payments(clothes_penalty_value, false,null)


func _instantiate_new_detail(_text, _value, _type_payment ) -> DetailResumePanel:
	var new_detail = detail_payment.instance()
	new_detail._set_value(_text, _value,_type_payment)
	if _type_payment != EnumUtils.TypePayments.penalty:
		new_detail.connect("update_payments", self, "calculate_selected_payments")
	return new_detail


func _set_current_balance(_value):
	current_balance += _value
	$PaymentPanel/CurrentBalanceNumber.text = String(current_balance)

func _check_balance_account(current_balance):
	if current_balance < 0:
		print(" te quedas sin saldo, no puedes finalizar.")
		$PaymentPanel/EndPaymentResume.disabled = true
	elif current_balance >= 0 && $PaymentPanel/EndPaymentResume.disabled == true:
		print(" Saldo apto de nuevo , habilitado boton.")
		$PaymentPanel/EndPaymentResume.disabled = false


func calculate_selected_payments(_value, _selected, _type_payment = null):
	_set_current_balance(_value)
	print("Restamos el valor :" + String(_value) + " saldo actual: "+ String(current_balance))
	_check_balance_account(current_balance)
	if _type_payment != null:
		_apply_penaly_by_type(_type_payment,_selected)
	#TODO: calcular/deducir que gastos salen en funcion de las variables globales que miden las acciones en pantalla de juego y en resumen pagos


func _apply_penaly_by_type(_type_payment, _selected):
	var value_penalty:int
	if _selected:
		value_penalty = 1
	else:
		value_penalty = -1
	
	if _type_payment == EnumUtils.TypePayments.rent:
		rent_days_npay += value_penalty
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(rent_days_npay))
	if _type_payment == EnumUtils.TypePayments.food:
		food_days_npay += value_penalty
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(food_days_npay))
	if _type_payment == EnumUtils.TypePayments.transport:
		transport_days_npay += value_penalty
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(transport_days_npay))
	if _type_payment == EnumUtils.TypePayments.clothes:
		clothes_days_npay += value_penalty
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(clothes_days_npay))
	if _type_payment == EnumUtils.TypePayments.repairs:
		repairs_days_npay += value_penalty
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(repairs_days_npay))
	if _type_payment == EnumUtils.TypePayments.medicine:
		medicine_days_npay += value_penalty
		print("Dias de penalizacion para " + String(EnumUtils.TypePayments.keys()[_type_payment]) + " total : " + String(medicine_days_npay))


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
	
	month_salary = "1000€"
	current_balance = 1000
	
	rent_penalty_text = "you owe one month's rent."
	rent_penalty_value = -50
	clothes_penalty_text = "you got sick for not buying winter clothes."
	clothes_penalty_value = -60
