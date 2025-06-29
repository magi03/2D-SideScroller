extends CanvasLayer

@export var debug: bool = false
@export var side_label_node: PackedScene = preload("res://scenes/levels/side_label.tscn")

@onready var texture_rect: TextureRect = $TextureRect
@onready var mid: Panel = $Mid
@onready var side: VBoxContainer = $Side
@onready var top: TextureRect = $Top

var mid_tween_reference = null
var top_tween_reference = null


func _ready() -> void:
	mid.modulate = Color(1,1,1,0)
	top.modulate = Color(1,1,1,0)
func _input(event):
	if debug and event is InputEventKey:
		if event.pressed and event.keycode == KEY_1:
			show_side("Debug message")
		if event.pressed and event.keycode == KEY_2:
			show_mid("Debug message")
		if event.pressed and event.keycode == KEY_3:
			show_top("Debug message")

func show_side(message: String = "Item"): 
	var side_label: Label = side_label_node.instantiate()
	side_label.text = message
	side.add_child(side_label)
	
	var tween: Tween = side_label.create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(Callable(side_label, "queue_free"))

func show_mid(message = "Message."):
	if mid_tween_reference:
		mid_tween_reference.kill()
		
	mid.find_child("Label").text = message
	mid.modulate = Color(1,1,1,1)
	
	mid_tween_reference = create_tween()
	mid_tween_reference.tween_interval(2)
	mid_tween_reference.tween_property(mid, "modulate", Color(1,1,1,0),0.5)

func show_top(message = "Area."):
	if top_tween_reference:
		top_tween_reference.kill()
		
	top.find_child ("Label").text = message
	top.scale = Vector2(0.8, 0.8)
	top.modular = Color (1,1,1,0)

	top_tween_reference = create_tween().set_parallel(true)
	top_tween_reference.tween_property(top,"scale", Vector2(1,1),0.5)
	top_tween_reference.tween_property(top, "modulate", Color(1,1,1,1),0.5)
	
	top_tween_reference.chain().tween_interval(3)
	top_tween_reference.chain().tween_property(top, "modulate", Color(1,1,1,0),0.5)
	
