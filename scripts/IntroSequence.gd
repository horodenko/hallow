## IntroSequence.gd — state machine driving the introduction (brief §6):
## auto_walk -> player_control -> frozen -> pointing_sequence -> dialogue
## -> fleeing -> caught -> transition. Story beats advance on Area2D
## trigger zones (position-based), never timers — timers are used only for
## genuinely duration-based beats (fades, pauses), per brief §11.
##
## Stubbed with TODOs (assets don't exist yet): Eve (auto-follow woman and
## her look/point poses), the animal reveal zones, Adam's curl-up + look
## poses, the bush-figure portrait, all audio (tension music, the "sound
## of many waters" pursuit cue, wind SFX), and the bedroom cut.
extends Node2D

signal state_changed(state: State)

enum State {
	AUTO_WALK,
	PLAYER_CONTROL,
	FROZEN,
	POINTING_SEQUENCE,
	DIALOGUE,
	FLEEING,
	CAUGHT,
	TRANSITION,
}

const ADAM_SCENE: PackedScene = preload("res://scenes/AdamFigure.tscn")

## Where Adam spawns: just off the map's west edge, on the path.
const ADAM_START: Vector2 = Vector2(-60.0, 590.0)
## Control passes to the player at ~33% of the initial screen (brief §6).
const HANDOFF_X: float = 220.0

## Opening fade-in duration (brief: 2s before the auto-walk).
const FADE_IN_S: float = 2.0

## Pursuit shadow (brief §6): invisible, trails behind, closes the gap
## ONLY while the player idles. Assumption (tunable): while the player
## runs, the gap slowly re-opens up to the starting gap — this is what
## makes the waters-cue "grow distant as it recedes".
const PURSUIT_START_GAP: float = 900.0
const PURSUIT_CLOSE_SPEED: float = 150.0
const PURSUIT_RECEDE_SPEED: float = 60.0
const PURSUIT_CATCH_DISTANCE: float = 40.0

## The hiding bush sits at x=2560 on the north side (IntroMap layout).
const BUSH_X: float = 2560.0
const BUSH_ARRIVAL_Y: float = 500.0

const NARRATION_HOLD_S: float = 3.0
const NARRATION_FADE_OUT_S: float = 1.0
const TOOLTIP_HIDE_DELAY_S: float = 2.0

var state: State = State.AUTO_WALK
var _adam: CharacterBody2D = null
var _pursuit_x: float = -INF
var _voice_line_played: bool = false
var _tooltip_dismissed: bool = false

@onready var _camera: Camera2D = $FollowCamera
@onready var _fade_rect: ColorRect = $UI/FadeRect
@onready var _tooltip: PanelContainer = $UI/Tooltip
@onready var _tooltip_text: RichTextLabel = $UI/Tooltip/TooltipText
@onready var _narration: RichTextLabel = $UI/Narration
@onready var _dialogue_box: PanelContainer = $UI/DialogueBox
@onready var _dialogue_text: RichTextLabel = $UI/DialogueBox/Rows/DialogueText


func _ready() -> void:
	_adam = ADAM_SCENE.instantiate()
	_adam.position = ADAM_START
	# inside the map's y-sorted Objects node so he sorts against bushes/trees
	$IntroMap/Objects.add_child(_adam)
	_camera.target = _adam

	$Zones/VoiceZone.body_entered.connect(_on_voice_zone_entered)
	$Zones/AnimalZone1.body_entered.connect(_on_animal_zone_entered.bind(1))
	$Zones/AnimalZone2.body_entered.connect(_on_animal_zone_entered.bind(2))
	$Zones/FreezeZone.body_entered.connect(_on_freeze_zone_entered)

	_tooltip_text.text = (
		"[center][color=#888888]W A S[/color] [color=#e03030]D[/color]"
		+ "\nPress [color=#e03030]D[/color] to RUN![/center]"
	)
	_tooltip.hide()
	_narration.hide()
	_dialogue_box.hide()

	# TODO(audio): no engine placeholder sounds per brief §10 — real assets
	# (tension music, "sound of many waters", wind) plug in here later.
	_fade_rect.color = Color.BLACK
	var tween: Tween = create_tween()
	tween.tween_property(_fade_rect, "color:a", 0.0, FADE_IN_S)


func _physics_process(delta: float) -> void:
	match state:
		State.AUTO_WALK:
			_process_auto_walk()
		State.PLAYER_CONTROL:
			_process_player_control(delta)
		_:
			pass


func _unhandled_input(event: InputEvent) -> void:
	if state == State.DIALOGUE and event.is_action_pressed("interact"):
		# skipping or closing: the box disappears IMMEDIATELY, no fade (§9)
		_dialogue_box.hide()
		_after_dialogue()


func _process_auto_walk() -> void:
	# TODO(Eve): the woman auto-follows behind Adam — assets don't exist yet.
	_adam.command_walk_east()
	if _adam.position.x >= HANDOFF_X:
		_enter_player_control()


func _enter_player_control() -> void:
	_set_state(State.PLAYER_CONTROL)
	_pursuit_x = _adam.position.x - PURSUIT_START_GAP
	_tooltip.show()
	# TODO(audio): tension music fades in here (brief §6).


func _process_player_control(delta: float) -> void:
	# Forward-lock (brief §6): no backward or vertical movement — only D
	# (also mapped as move_right) runs Adam east. W/A/S do nothing here.
	if Input.is_action_pressed("run"):
		_adam.command_run_east()
		if not _tooltip_dismissed:
			_tooltip_dismissed = true
			get_tree().create_timer(TOOLTIP_HIDE_DELAY_S).timeout.connect(_tooltip.hide)
	else:
		_adam.command_idle()

	# Pursuit: closes only while idle; recedes (bounded) while moving.
	if _adam.is_moving():
		_pursuit_x = maxf(
			_pursuit_x - PURSUIT_RECEDE_SPEED * delta,
			_adam.position.x - PURSUIT_START_GAP
		)
	else:
		_pursuit_x += PURSUIT_CLOSE_SPEED * delta
	# TODO(audio): "sound of many waters" volume swells with proximity
	# (gap / PURSUIT_START_GAP), restrained even at its loudest (brief §6).
	if _adam.position.x - _pursuit_x <= PURSUIT_CATCH_DISTANCE:
		_enter_caught()


func _on_voice_zone_entered(_body: Node2D) -> void:
	if state != State.PLAYER_CONTROL or _voice_line_played:
		return
	_voice_line_played = true
	# TODO(audio): low, deep, uncanny (not scary) voice — asset later.
	_narration.reveal("Where are you?")
	var total: float = _narration.reveal_duration() + NARRATION_HOLD_S
	get_tree().create_timer(total).timeout.connect(
		_narration.fade_out.bind(NARRATION_FADE_OUT_S)
	)


func _on_animal_zone_entered(_body: Node2D, zone_index: int) -> void:
	if state != State.PLAYER_CONTROL:
		return
	# TODO(animals): progressive animal reveal/staring (brief §6) — deer,
	# rabbit, monkey, fox assets not generated yet. Zone %d reached.
	print("TODO: animal reveal zone %d (assets pending)" % zone_index)


func _on_freeze_zone_entered(_body: Node2D) -> void:
	if state != State.PLAYER_CONTROL:
		return
	_enter_frozen()


func _enter_frozen() -> void:
	_set_state(State.FROZEN)
	_adam.command_idle()
	_tooltip.hide()
	# TODO(audio): hard music cut (brief §6).
	# TODO(animals): animals snap a glance offscreen toward the bush.
	_run_pointing_sequence()


func _run_pointing_sequence() -> void:
	await get_tree().create_timer(1.2).timeout
	_set_state(State.POINTING_SEQUENCE)
	# Sequential beats, no timers between story-critical parts — each beat
	# is a short fixed pause standing in for the missing pose animations:
	# TODO(Eve): woman looks at bush (pose asset pending)
	await get_tree().create_timer(0.8).timeout
	# TODO(Eve): woman points at bush (pose asset pending)
	await get_tree().create_timer(0.8).timeout
	# TODO(Adam): man looks at woman (look-at-woman pose pending)
	await get_tree().create_timer(0.8).timeout
	# TODO(Adam): man looks at bush (look-at-bush pose pending)
	await get_tree().create_timer(0.8).timeout
	_open_dialogue()


func _open_dialogue() -> void:
	_set_state(State.DIALOGUE)
	# TODO(portrait): bush-figure dialogue portrait not generated yet —
	# deliberately distinct from the later Light Figure model (brief §6).
	# TODO(art): real dialogue-box art pending; this panel is a placeholder.
	_dialogue_box.show()
	_dialogue_text.reveal("Come here! Quick!")


func _after_dialogue() -> void:
	_set_state(State.FLEEING)
	_run_fleeing()


func _run_fleeing() -> void:
	# TODO(Adam/Eve): brief glance back over the shoulder (poses pending).
	await get_tree().create_timer(0.6).timeout
	# TODO(Adam): distinct faster sprint cycle pending — reusing run.
	while _adam.position.x < BUSH_X - 16.0 and state == State.FLEEING:
		_adam.command_run_east()
		await get_tree().physics_frame
	while _adam.position.y > BUSH_ARRIVAL_Y and state == State.FLEEING:
		_adam.command_run_north()
		await get_tree().physics_frame
	if state != State.FLEEING:
		return
	_adam.command_idle()
	# TODO(Eve): she disappears into the forest alongside him.
	_adam.hide()
	await _sweep_giant_shadow()
	_enter_transition()


## The gigantic shadow that sweeps the whole map after the figures vanish —
## an in-engine effect by design (INTRO_ASSET_PROMPTS.md), not an image.
func _sweep_giant_shadow() -> void:
	# TODO(audio): wind SFX cue accompanies the sweep (brief §6).
	var gradient: Gradient = Gradient.new()
	gradient.offsets = PackedFloat32Array([0.0, 0.35, 0.65, 1.0])
	gradient.colors = PackedColorArray([
		Color(0, 0, 0, 0), Color(0, 0, 0, 0.85),
		Color(0, 0, 0, 0.85), Color(0, 0, 0, 0),
	])
	var tex: GradientTexture2D = GradientTexture2D.new()
	tex.gradient = gradient
	tex.width = 1024
	tex.height = 64
	var shadow: Sprite2D = Sprite2D.new()
	shadow.texture = tex
	shadow.scale = Vector2(2.0, 20.0)
	shadow.z_index = 50
	shadow.position = Vector2(-1200.0, 576.0)
	add_child(shadow)
	var tween: Tween = create_tween()
	tween.tween_property(shadow, "position:x", 5300.0, 1.4)
	await tween.finished
	shadow.queue_free()


func _enter_caught() -> void:
	_set_state(State.CAUGHT)
	_adam.command_idle()
	_tooltip.hide()
	# TODO(Adam/Eve): curl-up pose (4-8 frames, brief §6) not generated —
	# idle stands in. TODO(shadow): the shadow visibly hovers over them.
	var tween: Tween = create_tween()
	tween.tween_property(_fade_rect, "color:a", 1.0, 1.5)
	tween.tween_callback(_restart_scene)


func _restart_scene() -> void:
	# Catch state restarts the intro from the auto-walk (brief §6).
	get_tree().reload_current_scene()


func _enter_transition() -> void:
	_set_state(State.TRANSITION)
	# TODO(transition): "quick flashy pull-in" effect to design; a fast
	# fade stands in. TODO(bedroom): cut to Ata lying on bed — bedroom
	# mockup scene not built yet (brief §6 end of sequence).
	var tween: Tween = create_tween()
	tween.tween_property(_fade_rect, "color:a", 1.0, 0.6)
	print("TODO: cut to bedroom mockup (Ata on bed) — end of intro")


func _set_state(new_state: State) -> void:
	state = new_state
	state_changed.emit(new_state)
