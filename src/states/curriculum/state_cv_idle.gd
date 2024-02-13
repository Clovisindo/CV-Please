extends State

class_name StateCVIdle

func _ready():
	pass # Replace with function body.

func enter() -> void:
	print("Enter CV Idle State")
	emit_signal("transitioned","Active") # For testing purposes
	
func exit() -> void:
	print("Exit CV Idle State")
	
func update(delta: float) -> void:
	pass
 
func physics_update(delta: float) -> void:
	pass
