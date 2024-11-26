extends CanvasLayer

class_name UI

@onready var health_container: HBoxContainer = %HealthContainer

const LIFE_FULL_UI = preload("res://Assets/UIElements/LifeFullUI.png")
const LIFE_HALF_UI = preload("res://Assets/UIElements/LifeHalfUI.png")

func set_initial_health(health:int):
	var full_health_textures = health /2
	
	for i in full_health_textures:
		var texture_rect = TextureRect.new()
		texture_rect.texture = LIFE_FULL_UI
		health_container.add_child(texture_rect)
		
	var half_life_texture = health % 2
	if half_life_texture != 0:
		var half_life_texture_rect = TextureRect.new()
		half_life_texture_rect.texture = LIFE_HALF_UI
		health_container.add_child(half_life_texture_rect)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
