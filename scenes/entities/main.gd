extends Node

@export var avaliable_levels: Array[LevelData]

@onready var _2d_scene: Node2D = $"2DScene"

func _ready() -> void:
	LevelManager.main_scene = _2d_scene
	LevelManager.levels = avaliable_levels
