## LetterFadeText.gd — RichTextLabel that reveals its text with the global
## per-letter fade-in rule (brief §9). Natural finish fades the whole text
## out at once via fade_out(); skipping should instead hide() immediately
## (no fade-out), per the same rule — callers decide which applies.
extends RichTextLabel

## Center the revealed text horizontally (used by bottom-screen narration).
@export var centered: bool = false

var _effect: LetterFadeEffect = LetterFadeEffect.new()


func _ready() -> void:
	bbcode_enabled = true
	custom_effects = [_effect]


## Show the given plain text, starting the per-letter reveal from now.
func reveal(new_text: String) -> void:
	_effect.start_ms = Time.get_ticks_msec()
	var body: String = "[letterfade]%s[/letterfade]" % new_text
	if centered:
		body = "[center]%s[/center]" % body
	text = body
	modulate = Color.WHITE
	show()


## Seconds until the current text is fully revealed.
func reveal_duration() -> float:
	return LetterFadeEffect.reveal_duration(get_parsed_text().length())


## Fade the whole text out at once (natural finish), then hide.
func fade_out(duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration)
	tween.tween_callback(hide)
