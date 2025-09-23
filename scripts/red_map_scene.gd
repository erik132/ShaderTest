class_name RedMapScene extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

var progress = 0.0
var max_vertex_offset = 320.0 / 2.0
var current_vertex_offset = 0.0

func _physics_process(delta: float) -> void:
	if progress < 0.5:
		progress += 0.001
		current_vertex_offset = max_vertex_offset * progress * 2.0
		sprite.material.set_shader_parameter("progress", progress)
		sprite.material.set_shader_parameter("vertex_offset", current_vertex_offset)
