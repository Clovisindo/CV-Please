extends Button

class_name EndPaymentResume

signal load_next_day_scene
signal apply_global
signal apply_global_npay


func _ready() -> void:
	$".".connect("pressed", self, "_on_button_ok_pressed")  #decision_button fin escena de juego principal
	self.connect("apply_global", $"../..", "_apply_payments_global")  #Fin escena resumen candidatos, conectado gd panel
	self.connect("apply_global_npay", $"../..", "_apply_npays_global")  #Fin escena resumen candidatos, conectado gd panel


func _on_button_ok_pressed():
	$ButtonEffectSFX.playing = true
	emit_signal("apply_global")
	emit_signal("apply_global_npay")
	emit_signal("load_next_day_scene")
	print(" Load next day job.")
	#aqui ira tambien el comprobar si gameover
	if Global.check_is_gameover():
		LoadManager.load_scene(
			get_tree().get_root().get_node("resume_applicant"),
			"res://scenes/main/gameover_scene.tscn"
		)
	else:
		if Global.current_month >= 6:
			Global.set_is_true_ending()
			LoadManager.load_scene(
				get_tree().get_root().get_node("resume_applicant"),
				"res://scenes/main/end_game.tscn"
			)
		else:
			LoadManager.load_scene(
				get_tree().get_root().get_node("resume_applicant"), "res://scenes/main/main.tscn"
			)
