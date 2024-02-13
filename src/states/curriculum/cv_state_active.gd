extends CVState

class_name CVStateActive

func _ready():
	pass # Replace with function body.

func enter() -> void:
	print("Enter CV Active State")
	
func exit() -> void:
	print("Exit CV Active State")
	
func update(delta: float) -> void:
	emit_signal("transitioned",  "Approved")
 
func physics_update(delta: float) -> void:
	pass
