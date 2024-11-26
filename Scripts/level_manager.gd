extends Node

class_name LevelManager

@onready var player: Player = $"../Player"
@onready var ui: UI = $"../UI"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.set_initial_health(player.get_health())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
