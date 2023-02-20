extends Node2D


var Speed = 10

onready var road_1 = $Road1
onready var road_2 = $Road2
onready var left_border = $LeftBorder
onready var right_border = $RightBorder
onready var screen_height = get_viewport_rect().size.y


func _ready():
	# Add metadata
	left_border.set_meta("border", true)
	right_border.set_meta("border", true)


func _physics_process(_delta):
	# Move roads
	road_1.position = Vector2(
		road_1.position.x, 
		road_1.position.y + Speed
	)
	road_2.position = Vector2(
		road_2.position.x, 
		road_2.position.y + Speed
	)
	
	# Move if off screen
	if road_1.position.y >= screen_height: 
		road_1.position = Vector2(
			road_1.position.x, 
			-(road_1.texture.get_height() * road_1.scale.y)
		)

	if road_2.position.y >= screen_height: 
		road_2.position = Vector2(
			road_2.position.x, 
			-(road_2.texture.get_height() * road_2.scale.y)
		)
