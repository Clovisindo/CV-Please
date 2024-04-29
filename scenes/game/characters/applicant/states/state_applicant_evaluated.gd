extends StateApplicant

class_name StateApplicantEvaluated


func enter():
	if (
		self.applicant.evaluation.current_status
		== ApplicantResult.Status.keys()[ApplicantResult.Status.VALID]
	):
		portrait.rotation_degrees = 45
	elif (
		self.applicant.evaluation.current_status
		== ApplicantResult.Status.keys()[ApplicantResult.Status.NOT_VALID]
	):
		portrait.flip_v = true
	applicant.cv.process_cv(self.applicant.evaluation)
	applicant.visible = false


func exit():
	pass
