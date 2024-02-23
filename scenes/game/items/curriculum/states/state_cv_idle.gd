extends StateCV

class_name StateCVIdle

export var animation_velocity = 3


func enter():
	var tween = create_tween()
	tween.tween_property(cv, "modulate:a", 1, animation_velocity)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)


func process_skill_selected(_skill):
	emit_signal("transitioned", "Active")
