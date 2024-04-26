extends StateCompanyComputer

class_name StateCompanyComputerIdle

func enter():
	companyComputer.disabled = true


func _active_company_computer():
	emit_signal("transitioned","active")
