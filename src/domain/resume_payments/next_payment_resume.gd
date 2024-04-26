extends Button

class_name NextPaymentResume

signal load_payment_panel


func _ready() -> void:
	$".".connect("pressed", self, "_on_button_ok_pressed")


func _on_button_ok_pressed():
	emit_signal("load_payment_panel")
