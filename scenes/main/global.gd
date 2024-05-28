extends Node

const LEVELS_DIR = "res://data/events"
const LEVELS_DIR_MAIN = "/main/"
const LEVELS_DIR_RESUME = "/resume/"
const LEVELS_DIR_EXTRA = "/extra/"
const TRES_SUFIX = ".tres"
const LEVELS_DIR_PENALTY = "res://data/events/penalty_payments/"

var current_applicants_result = []

var current_salary_amount = 0
var current_month_salary_amount = 0

var moral_compass_company = 0
var moral_compass_applicants = 0

var current_month: int = 1
var true_ending: bool = false
var bank_negative_days_npay: int = 0

var rent_days_npay: int = 0
var food_days_npay: int = 0
var transport_days_npay: int = 0
var clothes_days_npay: int = 0
var repairs_days_npay: int = 0
var medicine_days_npay: int = 0


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
					if event is MonthEvents || event is EventsExtra:
						return event
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func get_penalty_payments():
	var dir = Directory.new()
	if dir.open(LEVELS_DIR_PENALTY) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var regex = RegEx.new()
		regex.compile(".*\\.tres")
		while file_name != "":
			if regex.search(file_name):
				if not dir.current_is_dir():
					var event = ResourceLoader.load(LEVELS_DIR_PENALTY + file_name)
					if event is EventsExtra:
						return event
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _get_directory_by_month(_current_month, _type_resource):
	if _type_resource == EnumUtils.TypeFolder.MAIN:
		return LEVELS_DIR + _get_month_value(_current_month) + LEVELS_DIR_MAIN
	if _type_resource == EnumUtils.TypeFolder.RESUME:
		return LEVELS_DIR + _get_month_value(_current_month) + LEVELS_DIR_RESUME
	if _type_resource == EnumUtils.TypeFolder.EXTRA:
		return LEVELS_DIR + _get_month_value(_current_month) + LEVELS_DIR_EXTRA


func get_type_event_by_globals():
	if Global.moral_compass_applicants == Global.moral_compass_company:
		return EnumUtils.TypeEvent.NEUTRAL
	if Global.moral_compass_applicants > Global.moral_compass_company:
		return EnumUtils.TypeEvent.FOR_APPLICANTS
	if Global.moral_compass_applicants < Global.moral_compass_company:
		return EnumUtils.TypeEvent.FOR_COMPANY


func get_message_from_event(events):
	# que tipo de eventos buscamos
	var type_event = Global.get_type_event_by_globals()
	for event in events:
		if event.type_event == type_event:
			return event


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


func set_is_true_ending():
	if moral_compass_applicants > moral_compass_company:
		true_ending = true


func set_initial_global():
	current_month = 1
	true_ending = false
	current_salary_amount = 0
	current_month_salary_amount = 0

	moral_compass_company = 0
	moral_compass_applicants = 0
	rent_days_npay = 0
	food_days_npay = 0
	transport_days_npay = 0
	clothes_days_npay = 0
	repairs_days_npay = 0
	medicine_days_npay = 0


func set_penalties_npay(
	rent_npay,
	food_npay,
	transport_npay,
	clothes_npay,
	repairs_npay,
	medicine_npay,
	bank_negative_npay
):
	rent_days_npay = rent_npay
	food_days_npay = food_npay
	transport_days_npay = transport_npay
	clothes_days_npay = clothes_npay
	repairs_days_npay = repairs_npay
	medicine_days_npay = medicine_npay
	bank_negative_days_npay = bank_negative_npay


func check_is_gameover():
	if (
		rent_days_npay >= 2
		|| food_days_npay >= 2
		|| transport_days_npay >= 2
		|| bank_negative_days_npay >= 2
	):
		return true
	return false
