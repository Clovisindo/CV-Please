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

# func timejob_idle():
# 	if current_status == JobTimelineWorkStatus.SELECTED:
# 		_process_idle()

# func _process_idle():
# 	current_status = JobTimelineWorkStatus.IDLE
# 	rect_position.x = 0
# 	$JobTimeLineWorkRtext.add_color_override("default_color", Color(1, 1, 1, 1))

# func requisite_selected():
# 	if current_status == JobTimelineWorkStatus.IDLE:
# 		_process_selected()

# func _process_selected():
# 	current_status = JobTimelineWorkStatus.SELECTED
# 	$JobTimeLineWorkRtext.add_color_override("default_color", Color(0, 0.392157, 0, 1))
# 	rect_position.x = 10

# func requisite_disable():
# 	if current_status == JobTimelineWorkStatus.IDLE:
# 		current_status = JobTimelineWorkStatus.DISABLED
# 		rect_position.x = 0

# func requisite_enable():
# 	if current_status == JobTimelineWorkStatus.DISABLED:
# 		current_status = JobTimelineWorkStatus.IDLE
# 		rect_position.x = 0
# 		$JobTimeLineWorkRtext.add_color_override("default_color", Color(1, 1, 1, 1))

# func save_previous_state():
# 	pass

# func requisite_cross_idle():
# 	pass

# func requisite_as_previous_state():
# 	pass
