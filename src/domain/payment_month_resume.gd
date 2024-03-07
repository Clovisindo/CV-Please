extends Node

class_name payment_resume

var rent
var food
var transport

var clothes
var repairs
var medicine

var month_salary
var current_balance

var rent_penalty
var clothes_penalty


func _init():
	_set_values_by_dificulty()
	_calculate_payments()
	_load_payments_UI()
	


func _load_payments_UI():
	pass# cargar datos a la UI


func _calculate_payments():
	pass # calcular los gastos a hacer en funcion de las variables globales 
	#que miden las acciones en pantalla de juego y en resumen pagos


func _set_values_by_dificulty():
	pass#TODO cargar los datos por defecto a partir dificultad
