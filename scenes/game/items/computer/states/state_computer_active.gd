extends StateComputer

class_name StateComputerActive


enum panelStatus {
	OPEN,
	CLOSED,
}

export(panelStatus) var current_status
var show: bool = false


func enter():
	get_parent().get_parent().disabled = false


func panel_open():
	if current_status == panelStatus.CLOSED:
		current_status = panelStatus.OPEN


func panel_closed():
	if current_status == panelStatus.OPEN:
		current_status = panelStatus.CLOSED

func disable_main_computer():
	emit_signal("transitioned", "idle")


func handle_input(event: InputEvent):
	if current_status == panelStatus.OPEN:
		_process_as_open(event)
	elif current_status == panelStatus.CLOSED:
		_process_as_closed(event)

	# if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && !show:
	# 	show = true
	# 	$"../..".applicant_selected(true)
	# 	return
	# elif event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && show:
	# 	show = false
	# 	$"../..".applicant_selected(false)
	# 	return


func _process_as_open(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && show:
		show = false
		current_status = panelStatus.CLOSED
		$"../..".applicant_selected(false)
		return


func _process_as_closed(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && !show:
		show = true
		current_status = panelStatus.OPEN
		$"../..".applicant_selected(true)
		return