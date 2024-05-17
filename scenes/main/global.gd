extends Node

const LEVELS_DIR = "res://data/events"
const LEVELS_DIR_MAIN = "/main/"
const LEVELS_DIR_RESUME = "/resume/"
const TRES_SUFIX = ".tres"

#var current_applicants_result:ApplicantResult
var current_applicants_result = []

var current_salary_amount = 0
var current_month_salary_amount = 0

var moral_compass_company = 0
var moral_compass_applicants = 0

var current_month: int = 1

var rent_days_npay: int = 1  #empieza en 1 por como se gestiona el inicio de este valor en pantalla de resumen
var food_days_npay: int = 1
var transport_days_npay: int = 1
var clothes_days_npay: int = 1
var repairs_days_npay: int = 1
var medicine_days_npay: int = 1


func get_events_by_month(type_resource):
	var dir = Directory.new()
	var current_dir = _get_directory_by_month(current_month, type_resource)
	if dir.open(current_dir) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var regex = RegEx.new()
		regex.compile(".*\\.tres")
		while file_name != "":
			if regex.search(file_name):
				if not dir.current_is_dir():
					var event = ResourceLoader.load(current_dir + file_name)
					if event is MonthEvents:
						return event
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _get_directory_by_month(_current_month, _type_resource):
	if _type_resource == EnumUtils.TypeFolder.MAIN:
		return LEVELS_DIR + _get_month_value(_current_month) + LEVELS_DIR_MAIN
	return LEVELS_DIR + _get_month_value(_current_month) + LEVELS_DIR_RESUME


func get_type_event_by_globals():
	if Global.moral_compass_applicants == Global.moral_compass_company:
		return EnumUtils.TypeEvent.NEUTRAL
	if Global.moral_compass_applicants > Global.moral_compass_company:
		return EnumUtils.TypeEvent.FOR_APPLICANTS
	if Global.moral_compass_applicants < Global.moral_compass_company:
		return EnumUtils.TypeEvent.FOR_COMPANY


func _get_month_value(enum_month):
	match enum_month:
		Time.MONTH_JANUARY:
			return "/1january"
		Time.MONTH_FEBRUARY:
			return "/2february"
		Time.MONTH_MARCH:
			return "/3march"
		Time.MONTH_APRIL:
			return "/4april"
		Time.MONTH_MAY:
			return "/5may"
		Time.MONTH_JUNE:
			return "/6june"


func set_applicants_result_for_day(app_list):
	current_applicants_result = app_list


func set_penalties_npay(
	rent_npay, food_npay, transport_npay, clothes_npay, repairs_npay, medicine_npay
):
	rent_days_npay = rent_npay
	food_days_npay = food_npay
	transport_days_npay = transport_npay
	clothes_days_npay = clothes_npay
	repairs_days_npay = repairs_npay
	medicine_days_npay = medicine_npay
