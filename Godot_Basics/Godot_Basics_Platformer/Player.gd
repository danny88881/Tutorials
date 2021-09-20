extends KinematicBody2D

var speed = 100
var velocity = Vector2()
var gravity = 10
var terminal_velocity = 1000
var jump_height = 200

var coins = 0

var up = false
var down = false
var left = false
var right = false

func _ready():
	set_process_input(true)
	set_physics_process(true)

func _input(event):
	if event.is_action_pressed("up"):
		up = true
	elif event.is_action_released("up"):
		up = false
	
	if event.is_action_pressed("down"):
		down = true
	elif event.is_action_released("down"):
		down = false
	
	if event.is_action_pressed("left"):
		left = true
	elif event.is_action_released("left"):
		left = false
	
	if event.is_action_pressed("right"):
		right = true
	elif event.is_action_released("right"):
		right = false

func _physics_process(delta):
	var h_dir = int(right) - int(left)
	if h_dir != 0:
		$Sprite.scale.x = h_dir
	
	velocity.x = h_dir * speed
	if !is_on_floor():
		velocity.y += gravity
		velocity.y = min(terminal_velocity, velocity.y)
	if is_on_floor():
		if up:
			velocity.y = -jump_height
	move_and_slide(velocity, Vector2(0, -1))

func collect_coin():
	coins += 1
	$CanvasLayer/Label.text = "Coins: " + str(coins)
