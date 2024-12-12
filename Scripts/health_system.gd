extends Node

class_name HealthSystem

@export var health = 20

signal died
signal damaged(damage_taken)

func damage(damage_taken: int):
	health -= damage_taken
	damaged.emit()
	
	if health <= 0:
		died.emit()
