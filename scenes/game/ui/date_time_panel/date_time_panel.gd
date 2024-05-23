extends Panel

class_name DateTimePanel

const DATE_INITIAL = "January"
const TIME_INITIAL = "08:00"

var current_hours = 8
var current_minutes = 0
var timer: Timer


func _ready() -> void:
	$MonthLabel.text = DATE_INITIAL
	$TimeLabel.text = TIME_INITIAL
	_set_text_hour(current_hours, current_minutes)


func _set_text_hour(hour_value, minutes_value):
	var text_hour
	var text_minutes

	if minutes_value + current_minutes >= 60:
		current_minutes = (minutes_value + current_minutes) - 60
	if current_minutes < 10:
		text_minutes = "0" + String(current_minutes)
	else:
		text_minutes = String(current_minutes)

	if hour_value < 10:
		text_hour = "0" + String(current_hours)
	else:
		text_hour = String(current_hours)

	$TimeLabel.text = text_hour + ":" + text_minutes


func set_current_month(_ecurrent_month):
	var current_month = _get_month_value(_ecurrent_month)
	$MonthLabel.text = current_month


func set_datetime_by_validation(turns_value_validate):
	if turns_value_validate:
		current_hours += 2
		_set_text_hour(current_hours, current_minutes)
	else:
		current_hours += 2
		current_minutes += 40
		_set_text_hour(current_hours, current_minutes)


func _get_month_value(enum_month):
	match enum_month:
		Time.MONTH_JANUARY:
			return "January"
		Time.MONTH_FEBRUARY:
			return "February"
		Time.MONTH_MARCH:
			return "March"
		Time.MONTH_APRIL:
			return "April"
		Time.MONTH_MAY:
			return "May"
		Time.MONTH_JUNE:
			return "June"
