extends Resource
class_name ResourceTimelineJob

export var textUI: String
export var timejob: String

func _init( t:String, ti:String):
	self.textUI = t
	self.timejob = ti
