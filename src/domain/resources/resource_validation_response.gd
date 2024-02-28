extends Resource
class_name ResourceValidationResponse

export var validationOKResp: String
export var validationNOKResp: String

func _init( ok:String, nok:String):
	self.validationOKResp = ok
	self.validationNOKResp = nok
