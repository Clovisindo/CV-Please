extends StateComputer

class_name StateComputerActive

var show:bool = false


func _change_state():
	emit_signal("transitioned","idle")


func handle_input(event: InputEvent):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && !show:
		show = true
		$"../.."._applicant_selected(true)
	elif event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && show:
		show = false
		$"../.."._applicant_selected(false)
