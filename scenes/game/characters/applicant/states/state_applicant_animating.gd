extends StateApplicant

class_name StateApplicantAnimating

var velocity = 50



func enter():
    move_applicant()
    
    

func exit():
	pass


func update(delta):
	pass


func move_applicant():
    var tween = create_tween().tween_property(portrait, "position", self.applicant.interview_position, 10)
    yield(tween,"finished")
    process_applicant()


func process_applicant():
	emit_signal("transitioned","Evaluated")
	
