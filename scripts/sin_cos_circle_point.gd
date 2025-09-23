class_name SinCosCirclePoint extends Node2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var label : Label = $Label

var current_angle = 0.0

const double_pi = PI * 2.0

func _process(delta: float) -> void:
	current_angle += 0.01
	if current_angle > double_pi:
		current_angle -= double_pi
	sprite.material.set_shader_parameter("angle", current_angle)
	label.text = str(current_angle)
