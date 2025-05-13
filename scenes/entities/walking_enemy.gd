"""
extends CharacterBody2D

const SPEED = 100.0
var direction := -1  # -1 = left, 1 = right

@onready var edge_check := $EdgeCheck

var flip_cooldown := 0.0

func _physics_process(delta: float) -> void:
	flip_cooldown -= delta

	# Update raycast position based on direction
	edge_check.position.x = 16 * direction

	# Only flip if cooldown expired
	if flip_cooldown <= 0.0 and (is_on_wall() or not edge_check.is_colliding()):
		direction *= -1
		flip_cooldown = 0.2  # Prevent instant re-flip

	velocity.x = direction * SPEED
	move_and_slide()
"""

extends CharacterBody2D

const SPEED = 100.0
var direction := -1  # -1 = left, 1 = right

@onready var edge_check_right := $EdgeCheckRight
@onready var edge_check_left := $EdgeCheckLeft
@onready var sprite:= $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	# Reverse direction if hitting wall
	if is_on_wall() or not edge_check_right.is_colliding() or not edge_check_left.is_colliding():
		direction *= -1
	sprite.flip_h= direction > 0
	velocity.x = direction * SPEED
	
	move_and_slide() 
