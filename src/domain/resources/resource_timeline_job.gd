extends Resource
class_name ResourceTimelineJob

export var jobDescription: String
export var timejob: String

func _init( t:String, ti:String):
	self.jobDescription = t
	self.timejob = ti
