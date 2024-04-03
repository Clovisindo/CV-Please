extends Button

class_name EndPaymentResume

signal load_next_day_scene()
signal apply_global()

func _ready() -> void:
	$".".connect("pressed", self, "_on_button_ok_pressed")
	self.connect("apply_global", $"../..", "_apply_payments_global")

func _on_button_ok_pressed():
	emit_signal("apply_global")
	emit_signal("load_next_day_scene")
	print(" Load next day job.")
	LoadManager.load_scene(self,"res://scenes/main/main.tscn")
