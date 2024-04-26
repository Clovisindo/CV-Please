extends StateApplicant

class_name StateApplicantEntrance

var velocity = 3

func enter():
    move_applicant()


func move_applicant():
    var tween = create_tween().set_parallel(false)
    tween.tween_property(portrait, "position", self.applicant.middle_position, velocity)
    tween.chain().tween_property(portrait, "position", self.applicant.interview_position, velocity)
    yield(tween,"finished")
    applicant_to_review()


func applicant_to_review():
    emit_signal("transitioned","Reviewing")
    applicant._load_applicant_computer()#emit signal al mainComputer para avanzar a estado activo 
    applicant._load_company_computer()#emit signal al companyComputer para avanzar a estado activo 