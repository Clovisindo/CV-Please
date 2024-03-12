extends Node

class_name payment_resume

export(PackedScene) onready var detail_payment

var narrative_message:String

var rent_text:String
var rent_value:int
var food_text:String
var food_value:int
var transport_text:String
var transport_value:int

var clothes_text:String
var clothes_value:int
var repairs_text:String
var repairs_value:int
var medicine_text:String
var medicine_value:int

var month_salary:String
var current_balance:int

var rent_penalty_text:String
var rent_penalty_value:int
var clothes_penalty_text:String
var clothes_penalty_value:int


func _ready():
	_set_values_by_difficulty()
	calculate_selected_payments(0)
	_load_payments_UI()
	


func _load_payments_UI():
	$NarrativeGamePanel/NarrativeGameText.text = narrative_message
	
	$PaymentPanel/MonthBillsVBoxContainer.add_child(_instantiate_new_detail(rent_text, rent_value))
	$PaymentPanel/MonthBillsVBoxContainer.add_child(_instantiate_new_detail(food_text, food_value))
	$PaymentPanel/MonthBillsVBoxContainer.add_child(_instantiate_new_detail(transport_text, transport_value))
	
	$PaymentPanel/ExtraBillsVBoxContainer.add_child(_instantiate_new_detail(clothes_text, clothes_value))
	$PaymentPanel/ExtraBillsVBoxContainer.add_child(_instantiate_new_detail(repairs_text, repairs_value))
	$PaymentPanel/ExtraBillsVBoxContainer.add_child(_instantiate_new_detail(medicine_text, medicine_value))
	
	$PaymentPanel/MonthSalaryNumber.text = month_salary
	$PaymentPanel/CurrentBalanceNumber.text = String(current_balance)
	
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(_instantiate_new_detail(rent_penalty_text, rent_penalty_value))
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer.add_child(_instantiate_new_detail(clothes_penalty_text, clothes_penalty_value))


func _instantiate_new_detail(text, value ) -> detailResumePanel:
	var new_detail = detail_payment.instance()
	new_detail._set_value(text, value)
	new_detail.connect("update_payments", self, "calculate_selected_payments")
	return new_detail

func calculate_selected_payments(_value):
	current_balance += _value
	$PaymentPanel/CurrentBalanceNumber.text = String(current_balance)
	print("Restamos el valor :" + String(_value) + " saldo actual: "+ String(current_balance))
	if current_balance < 0:
		print(" te quedas sin saldo, no puedes finalizar.")
		$PaymentPanel/EndPaymentResume.disabled = true
	elif current_balance >= 0 && $PaymentPanel/EndPaymentResume.disabled == true:
		print(" Saldo apto de nuevo , habilitado boton.")
		$PaymentPanel/EndPaymentResume.disabled = false
	# calcular los gastos a hacer en funcion de las variables globales 
	#que miden las acciones en pantalla de juego y en resumen pagos


func _set_values_by_difficulty():
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
