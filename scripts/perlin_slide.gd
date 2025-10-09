class_name PerlinSlide extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

var current_slide = 0.0

func _process(delta: float) -> void:
	current_slide += 0.01
	#if current_slide > 1.0:
		#current_slide = 1.0
	sprite.material.set_shader_parameter("x_moved", current_slide)
