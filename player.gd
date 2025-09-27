extends CharacterBody2D

var hop = false
var double = false
var wall = false


var speed = 140
var acc = 40
var dec = 60
var jump = 305

var gravity = 1500

var direction = 0
var was_on_floor


func _physics_process(delta: float) -> void:
	
	if velocity.y > 10:
		velocity.y +=  gravity * delta * 1.6
	elif not is_on_floor():
		velocity.y +=  gravity * delta
	
	walking()
	if hop:
		jumping()
	
	
	animation()
	move_and_slide()

func jumping():
		if Input.is_action_just_pressed("jump") and is_on_floor() or Input.is_action_just_pressed("jump") and not $Coyote.is_stopped() or Input.is_action_pressed("jump") and is_on_floor() and not $JBuffer.is_stopped():
			#$noSoundCut.play(jumpSound, 1, 0)
			velocity.y = -jump
		
		elif Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y = 0
		
		if Input.is_action_just_pressed("jump") and not is_on_floor():
			$JBuffer.start()
		
		
		#if is_on_floor() and not was_on_floor: #Osu maahan
			#$noSoundCut.play(laskuSound, 1, 0)
			
		
		if was_on_floor != is_on_floor(): #Poistut maalta
			$Coyote.start()
		was_on_floor = is_on_floor()


func walking():
	direction = Input.get_axis("left", "right")
	if direction > 0:
		direction = 1
	elif direction < 0:
		direction = -1
	
	if direction == 1 and velocity.x < speed:
		velocity.x =  move_toward(velocity.x, speed, acc)
		$Center.scale.x = 1
	elif direction == -1 and velocity.x > -speed:
		velocity.x =  move_toward(velocity.x, speed * -1, acc)
		$Center.scale.x = -1
	else:
		velocity.x =  move_toward(velocity.x, 0, dec)

func animation():
	if not hop:
		$AnimationPlayer.play("Crawl")
	elif not is_on_floor() and velocity.y <= 0:
		$AnimationPlayer.play("Jump")
	elif not direction == 0:
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Idle")
