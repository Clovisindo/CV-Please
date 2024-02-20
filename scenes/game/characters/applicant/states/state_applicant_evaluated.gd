extends StateApplicant

class_name StateApplicantEvaluated

func enter():
	print("%s evaluated" % self.applicant)
	applicant.cv.process_cv(self.applicant.evaluation)
