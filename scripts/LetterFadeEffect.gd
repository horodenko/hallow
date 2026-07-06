## LetterFadeEffect.gd — RichTextEffect implementing the game's global text
## rule (brief §9): every letter fades in sequentially (not a typewriter
## pop-in). Used through LetterFadeText.gd, which owns the start timestamp.
class_name LetterFadeEffect
extends RichTextEffect

## Seconds between each letter starting its fade.
const STAGGER: float = 0.07
## Seconds for a single letter to fade from 0 to full alpha.
const FADE: float = 0.25

var bbcode: String = "letterfade"
var start_ms: int = 0


func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var elapsed: float = float(Time.get_ticks_msec() - start_ms) / 1000.0
	var alpha: float = clampf(
		(elapsed - char_fx.relative_index * STAGGER) / FADE, 0.0, 1.0
	)
	char_fx.color.a *= alpha
	return true


## Total seconds until a text of the given length is fully revealed.
static func reveal_duration(char_count: int) -> float:
	return char_count * STAGGER + FADE
