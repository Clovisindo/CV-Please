extends StateCV

class_name StateCVActive

export var animation_velocity = 3

func enter():
	print("CV in Active State...")


func process_cv(result):
	if result.current_status == ApplicantResult.Status.VALID:
		emit_signal("transitioned","Approved")
	elif result.current_status == ApplicantResult.Status.NOT_VALID:
		emit_signal("transitioned","Rejected")
