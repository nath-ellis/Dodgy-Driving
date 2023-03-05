extends Node2D


@onready var road_1 = $Road1
@onready var road_2 = $Road2
@onready var screen_height = get_viewport_rect().size.y


func _physics_process(_delta) -> void:
	# Move roads
	road_1.position = Vector2(
		road_1.position.x, 
		road_1.position.y + Manager.speed
	)
	road_2.position = Vector2(
		road_2.position.x, 
		road_2.position.y + Manager.speed
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
