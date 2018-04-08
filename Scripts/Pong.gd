extends Node2D

signal leftLose
signal rightLose
signal hit
signal lose

var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)

const INITIAL_BALL_SPEED = 150 # px/s

var ball_speed = INITIAL_BALL_SPEED

const PAD_SPEED = 500

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = $right.get_texture().get_size()
	set_process(true)

func _process(delta):
	var ball_pos = $ball.position
	var left_rect = Rect2($left.position - pad_size * 0.5, pad_size)
	var right_rect = Rect2($right.position - pad_size * 0.5, pad_size )
	
	ball_pos += direction * ball_speed * delta
	
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
    	direction.y = -direction.y
	
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		emit_signal('hit')
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	
	if(ball_pos.x < 0 or ball_pos.x > screen_size.x):
		if(ball_pos.x < 0):
			emit_signal('leftLose')
			direction = Vector2(-1, 0)
		else:
			emit_signal('rightLose')
			direction = Vector2(1, 0)
			
		ball_pos = screen_size*0.5
		ball_speed = INITIAL_BALL_SPEED
		
		emit_signal('lose')

	$ball.position = ball_pos
	
	# Move left pad
	var left_pos = $left.position

	if (left_pos.y > 0 and Input.is_action_pressed("left_move_up")):
    	left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down")):
    	left_pos.y += PAD_SPEED * delta

	$left.position = left_pos

	# Move right pad
	var right_pos = $right.position

	if (right_pos.y > 0 and Input.is_action_pressed("right_move_up")):
    	right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down")):
    	right_pos.y += PAD_SPEED * delta

	$right.position = right_pos

