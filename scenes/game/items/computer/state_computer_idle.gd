extends StateComputer

class_name StateComputerIdle


func enter():
	pass


func _change_state():
	emit_signal("transitioned","active")


