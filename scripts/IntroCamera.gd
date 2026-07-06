## IntroCamera.gd — camera for the introduction sequence. The intro plays
## pulled far back (wide framing per the reference image); normal gameplay
## zooms in later, so the zoom level is a tunable parameter, not a hardcode.
extends Camera2D

## 0.65 shows roughly 28x16 tiles at the default window size, close to the
## reference image's framing.
@export var pulled_back_zoom: float = 0.65


func _ready() -> void:
	zoom = Vector2(pulled_back_zoom, pulled_back_zoom)
