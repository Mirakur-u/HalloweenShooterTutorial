extends Node

class_name LevelManager

@onready var player: Player = $"../Player"
@onready var ui: UI = $"../UI"
@onready var wave_spawner: WaveSpawner = $"../WaveSpawner"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.set_initial_health(player.get_health())
	player.player_damaged.connect(on_player_damaged)
	wave_spawner.starting_wave.connect(ui.on_wave_started)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_player_damaged(current_health):
	ui.decrease_health(current_health)
