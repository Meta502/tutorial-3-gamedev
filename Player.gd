extends KinematicBody2D

export (int) var speed = 600
export (int) var gravity = 1200
export (int) var jump_speed = -600
export var dash_window = 300

const UP = Vector2(0,-1)

var velocity = Vector2()
var states = {
	"can_double_jump": true
}

func _ready():
	pass

func get_input():
	var sprite = get_node("Sprite")
	velocity.x = 0
	if Input.is_action_pressed('right'):
		velocity.x += speed
		sprite.transform = sprite.transform.rotated(deg2rad(10))
	if Input.is_action_pressed('left'):
		velocity.x -= speed
		sprite.transform = sprite.transform.rotated(deg2rad(-10))
	if Input.is_action_just_pressed("down") and not is_on_floor():
		velocity.y += 2000
	if Input.is_action_pressed('dash'):
		velocity.x *= 8
		
	if (is_on_floor() or states.can_double_jump) and Input.is_action_just_pressed("up"):
		if not is_on_floor():
			states.can_double_jump = false
		else:
			states.can_double_jump = true
		velocity.y = jump_speed
		
func handle_sprite(velocity):
	var sprite = get_node("Sprite")
	
	print(sprite.transform.get_scale())
	if velocity.x < 0 and sprite.transform.get_scale().y > 0:
		sprite.transform = sprite.transform.scaled(Vector2(-1, 1))
	elif velocity.x > 0 and sprite.transform.get_scale().y < 0:
		sprite.transform = sprite.transform.scaled(Vector2(-1, 1))
		

func _physics_process(delta):
	get_input()
	velocity.y += delta * gravity
	velocity = move_and_slide(velocity, UP)
	# handle_sprite(velocity)

