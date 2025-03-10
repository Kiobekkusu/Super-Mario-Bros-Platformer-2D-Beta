extends CharacterBody2D

class_name Player

#Variables
@export var gravity = 500
@export var jump_speed = 230 # 230 - 280
@export var speed = 150
@export var limit_speed = 200
@export var accel = 3.0
@export var friction = 10.0 #originalmente era 0.1 pero bruh

@onready var raycast = $RayCast2D

var imgspeed = 4 # 4 - 8 
var count_jump = 0; # accountant of jumps

#states
var on_floor = false	
var speedrun = false

func _physics_process(delta):
	# Variables declared
	var anim_player = $Sprite2D/AnimationPlayer
	var spr_player = $Sprite2D
	var direction = Input.get_axis("k_left", "k_right")
	
	# Move X
	velocity.x += (accel * direction) * speed * delta
	if velocity.x >= speed:
		velocity.x = speed
	elif velocity.x <= -speed:
		velocity.x = -speed
	
	# if you pressed the key run max speed.
	var spdrun_pressed = Input.is_action_pressed("k_spdrun")
	if spdrun_pressed and direction:
		imgspeed = 8
		speed += 2
		if speed > limit_speed:
			speed = limit_speed
			jump_speed = 280;
		elif -speed < -limit_speed:
			speed = -limit_speed
			jump_speed = 280;
		anim_player.speed_scale = imgspeed
	else:
		speed = 150
		anim_player.speed_scale = 4
		jump_speed = 210
	
	# if not move
	if direction == 0:
		if velocity.x > 0:
			velocity.x -= friction
			if velocity.x < 0:
				velocity.x = 0
		elif velocity.x < 0:
			velocity.x += friction
			if velocity.x > 0:
				velocity.x = 0
	
	#if you move X, run the animation
	if direction > 0:
		anim_player.play("RUN")
		if on_floor == true:
			spr_player.flip_h = false
	elif direction < 0:
		anim_player.play("RUN")
		if on_floor == true:
			spr_player.flip_h = true 
	else:
		anim_player.play("IDLE")

	# if you key press Jump
	var jump_pressed = Input.is_action_just_pressed("k_up")
	if not is_on_floor():
		velocity.y += gravity * delta
		count_jump += 1 # quantity of jumps: 1
		anim_player.play("JUMP")
		on_floor = false
	else:
		count_jump = 0;
		on_floor = true
	
	# if you key press jump	
	if jump_pressed and count_jump < 1:
		velocity.y -= jump_speed
		count_jump += 1;
		
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is Block and not collider.is_moving:
			collider.move_block()
			velocity.y += jump_speed
			
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is BlockCoin and not collider.is_moving:
			collider.move_block()
			velocity.y += jump_speed
			
		
	# print(velocity.x)
		
	move_and_slide()
