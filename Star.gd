extends Area2D

var its_connected = false
onready var textures = [
	preload("res://assets/star2.png"),
	preload("res://assets/star3.png"),
	preload("res://assets/star4.png"),
	preload("res://assets/star5.png"),
	preload("res://assets/star6.png"),
	preload("res://assets/star7.png"),
	preload("res://assets/star8.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var index = int(rand_range(0, textures.size()))
	$Sprite2.texture = textures[index]
	$Sprite2.rotate(deg2rad(rand_range(0, 300)))
	$AnimationPlayer.play("move")
	$AnimationPlayer.playback_speed = rand_range(.2, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Star_mouse_entered():
	if !its_connected:
		get_parent().get_parent().star_selected = self


func _on_Star_mouse_exited():
	get_parent().get_parent().star_selected = null
