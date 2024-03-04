extends Resource
class_name ResourceDummyResponse

export var response1: String
export var response2: String

func _init( r1:String, r2:String):
	self.response1 = r1
	self.response2 = r2
