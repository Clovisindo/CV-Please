
extends Resource
class_name ResourceQuestAnsw

export var textUI: String
export var textUI_secondary: String
export var question: String
export var answer: String

func _init( t:String, q: String, a: String, t2:String = ""):
	self.textUI = t
	self.textUI_secondary = t2
	self.question = q
	self.answer = a

