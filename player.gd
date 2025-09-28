extends CharacterBody2D

var double = false

var canDrop = false

var speed = 140
var acc = 40
var dec = 60
var jump = 305

var cool = false

var gravity = 1400

var direction = 0
var was_on_floor

var posessedReset

signal reset
signal drop
signal save

var platform_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("reset"):
		restart()
	
	if Info.posessed == preload("res://BigDude.tscn"):
		$Center/Sprite2D.texture = load("res://Sprites2/PlayerBig.png")
	else:
		$Center/Sprite2D.texture = load("res://Sprites2/dude.png")
	
	Info.playerPos = global_position
	
	if velocity.y > 10:
		velocity.y +=  gravity * delta * 1.6
	elif not is_on_floor():
		velocity.y +=  gravity * delta
	
	walking()
	jumping()
	
	if Info.posessing and Input.is_action_just_pressed("Posess") and canDrop:
		#var drop = load("res://dude.tscn").instantiate()
		#drop.position = global_position
		#reset.connect(drop._on_player_reset)
		#get_parent().add_child(drop)
		emit_signal("drop")
		canDrop = false
		Info.hop = false
		Info.posessing = false
		Info.posessed = null
		velocity.y = -jump
		$Cooldown.start()
		cool = true
	
	if Info.posessing:
		canDrop = true

	animation()
	move_and_slide()

func jumping():
		if Input.is_action_just_pressed("jump") and is_on_floor() or Input.is_action_just_pressed("jump") and not $Coyote.is_stopped() or Input.is_action_pressed("jump") and is_on_floor() and not $JBuffer.is_stopped():
			#$noSoundCut.play(jumpSound, 1, 0)
			if Info.hop:
				if Info.posessed == preload("res://BigDude.tscn"):
					velocity.y = -jump / 1.2
				else:
					velocity.y = -jump
			else:
				velocity.y = -jump / 2

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
	if not Info.hop:
		$CollisionShape2D/AnimationPlayer.play("Small")
	elif Info.posessed == preload("res://BigDude.tscn"):
		$CollisionShape2D/AnimationPlayer.play("Big")
	else:
		$CollisionShape2D/AnimationPlayer.play("Human")
	
	if not Info.hop:
		$AnimationPlayer.play("Crawl")
	elif not is_on_floor() and velocity.y <= 0:
		$AnimationPlayer.play("Jump")
	elif not direction == 0:
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Deadly"):
		restart()

func restart():
		$ColorRect/AnimationPlayer.play("Fade")
		global_position = Info.chekPoint
		emit_signal("reset")
		Info.hop = Info.hopSave
		Info.posessed = Info.posessedSave
		Info.posessing = Info.posessingSave

func _on_cooldown_timeout() -> void:
	cool = false
