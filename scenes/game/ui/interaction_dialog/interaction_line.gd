extends Control

class_name InteractionLine


func enable_text(text: String):
	$Label.set_modulate(Color("c05151"))
	$Label.text = text


func set_player_text(text: String):
	$Label.set_modulate(Color(1, 1, 1, 1))
	$Label.text = text


func set_applicant_text(text: String):
	$Label.set_modulate(Color(0, 0.392157, 0, 1))
	$Label.text = text
