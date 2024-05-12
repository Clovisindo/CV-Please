extends StateComputer

class_name StateComputerIdle


func enter():
	get_parent().get_parent().visible = false
	get_parent().get_parent().disabled = true


func active_main_computer():
	emit_signal("transitioned", "active")
