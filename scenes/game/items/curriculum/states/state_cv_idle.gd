extends StateCV

class_name StateCVIdle

export var animation_velocity = 20

func enter():
	var tween = create_tween().tween_property(cv, "modulate:a", 1, animation_velocity)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
