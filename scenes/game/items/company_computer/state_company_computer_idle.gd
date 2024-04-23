extends StateCompanyComputer

class_name StateCompanyComputerIdle

func enter():
	get_parent().get_parent().disabled = true


func _active_company_computer():
	emit_signal("transitioned","active")
