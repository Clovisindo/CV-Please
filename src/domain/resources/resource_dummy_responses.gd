extends Resource
class_name ResourceDummyResponse

export var textUI: String
export var response: String

func _init( t:String, r:String):
	self.textUI = t
	self.response = r
