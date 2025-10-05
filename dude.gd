extends CharacterBody2D

var onArea = false
var gravity = 150

var blood = preload("res://blood_splash.tscn")
var blow = preload("res://DudeExplos.mp3")
var audio = preload("res://audio_player.tscn")

var resetPos

var posessed = false
var disabled = false
var disableOnReset = false

var dead = false

@export var evil : bool

func _ready() -> void:
	resetPos = global_position
	velocity = Vector2(0, 0)
	if evil:
		$Dude.texture = load("res://Sprites2/Devil.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y +=  gravity * delta * 1.6
	else:
		velocity.y = 0
	

	
	#if Input.is_action_just_pressed("Posess") and onArea:
	#	sacrifice()
	
	move_and_slide()
	
	if disabled:
		$CollisionShape2D.disabled = true
		hide()
		global_position = Info.playerPos
		global_position.y -= 2
	else:
		$CollisionShape2D.disabled = false

func sacrifice():
	Info.posessing = true
	Info.hop = true
	Info.posessed = load("res://dude.tscn")
	disabled = true
	posessed = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not disabled:
		if not body.cool and not Info.posessing:
			sacrifice()
#	if body.is_in_group("Player"):
#		onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
#	if body.is_in_group("Player"):
#		onArea = false


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Deadly") and not disabled:
		var p = blood.instantiate()
		p.position = global_position
		get_parent().add_child(p)
		if not name == "Dude10":
			var a = audio.instantiate()
			a.sound = blow
			get_parent().add_child(a)
		dead = true
		disabled = true

func reset():
		posessed = false
		disabled = false
		global_position = resetPos
		velocity = Vector2(0, 0)
		show()

func _on_player_reset() -> void:
	dead = false
	if not disableOnReset:
		reset()
	else:
		disabled = true



func _on_player_drop() -> void:
	if not dead:
		velocity = Vector2(0, 150)
		posessed = false
		disabled = false
		show()


func _on_player_save() -> void:
	if posessed:
		disableOnReset = true
	else:
		disableOnReset = false
