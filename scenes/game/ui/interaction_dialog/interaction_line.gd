extends Control

class_name InteractionLine


func enable_text(text: String):
	$Label.set_modulate(Color("c05151"))
	$Label.text = text


func disable_text():
	$Label.set_modulate(Color("000000"))
