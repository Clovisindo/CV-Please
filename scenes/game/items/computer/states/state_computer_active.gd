extends StateComputer

class_name StateComputerActive

var show: bool = false


func enter():
	get_parent().get_parent().disabled = false


func disable_main_computer():
	emit_signal("transitioned", "idle")


func handle_input(event: InputEvent):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && !show:
		show = true
		$"../..".applicant_selected(true)
	elif event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT) && show:
		show = false
		$"../..".applicant_selected(false)
