extends Panel

export (Texture) var portrait 
var appl_name
export (EnumUtils.applicantSolution) var solution
var applResult:applicationResult = applicationResult.new()

func _ready():
	_set_applicant_data(portrait,"applicant 1")


#TODO carga dinamica de los applicants al currentApplicant en la UI
func _set_applicant_data( texture, name):
	$Portrait.texture = texture
	$Name.set_bbcode("[center]%s[/center]" % name)
	applResult._init_appl_result(EnumUtils.applicantSolution.valid)

func _get_application_result():
	return applResult
