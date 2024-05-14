extends Panel

class_name JobTimelineWork

enum JobTimelineWorkStatus {
	IDLE,
	SELECTED,
	MATCHED,
	DISABLED,
}

export(JobTimelineWorkStatus) var current_status

var job_description: String
var time_job: String

var velocity = -25
var x_limit = -10
var is_hovered = false


func add_data(_job_descp: String, _time_job: String):
	job_description = _job_descp
	time_job = _time_job
	$JobTimeLineWorkRtext.text = _job_descp + ": " + _time_job


func _process(_delta):
	_set_size_by_text()


func _set_size_by_text():
	get_node(".").rect_size.y = get_node("JobTimeLineWorkRtext").rect_size.y + 8
	get_node(".").rect_min_size.y = get_node(".").rect_size.y
