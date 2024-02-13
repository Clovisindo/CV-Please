extends CVState

class_name CVStateIdle

func _ready():
	pass # Replace with function body.

func enter() -> void:
	print("Enter CV Idle State")
	transitioned.emit("Active")
	
func exit() -> void:
	print("Exit CV Idle State")
	
func update(delta: float) -> void:
	pass
 
func physics_update(delta: float) -> void:
	pass
