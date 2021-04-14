extends KinematicBody2D

var positions = []
var index = 1
var can_move = false
var speed = 200.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if can_move:
		$Sprite.rotate(delta)
		var dir = (positions[index] - global_position).normalized()
		move_and_collide(dir * speed * delta)
		
		if floor(global_position.distance_to(positions[index])) <= 1:
			index += 1
			if index == positions.size():
				can_move = false
				get_parent().change_scene()
