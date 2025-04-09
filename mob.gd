extends RigidBody2D

@export var speed = 150

func _ready():
	var target_position = get_viewport().get_visible_rect().size / 2
	var direction = (target_position - global_position).normalized()
	linear_velocity = direction * speed
