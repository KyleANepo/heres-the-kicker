extends Entity
class_name Bee

@export var speed : float = 300.0
@export var jump_force : float = -300
@export var divekick_speed : float = 250
@export var tornadokick_speed : float = 300
@export var jumpbuffer_time : float = .2
@export var coyotetime : float = .1
var jumpbuffer_timer : float
var coyotetimer : float
var look : int = 1
var can_control : bool = true
var jump_count : int = 0
var tornado_count : bool = false

enum State {
	IDLE,
	JUMP,
	ATTACK,
	ATTACKAIR,
	HITSTOP,
	STUN,
	JUGGLE,
	FREEZE
}

var state : State = State.IDLE

func _ready() -> void:
	sprite.play("idle")
	$TimeUp.hide()

func _process(delta: float) -> void:
	jumpbuffer_timer -= delta
	coyotetimer -= delta
	
	if Input.is_action_just_pressed("debug"):
		SceneTransition.change_scene_wipe(get_tree().current_scene.scene_file_path)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and state not in [State.ATTACK, State.ATTACKAIR, State.HITSTOP, State.FREEZE]:
		velocity.y = min(velocity.y + (get_gravity().y * delta), 400)
	
	_look()
	_set_state()

	move_and_slide()

func destroy() -> void:
	if not ko:
		state = State.JUGGLE
		sprite.play("juggle")
		flash.play("hitflash")
		spark.play_spark("hit")
		audio.play_sound(false, 0)
		audio.play_sound(false, 3)
		velocity.x = 0
		velocity.y = -400
		ko = true

func _set_state() -> void:
	if state == State.IDLE:
		_move()
		
		if velocity.x != 0 and is_on_floor():
			sprite.play("walk")
		else:
			sprite.play("idle")
		
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			sprite.play("jump")
			_jump(0)
		elif Input.is_action_just_pressed("altattack") and GameManager.tornado_unlocked:
			position.y -= 4
			spark.play_spark("jump")
			audio.play_sound(false, 1)
			call_deferred_thread_group("_attack_air", "altattack")
		elif not is_on_floor():
			coyotetimer = coyotetime
			sprite.play("flip")
			state = State.JUMP
		
		if Input.is_action_just_pressed("down") and is_on_floor():
			position.y += 1
	
	if state == State.JUMP:
		_move()
		
		if velocity.y >= -150:
			sprite.play("flip")
		
		if Input.is_action_just_pressed("jump"):
			if coyotetimer > 0:
				sprite.play("jump")
				_jump(0)
			else:
				jumpbuffer_timer = jumpbuffer_time
		
		if is_on_floor() and velocity.y >= 0:
			jump_count = 0
			if jumpbuffer_timer > 0:
				sprite.play("jump")
				_jump(0)
			else:
				sprite.play("idle")
				state = State.IDLE
				tornado_count = false
		elif Input.is_action_just_pressed("attack"):
			_attack_air("attack")
		elif Input.is_action_just_pressed("altattack"):
			_attack_air("altattack")
	
	if state == State.ATTACK:
		pass
	
	if state == State.ATTACKAIR:
		
		if is_on_floor() and velocity.y >= 0:
			jump_count = 0
			tornado_count = false
			if jumpbuffer_timer > 0:
				sprite.play("jump")
				_jump(0)
			else:
				sprite.play("idle")
				state = State.IDLE
	
	if state == State.HITSTOP:
		pass
	
	if state == State.STUN:
		pass
	
	if state == State.JUGGLE:
		if is_on_floor() and velocity.y >= 0 and not ko:
			sprite.play("idle")
			state = State.IDLE

func _move() -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func _look() -> void:
	if look == 1 and Input.is_action_pressed("left"):
		look = -1
	elif look == -1 and Input.is_action_pressed("right"):
		look = 1

# Handle jump.
func _jump(boost : float) -> void:
	if is_on_floor():
		spark.play_spark("jump")
	state = State.JUMP
	audio.play_sound(false, 1)
	velocity.y = jump_force - boost
	jump_count += 1

func attack_successful() -> void:
	if not ko:
		sprite.play("flip")
		tornado_count = false
		_jump(100)
	

func _attack_air(action : String) -> void:
	state = State.ATTACKAIR
	match (action):
		"attack":
			_sting()
		"altattack":
			if not tornado_count and GameManager.tornado_unlocked:
				_tornado()
			else:
				_sting()
	

func _sting() -> void:
	sprite.play("divekick")
	audio.play_sound(true, 0)
	velocity.x = look * divekick_speed
	velocity.y = divekick_speed

func _tornado() -> void:
	sprite.play("tornadokick")
	audio.play_sound(true, 0)
	tornado_count = true
	velocity.x = look * tornadokick_speed
	velocity.y = 0

func _restart_level() -> void:
	SceneTransition.change_scene_wipe(get_tree().current_scene.scene_file_path)

func freeze() -> void:
	state = State.FREEZE
	sprite.stop()
	velocity.x = 0
	velocity.y = 0
	audio.play_sound(false, 0)
	audio.play_sound(false, 4)
	flash.play("flash")
	$TimeUp.show()
	can_control = false

func freeze_with_benefits() -> void:
	state = State.FREEZE
	sprite.stop()
	velocity.x = 0
	velocity.y = 0
	audio.play_sound(false, 0)
	audio.play_sound(false, 4)
	flash.play("flash")
	$TimeUp.show()
	can_control = false
	await get_tree().create_timer(4).timeout
	state = State.IDLE
	sprite.play("idle")
	flash.play("hitflash")
	$TimeUp.hide()
	can_control = true
	GameManager.gametimer.time += 3
	GameManager.gametimer.resume()

func unfreeze() -> void:
	state = State.IDLE
	sprite.play("idle")
	flash.play("hitflash")
	$TimeUp.hide()
	can_control = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "tornadokick":
		sprite.play("flip")
		state = State.JUMP
