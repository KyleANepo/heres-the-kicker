extends Resource
class_name Attack

@export var damage : float = 10.0
@export var stun : float = 1.0
@export var hitstop : float = .1
@export var knockback : float = 100.0
@export var knockbackUp : float = 0.0
@export var knockbackAir : float = 100.0 # determines knockback when attack hits in the air
@export var knockbackAirSide : float = 0.0
@export var type : int = 1 
@export var screenshake : bool = false
var direction : int = 1
var attackOwner : Entity
