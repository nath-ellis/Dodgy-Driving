extends Node


const ENEMY = preload("res://scenes/Enemy.tscn")

var rand = RandomNumberGenerator.new()
var speed = 5
var enemy_speed = speed + 10
var coins = 0
var lane_blocked = false
var lane_to_block = 1
var started_blocking = Time.get_unix_time_from_system()


func _ready():
	rand.randomize()


func add_coin() -> void:
	coins += 1


func add_enemy(road) -> void:
	road.add_child(ENEMY.instance())


func add_enemy_at(road, x, y) -> void:
	var e = ENEMY.instance()

	road.add_child(e)

	if x == null:
		e.position = Vector2(e.position.x, y)
	elif y == null:
		e.position = Vector2(x, e.position.y)
	else:
		e.position =  Vector2(x, y)

	# Change velocity and sprite rotation
	if e.position.x == 120 or e.position.x == 239:
		e.sprite.rotation_degrees = 0

		if e.vel.y > 0:
			e.vel.y *= -1
	else:
		e.sprite.rotation_degrees = 180

		if e.vel.y < 0:
			e.vel.y *= -1


func remove_all_enemies(road) -> void:
	for e in road.get_children():
		# If it is an enemy
		if e is KinematicBody2D and !e.get_meta("border"):
			e.queue_free()


func block_lane(road) -> void:
	var x

	lane_to_block = rand.randi_range(1, 4)
	
	match lane_to_block:
		1: 
			x = 120
		2: 
			x = 239
		3: 
			x = 361
		4: 
			x = 480
	
	# Add enemies which will stay in the same lane
	for _i in range(5):
		add_enemy_at(road, x, null)
		
	started_blocking = Time.get_unix_time_from_system()
	lane_blocked = true


func open_lane() -> void:
	lane_blocked = false
