extends Entity
class_name Bee

@export var speed : float = 300.0
@export var jump_force : float = -300
@export var divekick_speed : float = 250
var look : int = 1
var can_control : bool = true
var jump_count : int = 0

enum State {
	IDLE,
	JUMP,
	ATTACK,
	ATTACKAIR,
	HITSTOP,
	STUN,
	JUGGLE
}

var state : State = State.IDLE

func _ready() -> void:
	sprite.play("idle")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and state not in [State.ATTACK, State.ATTACKAIR, State.HITSTOP]:
		velocity += get_gravity() * delta
	
	_look()
	_set_state()

	move_and_slide()


func _set_state() -> void:
	if state == State.IDLE:
		_move()
		
		if velocity.x != 0 and is_on_floor():
			sprite.play("walk")
		else:
			sprite.play("idle")
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			sprite.play("jump")
			_jump()
		elif not is_on_floor():
			sprite.play("flip")
			state = State.JUMP
	
	if state == State.JUMP:
		_move()
		
		if velocity.y >= -150:
			sprite.play("flip")
		
		if is_on_floor() and velocity.y >= 0:
			jump_count = 0
			sprite.play("idle")
			state = State.IDLE
		elif Input.is_action_just_pressed("attack"):
			_attack_air()
	
	if state == State.ATTACK:
		pass
	
	if state == State.ATTACKAIR:
		if is_on_floor() and velocity.y >= 0:
			jump_count = 0
			sprite.play("idle")
			state = State.IDLE
	
	if state == State.HITSTOP:
		pass
	
	if state == State.STUN:
		pass
	
	if state == State.JUGGLE:
		if is_on_floor() and velocity.y >= 0:
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
func _jump() -> void:
	state = State.JUMP
	velocity.y = jump_force

func attack_successful() -> void:
	sprite.play("flip")
	_jump()

func _attack_air() -> void:
	state = State.ATTACKAIR
	_sting()

func _sting() -> void:
	sprite.play("divekick")
	velocity.x = look * divekick_speed
	velocity.y = divekick_speed
