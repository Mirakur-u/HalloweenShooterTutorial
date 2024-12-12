extends Node

class_name LevelManager

@onready var player: Player = $"../Player"
@onready var ui: UI = $"../UI"
@onready var wave_spawner: WaveSpawner = $"../WaveSpawner"
const VLAD_BOSS = preload("res://Scenes/vlad_boss.tscn")
@onready var enemy_movement_points: Node = $"../EnemyMovementPoints"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.set_initial_health(player.get_health())
	player.player_damaged.connect(on_player_damaged)
	wave_spawner.starting_wave.connect(ui.on_wave_started)
	wave_spawner.waves_finished.connect(on_waves_finished)
	player.player_died.connect(ui.on_player_died)
	

func on_waves_finished():
	var vlad_boss = VLAD_BOSS.instantiate()
	get_tree().root.add_child(vlad_boss)
	
	vlad_boss.global_position = Vector2(1116, 310)
	vlad_boss.movement_points = enemy_movement_points.get_children()
	vlad_boss.init()
	vlad_boss.vlad_damaged.connect(ui.change_boss_health_bar_value)
	vlad_boss.vlad_died.connect(ui.on_vlad_died)
	ui.init_boss_health_bar(vlad_boss.get_health())
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_player_damaged(current_health):
	ui.decrease_health(current_health)
