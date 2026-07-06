## AdamFigure.gd — the shadowy man of the introduction. Dumb body: the
## intro sequence tells him what to do via the command_* methods; he only
## handles velocity and animation. Per the brief he only ever moves EAST,
## then NORTH at the hiding bush — south/west animations are not loaded.
extends CharacterBody2D

const WALK_SPEED: float = 130.0
const RUN_SPEED: float = 300.0

enum Motion { IDLE, WALK_EAST, RUN_EAST, RUN_NORTH }

var _motion: Motion = Motion.IDLE
var _facing_north: bool = false

@onready var _sprite: AnimatedSprite2D = $Sprite


## Stop in place (keeps current facing).
func command_idle() -> void:
	_motion = Motion.IDLE


func command_walk_east() -> void:
	_motion = Motion.WALK_EAST


func command_run_east() -> void:
	_motion = Motion.RUN_EAST


func command_run_north() -> void:
	_motion = Motion.RUN_NORTH


## True while any movement command is active (used by the pursuit logic —
## the shadow only closes the gap while the player is standing still).
func is_moving() -> bool:
	return _motion != Motion.IDLE


func _physics_process(_delta: float) -> void:
	match _motion:
		Motion.IDLE:
			velocity = Vector2.ZERO
		Motion.WALK_EAST:
			velocity = Vector2(WALK_SPEED, 0.0)
			_facing_north = false
		Motion.RUN_EAST:
			velocity = Vector2(RUN_SPEED, 0.0)
			_facing_north = false
		Motion.RUN_NORTH:
			velocity = Vector2(0.0, -RUN_SPEED)
			_facing_north = true
	move_and_slide()
	_update_animation()


func _update_animation() -> void:
	var anim: StringName
	match _motion:
		Motion.IDLE:
			anim = &"idle_north" if _facing_north else &"idle_east"
		Motion.WALK_EAST:
			anim = &"walk_east"
		Motion.RUN_EAST:
			anim = &"run_east"
		Motion.RUN_NORTH:
			anim = &"run_north"
	if _sprite.animation != anim:
		_sprite.play(anim)
