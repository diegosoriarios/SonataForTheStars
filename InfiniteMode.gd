extends Node2D

var line_index = 1
var star_selected = null
var star_index = 0
var closest_star_index = 0
onready var Star = preload("res://Star.tscn")
onready var MoveParticle = preload("res://MoveParticle.tscn")

var stars_count = 6

func _ready():
	randomize()
	for i in range(stars_count):
		var star = Star.instance()
		star.position.x = rand_range(-480, 480)
		star.position.y = rand_range(-250, 150)
		$Stars.add_child(star)
	
	var index = rand_range(0, $Stars.get_child_count())
	$Line2D.set_point_position(0, $Stars.get_child(index).position)
	$Stars.get_child(index).its_connected = true
	star_index = index
	closest_star_index = find_closest_node(star_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		$Line2D.set_point_position(line_index, get_global_mouse_position())
	if event is InputEventMouseButton:
		if event.is_pressed() and star_selected != null:
			var selected_index = $Stars.get_children().find(star_selected)
			if selected_index == closest_star_index:
				line_index += 1
				$Line2D.add_point(star_selected.position, line_index)
				star_index = selected_index
				closest_star_index = find_closest_node(star_index)
				star_selected.its_connected = true
				
				if line_index == $Stars.get_child_count():
					stage_clear()

func find_closest_node(index):
	var spawn_points = $Stars.get_children()

	var nearest_spawn_point = spawn_points[index]
	var min_point = 1000000

	for spawn_point in spawn_points:
		if !spawn_point.its_connected and index != $Stars.get_children().find(spawn_point):
			var distance = spawn_point.global_position.distance_to(spawn_points[index].global_position)
			if distance < min_point:
				nearest_spawn_point = spawn_point
				min_point = distance
	
	return $Stars.get_children().find(nearest_spawn_point)

func stage_clear():
	var move_particle = MoveParticle.instance()
	move_particle.position = $Line2D.get_point_position(0)
	move_particle.positions = $Line2D.points
	add_child(move_particle)
	move_particle.can_move = true

func change_scene():
	get_tree().reload_current_scene()
