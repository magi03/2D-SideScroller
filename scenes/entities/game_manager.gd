extends Node

var key = 0
@onready var score_label: Label = $ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func key_add():
	key += 1
	score_label.text = "Du hast " +str(key) + " / 6 Schlüssel gesammelt"
