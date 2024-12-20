extends Area2D

class_name Enemy

signal killed

var sounds = [
	preload("res://Assets/sounds/hit1.mp3"),
	preload("res://Assets/sounds/hit2.mp3"),
	preload("res://Assets/sounds/hit3.mp3"),
	preload("res://Assets/sounds/hit4.mp3"),
	preload("res://Assets/sounds/hit5.mp3")
]

@onready var shooting_system: EnemyShootingSystem = $ShootingSystem
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shooting_timer: RandomTimer = $ShootingSystem/Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var movement_points
var speed = 250
var default_animation_name
var shooting_animation_name
var current_movement_point

func init(config, enemy_movement_points):
	default_animation_name = "%s_default" %config.enemy_name
	shooting_animation_name = "%s_shoot" %config.enemy_name
	
	animated_sprite_2d.play(default_animation_name)
	movement_points = enemy_movement_points
	collision_shape_2d.shape = config.enemy_collision_shape
	
	var random_point = movement_points.pick_random()
	current_movement_point = random_point.position
	shooting_system.shot.connect(on_shot)
	shooting_system.projectile_texture = config.projectile_texture
	shooting_system.projectile_collision_shape = config.projectile_collision_shape
	audio_stream_player_2d.stream = sounds.pick_random()
	audio_stream_player_2d.finished.connect(on_sound_finished)

func on_shot():
	animated_sprite_2d.play(shooting_animation_name)
	

func _process(delta: float) -> void:
	global_position = global_position.move_toward(current_movement_point, delta * speed)
	if global_position.distance_squared_to(current_movement_point) < .1:
		current_movement_point = movement_points.pick_random().global_position


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "die":
		killed.emit()
		if !audio_stream_player_2d.playing:
			queue_free()
	if animated_sprite_2d.animation == shooting_animation_name:
		animated_sprite_2d.play(default_animation_name)


func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		set_collision_layer_value(2, false)
		shooting_system.stop()
		set_process(false)
		audio_stream_player_2d.play()
		killed.emit()
		animated_sprite_2d.play("die")
		area.queue_free()

func on_sound_finished():
	if animated_sprite_2d.animation == "die" && !animated_sprite_2d.is_playing():
		queue_free()
