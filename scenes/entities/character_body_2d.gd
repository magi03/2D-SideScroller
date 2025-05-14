extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_force : float = -550.0
@export var jump_time : float = 0.25
@export var coyote_time : float = 0.075
@export var gravity_multiplier : float = 2.0


var is_jumping : bool = false
var jump_timer: float = 0
var coyote_timer : float = 0 
var can_control : bool = true

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _physics_process(delta: float) -> void:
	if not can_control: return
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		velocity +=get_gravity() * gravity_multiplier*delta
		coyote_timer += delta
	else:
		coyote_timer = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer < coyote_time):
		velocity.y = jump_force
		is_jumping = true
	elif Input.is_action_just_pressed("jump") and is_jumping:
		velocity.y = jump_force
		
	if is_jumping and Input.is_action_just_pressed("jump") and jump_timer<jump_time:
		jump_timer += delta
	else: 
		is_jumping = false
		jump_timer = 0 

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

#Flip the sprite to face the direction moving
	if direction !=0:
		sprite_2d.flip_h = direction > 0
	
	handle_animations(direction)
	
	move_and_slide()
	
func handle_animations(direction : float) -> void:
	if abs(direction) > 0.1 and is_on_floor():
		animation_player.play("running")
	elif not is_on_floor():
		animation_player.play("jupming")
	else:
		animation_player.play("idle")

func handle_danger() -> void:
	print("Player died!")
	visible = false
	can_control = false
	
	await get_tree().create_timer(1).timeout
	reset_player()
	
func reset_player() -> void:
	global_position = LevelManager.loaded_level.level_start_pos.global_position
	visible = true
	can_control = true
