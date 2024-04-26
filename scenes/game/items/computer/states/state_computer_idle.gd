extends StateComputer

class_name StateComputerIdle


func enter():
	get_parent().get_parent().disabled = true


func _active_main_computer():
	emit_signal("transitioned","active")


