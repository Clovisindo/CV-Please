extends StateApplicant

class_name StateApplicantExit

var velocity = 3


func enter():
	move_applicant()


func move_applicant():
	applicant._unload_applicant_computer()  #emit signal al mainComputer para avanzar a estado inactivo
	applicant._unload_company_computer()  #emit signal al companyComputer para avanzar a estado inactivo
	var tween = create_tween().set_parallel(false)
	tween.tween_property(portrait, "position", self.applicant.middle_position, velocity)
	tween.chain().tween_property(portrait, "position", self.applicant.entrance_position, velocity)
	yield(tween, "finished")
	close_applicant()  #el yield funciona si es un metodo, si pones el signal a continuacion lo ejecuta igual


func close_applicant():
	emit_signal("transitioned", "Evaluated")
