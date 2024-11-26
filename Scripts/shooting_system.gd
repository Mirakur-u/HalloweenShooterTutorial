extends Node2D

class_name ShootingSystem


@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

const PROJECTILE = preload("res://Scenes/projectile.tscn")

var animation_prefix
var can_shoot = true


func _input(event):
	if Input.is_action_just_pressed("shoot") && can_shoot:
		shoot()
		can_shoot = false
	

func shoot():
	var projectile = PROJECTILE.instantiate()
	projectile.global_position = global_position
	projectile.projectile_prefix = animation_prefix
	animated_sprite_2d.play("%s_shooting" % animation_prefix)
	get_tree().root.add_child(projectile)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "%s_shooting" % animation_prefix:
		animated_sprite_2d.play("%s_default" % animation_prefix)
		can_shoot = true
