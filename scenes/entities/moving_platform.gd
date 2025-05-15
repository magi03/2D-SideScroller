#extends Node
extends Path2D

class_name MovingPlatform

@export var path_time = 8.0	
@export var looping = false
@export var ease: Tween.EaseType #allow us to choose from the menu
@export var transition: Tween.TransitionType #allow us to choose from the menu
@export var path_follow_2D: PathFollow2D	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_tween() 

func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time).set_ease(ease).set_trans(transition)
	if !looping:
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, path_time).set_ease(ease).set_trans(transition)
	else: 
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, 0.0).set_ease(ease).set_trans(transition)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
