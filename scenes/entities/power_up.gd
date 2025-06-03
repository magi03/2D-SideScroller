extends Area2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("enable_double_jump"):
			body.enable_double_jump()
		queue_free() # This removes the shoe from the scene
