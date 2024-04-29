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
	emit_signal("apply_global")
	emit_signal("apply_global_npay")
	emit_signal("load_next_day_scene")
	print(" Load next day job.")
	LoadManager.load_scene(self, "res://scenes/main/main.tscn")
