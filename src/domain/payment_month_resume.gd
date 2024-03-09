extends Node

class_name payment_resume

var narrative_message:String

var rent:String
var food:String
var transport:String

var clothes:String
var repairs:String
var medicine:String

var month_salary:String
var current_balance:String

var rent_penalty:String
var clothes_penalty:String


func _ready():
	_set_values_by_difficulty()
	_calculate_payments()
	_load_payments_UI()
	


func _load_payments_UI():
	$NarrativeGamePanel/NarrativeGameText.text = narrative_message
	
	$PaymentPanel/MonthBillsVBoxContainer/DetailMonthBillPanel/DetailMonthBillTextLabel.text = rent
	$PaymentPanel/MonthBillsVBoxContainer/DetailMonthBillPanel2/DetailMonthBillTextLabel.text = food
	$PaymentPanel/MonthBillsVBoxContainer/DetailMonthBillPanel3/DetailMonthBillTextLabel.text = transport
	
	$PaymentPanel/ExtraBillsVBoxContainer/DetailExtraBillPanel/DetailExtraBillTextLabel.text = clothes
	$PaymentPanel/ExtraBillsVBoxContainer/DetailExtraBillPanel2/DetailExtraBillTextLabel.text = repairs
	$PaymentPanel/ExtraBillsVBoxContainer/DetailExtraBillPanel3/DetailExtraBillTextLabel.text = medicine
	
	$PaymentPanel/MonthSalaryNumber.text = month_salary
	$PaymentPanel/CurrentBalanceNumber.text = current_balance
	
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer/PenaltyPanel/DetailPenaltyTextLabel.text = rent_penalty
	$PaymentPanel/PenaltiesPanel/PenaltiesVBoxContainer/PenaltyPanel2/DetailPenaltyTextLabel.text = clothes_penalty


func _calculate_payments():
	pass # calcular los gastos a hacer en funcion de las variables globales 
	#que miden las acciones en pantalla de juego y en resumen pagos


func _set_values_by_difficulty():
	narrative_message = "Company is pleased  with your work, a promotion may be coming your way."
	
	rent = "Rent home: 600€"
	food = "Food: 300€"
	transport = "Transport costs: 200€"
	
	clothes = "Clothes: 40€"
	repairs = "Repair washing machine: 150€"
	medicine = "Medicines: 40€"
	
	month_salary = "1000€"
	current_balance = "1000€"
	
	rent_penalty = "you owe one month's rent."
	clothes_penalty = "you got sick for not buying winter clothes."
