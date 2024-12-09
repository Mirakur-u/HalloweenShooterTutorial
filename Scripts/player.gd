extends Area2D


class_name Player

signal player_damaged(current_health: int)
signal player_died

@export var speed = 400
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shooting_system: ShootingSystem = $ShootingSystem
@onready var health_system: HealthSystem = $HealthSystem

var animation_prefix
var direction

func _ready():
	animation_prefix = GameConfig.PlayerType.keys()[GameConfig.player_type].to_snake_case()
	animated_sprite_2d.play("%s_default" %animation_prefix)
	shooting_system.animation_prefix = animation_prefix
	health_system.died.connect(on_died)


func _process(delta):
	var direction = Input.get_vector("left","right","up","down")
	var next_position = position + direction * speed * delta
	if !is_within_screen_bounds(next_position):
		return
	position = next_position
	

func is_within_screen_bounds(next_position: Vector2):
	var half_size = collision_shape_2d.shape.get_rect().size/2
	
	var viewport_size = get_viewport_rect().size
	
	if next_position.y > half_size.y && next_position.y + half_size.y < viewport_size.y && next_position.x > half_size.x && next_position.x + half_size.x < viewport_size.x:
		return true
	
	return false


func get_health():
	return health_system.health


func _on_area_entered(area: Area2D) -> void:
	health_system.damage(1)
	player_damaged.emit(get_health())
	area.queue_free()
	
	var blink_tween = get_tree().create_tween()
	blink_tween.tween_property(animated_sprite_2d, "modulate", Color.RED, .25)
	blink_tween.chain().tween_property(animated_sprite_2d, "modulate", Color.WHITE, .25)
	

func on_died():
	player_died.emit()
	queue_free()
