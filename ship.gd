extends CharacterBody2D

var _screen_size: Vector2 = Vector2.ZERO
var _forward_speed: float = 0.0
var _yaw_speed: float = 0.0


func _ready() -> void:
	motion_mode = MotionMode.MOTION_MODE_FLOATING
	_screen_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	set_directional_speed()
	check_screen_wrap()
	
	rotation += _yaw_speed * delta
	velocity += transform.y * _forward_speed * delta
	
	move_and_slide()


func set_directional_speed():
	if Input.is_action_pressed("input_accelerate"):
		_forward_speed += -3.0
	if Input.is_action_pressed("input_decelerate"):
		_forward_speed += 3.0
	if Input.is_action_pressed("input_left"):
		_yaw_speed += -0.1
	if Input.is_action_pressed("input_right"):
		_yaw_speed += 0.1
	if Input.is_action_just_released("input_accelerate") or Input.is_action_just_released("input_decelerate"):
		_forward_speed = 0


func check_screen_wrap():
	if position.x > _screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = _screen_size.x
	if position.y > _screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = _screen_size.y
