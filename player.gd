class_name Player

extends Living
@onready var camera = $Camera2D

func _ready():
	camera.position = position

signal show_level_up()
var direction = Vector2.LEFT

@export var required_experience_until_next_level: float = 25.0
@export var experience_gain: float = 0.5
@export var experience_points: float = 0:
	get:
		return experience_points
	set(value):
		experience_points += value * experience_gain
		if experience_points >= required_experience_until_next_level:
			show_level_up.emit()

func _init() -> void:
	max_health_points = 100.0
	health_points = 100.0
	move_speed = 200.0
	
	self.over_healed.connect(over_healed_callback)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		position = position + (Vector2.LEFT * move_speed * delta)
		looking_direction = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		position = position + (Vector2.RIGHT* move_speed * delta)
		looking_direction = Vector2.RIGHT
	if Input.is_action_pressed("move_up"):
		position = position + (Vector2.UP* move_speed * delta)
		looking_direction = Vector2.UP
	if Input.is_action_pressed("move_down"):
		position = position + (Vector2.DOWN* move_speed * delta)
		looking_direction = Vector2.DOWN

func over_healed_callback(amount: float):
	self.experience_gain += amount * 0.1

func level_up():
	max_health_points *= 1.05
	health_points = max_health_points
	experience_points = 0
	required_experience_until_next_level *= 1.5
