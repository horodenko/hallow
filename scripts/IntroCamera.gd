## IntroCamera.gd — camera for the introduction sequence. Follows a target
## (Adam) at a close zoom, clamped to the map limits — so at the west edge
## the camera holds still and Adam visibly walks in from the left of the
## screen before the follow latches on. Zoom stays a tunable parameter
## (the brief originally framed the intro pulled far back; Daniel chose a
## close follow on 2026-07-06 — change zoom_level to revisit).
extends Camera2D

@export var zoom_level: float = 1.8

## Node the camera tracks; set from code by the intro sequence.
var target: Node2D = null


func _ready() -> void:
	zoom = Vector2(zoom_level, zoom_level)


func _process(_delta: float) -> void:
	if target != null:
		global_position = target.global_position
