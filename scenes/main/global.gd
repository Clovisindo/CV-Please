extends Node

#var current_applicants_result:ApplicantResult
var current_applicants_result = []

var current_salary_amount = 0
var current_month_salary_amount = 0

var current_month:int = 1

var rent_days_npay:int = 1#empieza en 1 por como se gestiona el inicio de este valor en pantalla de resumen
var food_days_npay:int = 1
var transport_days_npay:int = 1
var clothes_days_npay:int = 1
var repairs_days_npay:int = 1
var medicine_days_npay:int = 1

func set_applicants_result_for_day(app_list):
	current_applicants_result = app_list


func set_penalties_npay(rent_npay, food_npay, transport_npay, clothes_npay, repairs_npay, medicine_npay):
	rent_days_npay = rent_npay
	food_days_npay = food_npay
	transport_days_npay = transport_npay
	clothes_days_npay = clothes_npay
	repairs_days_npay = repairs_npay
	medicine_days_npay = medicine_npay
