extends Resource

class_name ResourceEndgame

export(String, MULTILINE) var true_ending_text
export(String, MULTILINE) var bad_ending_text


func _init():
	self.true_ending_text = true_ending_text
	self.bad_ending_text = bad_ending_text
