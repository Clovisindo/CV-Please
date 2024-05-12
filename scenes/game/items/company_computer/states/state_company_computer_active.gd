extends StateCompanyComputer

class_name StateCompanyComputerActive

enum PanelStatus {
	OPEN,
	CLOSED,
}

export(PanelStatus) var current_status
var show: bool = false


func enter():
	get_parent().get_parent().visible = true
	get_parent().get_parent().disabled = false


func panel_open():
	if current_status == PanelStatus.CLOSED:
		current_status = PanelStatus.OPEN


func panel_closed():
	if current_status == PanelStatus.OPEN:
		current_status = PanelStatus.CLOSED


func disable_company_computer():
	emit_signal("transitioned", "idle")


func handle_input(event: InputEvent):
	if current_status == PanelStatus.OPEN:
		_process_as_open(event)
	elif current_status == PanelStatus.CLOSED:
		_process_as_closed(event)


func _process_as_open(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && show:
		show = false
		current_status = PanelStatus.CLOSED
		$"../..".applicant_selected(false)
		return


func _process_as_closed(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && !show:
		show = true
		current_status = PanelStatus.OPEN
		$"../..".applicant_selected(true)
		return
