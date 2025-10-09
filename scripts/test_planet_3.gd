class_name TestPlanet3 extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

const double_pi = PI * 2.0

var current_angle = 0.0

func _process(delta: float) -> void:
	current_angle += 0.01
	if current_angle > double_pi:
		current_angle = 0.0
	sprite.material.set_shader_parameter("planet_angle", current_angle)
