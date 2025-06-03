extends Area2D


@export var load_level: String
@export var anim: AnimatedSprite2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if game_manager.key >= 6:
			anim.play("open")
			print("Door opening for", body.name)
			get_tree().change_scene_to_file(load_level)
		else:
			print("Not enough keys:", game_manager.key)
