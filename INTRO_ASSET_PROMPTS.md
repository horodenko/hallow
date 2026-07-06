# Introduction Sequence — Image Generation Prompts

Scope: assets needed for the introduction (forest chase → bedroom cut), **plus** a get-ahead bedroom-interior set (Section 9) matching a reference image already produced — read the scope note at the top of that section before generating it, since it goes beyond what the introduction itself actually requires. Paste these into ChatGPT one at a time. Where a subject needs 4 directions, generate the **front view first**, then reply in the same thread with "using the exact same character/colors/proportions as above, now show [left/right/back] view" rather than repasting the full prompt — consistency holds much better that way than starting fresh each time.

**Note (2026-07-02):** a chibi + strict-flat-shading + 32×32-tile direction was tried and reverted the same day — the grounded/realistic proportions and painterly shading below are confirmed, not provisional. Ata's already-completed animations remain valid; nothing needs to be redone because of that experiment.

**Sprite size setting vs. exported file size:** when generating characters in PixelLab, set **Sprite Size to 64×64** (matching Ata's approved generation) — the actual downloaded PNGs will come out padded to **124×124** since PixelLab squares the canvas to fit the full range of animation motion. That padding is expected; don't try to match 124×124 directly when setting up new prompts.

---

## Master Style Block
*(Keep this active in the conversation, or prepend it to the first prompt of each new subject)*

> Top-down 2D pixel art asset for a narrative indie game, in the style of RPG Maker horror/mystery games like Mad Father, Ib, and The Witch's House. Retro pixel art at roughly 16-bit fidelity, soft grain, slightly aged and cinematic, muted and moody color palette — not clean, modern, or cartoonish. Strict overhead / high three-quarter top-down camera angle, consistent across all assets, no eye-level perspective. Transparent background if possible (otherwise solid flat magenta background for easy removal later). No text, no watermark, no UI in the image itself.

**Lighting note (environment/tiles specifically):** keep *scene-level* lighting flat and neutral on tiles and environment art — no baked directional glow, colored ambient tint, or cast shadows — so Godot's runtime lighting (`Light2D`/`PointLight2D`, `CanvasModulate`) can layer atmospheric mood on top without fighting pre-baked light. This doesn't apply to character material shading (skin, hair, fabric) — Ata's own soft shading is part of the approved style and should carry over to the rest of the cast.

**Flagged gap (found 2026-07-02, not yet fixed):** the brief's own sequence table (§6) calls for a "curl-up" pose (4–8 frames) for Adam & Eve when the pursuing shadow catches them, and a distinct faster run/sprint cycle for the final dash to the bush — separate from their normal walk-cycle spritesheets below. Neither has a dedicated prompt yet. Flagging so it isn't silently lost before Fable starts building the sequence.

## Spritesheet Formula
*(Append to any character/animal prompt below)*

> This is a SPRITESHEET: a single image containing **[N] frames** of the same subject laid out in one evenly spaced horizontal row, identical size and alignment per frame, consistent design and color across every frame, forming a walking animation cycle. Do not change the character's design between frames — only the pose/leg position changes.

- Ata & Light Figure: **N = 5–10 frames**
- Everyone else (Adam, Eve, all animals): **N = 4–8 frames**

---

## 1. Ata (Protagonist)

**Base description** (use for all views):
> A 21-year-old college student, blonde with long hair, brown amber eyes, round glasses. Wears a black long-sleeve shirt underneath a light-blue denim pinafore/jumper dress — ankle-length, covering her legs entirely (not short like a typical pinafore). Black-and-white low-top Converse-style sneakers. Ordinary, soft, gentle appearance — not stylized or exaggerated.

**Tone & expression note:** Ata is not depressed, but she is not happy either — a quiet, uncertain, searching quality, like someone still working out what is real and what isn't. Avoid exaggerated sadness (no drooping posture, no tears, no visible distress) and avoid cheerfulness or brightness in equal measure. This restrained, in-between quality should carry through her posture and stillness in the walking spritesheets, and especially in her expression in the dialogue portrait below. The overall tone of the game is serious and dark, not comic — nothing about her design should read as lighthearted.

**Four directional walk-cycle spritesheets** — generate front view first, then follow-up for the rest:
- Front view: "facing the viewer, walking toward camera"
- Back view: "facing away from viewer, walking away from camera"
- Left view: "in profile, walking to the left"
- Right view: "in profile, walking to the right"

*(Append the Spritesheet Formula, N = 5–10, to each)*

**Dialogue portrait** (separate prompt, not a spritesheet):
> A close-up bust/waist-up portrait of the same character described above, for use in a dialogue box. A quiet, contemplative, slightly guarded expression — not smiling, not frowning, an inward and searching stillness rather than sadness or emptiness. Facing slightly off-center or toward the viewer, soft even lighting. Same pixel art style as the overworld sprite but slightly higher detail, appropriate for a small rectangular dialogue portrait like those in Ib or Mad Father.

---

## 2. Light Figure (Companion)

**Base description:**
> A small, gently rounded, humanoid-ish floating being — not any specific animal, no distinct face or a very simple minimal one. Semi-transparent/translucent — the environment should be faintly visible through its body. Warm amber-orange glow, softly luminous, floats slightly above the ground.

**Tone & expression note:** the Light Figure acts as Ata's best friend, but its comfort is not honest — it will say almost anything to make her feel better in the moment ("I can't believe they did that to you, they're so mean!"), regardless of whether that's actually true or good for her. Visually, this should not translate into anything sinister, dark, or comic — the design must still read as completely warm and safe during normal play, per the rule in Section 1 of the main brief that it never looks suspicious. Instead, the uncanny quality should come from **unwavering sameness**: the exact same steady, reassuring glow and warmth in every moment, never dimming, never intensifying, never actually modulating with what's happening around it — comforting on a loop rather than genuinely responsive. That sameness should only feel unsettling in hindsight, not as an in-the-moment visual tell. The overall game tone is serious and dark, not comic — the figure should never feel like comic relief.

**Four directional walk-cycle spritesheets**, same front/back/left/right approach as Ata. *(Spritesheet Formula, N = 5–10)*

**Dialogue portrait:**
> A close-up portrait of the same light figure, translucent warm orange glow, a fixed, fond, encouraging presence — the same steady warmth regardless of what is being discussed, never darkening or intensifying with the conversation's content. No distinct facial expression needed; the glow itself should carry the tone, plainly warm and friendly, not eerie-looking. Soft ambient light. Same style as the overworld sprite, slightly higher detail for a small dialogue-box portrait.

---

## 3. Adam Figure (Man, Introduction Only)

**Base description:**
> A humanoid figure rendered entirely as a smooth, featureless dark silhouette — fully obscured by very low dusk lighting so no facial features, clothing, or anatomical details are visible at all, only an indistinct dark human shape, like a shadow or ink silhouette. Short-hair silhouette shape. No nudity or anatomical detail should be rendered — the figure reads only as a dark outline, small in scale within the frame. Depicts a mysterious figure moving urgently through a garden at dusk.

**Primary direction:** the chase runs left-to-right, so his base movement direction is **East** (facing right, matching the "Press D to RUN!" tooltip). Generate East first as the primary reference for the rest.

**Four directional spritesheets**, front/back/left/right. *(Spritesheet Formula, N = 4–8)*

**Additional single-pose prompts for the freeze-point sequence** (one static frame each, not spritesheets):
- **Look at the woman:** "Same figure, facing south (toward the viewer), turned to look at the woman standing beside him, still posture, no walking motion."
- **Look at the bush:** "Same figure, facing north (away from the viewer), turned to look toward something hidden in the bushes ahead, still posture." *(Assumes the bush sits north of the path — flag it if that's not how you're picturing the layout.)*
- **Look back:** "Same figure, body still facing north as in the look-at-the-bush pose above, but head turned to look back over his shoulder to the left, brief glance, still posture." This is a head-turn variant on the existing north-facing pose — not a new body direction, just the head redirected.

---

## 4. Eve Figure (Woman, Introduction Only)

Same approach as Adam, but:
> Long-hair silhouette shape, otherwise identical treatment — fully obscured dark silhouette, no visible features or anatomical detail, dusk lighting.

**Primary direction:** same as Adam — **East**, matching the shared chase direction.

**Four directional spritesheets**, front/back/left/right. *(Spritesheet Formula, N = 4–8)*

**Additional single-pose prompts for the freeze-point sequence** (one static frame each, not spritesheets):
- **Look at the bush:** "Same figure, facing north (away from the viewer), stopped and turning to look toward something hidden in the bushes ahead." *(Same north assumption as Adam's — flag if the bush sits elsewhere.)*
- **Point at the bush:** "Same figure, facing north, arm raised and pointing toward the bushes ahead, urgent posture."
- **Look back:** "Same figure, body still facing north as in the point pose above, but head turned to look back over her shoulder to the left, brief glance." Same head-turn-variant logic as Adam's.

---

## 5. The Bush-Figure (Hidden Voice — this IS Satan / the Light Figure, pre-reveal)

**Clarification:** this is not a separate character walking around the world. In the world itself, it's simply the **same "hiding bush" tile from the Environment Tileset (Section 7)** — no unique overworld sprite needed. What's needed here is only the **dialogue-box portrait** shown while it speaks, plus a short **rustle animation** on the bush tile itself (below).

**Dialogue-box portrait:**
> A dark, pitch-black humanoid silhouette, face and form completely unreadable, partially concealed within dense bushes/undergrowth. This design should be **deliberately different** from the Light Figure described in Section 2 above — different proportions or silhouette shape — while still reading as vaguely similar enough that a very attentive player might later wonder. Dusk forest lighting, top-down pixel art style, small scale.

Single portrait-style image for the dialogue box (not a spritesheet — this figure doesn't move on screen).

**Bush rustle/flicker animation** (animates the existing hiding-bush tile from Section 7 — not a new character):
> The same hiding bush from the environment tileset, shown as a short animation: the bush rustles and shakes, throwing a few loose leaves outward, as if something inside just moved. Roughly 4–6 frames, matching the tileset's exact art style, palette, and proportions so it clearly reads as the same object, not a different asset. This plays once, right before the dialogue box opens, to draw the player's eye to the bush without revealing anything inside it.

---

## Note: The Giant Shadow & Pursuit Shadow — not an image-generation asset

Neither the pursuit shadow (the thing that closes in if the player idles) nor the gigantic shadow that sweeps the map after Adam and Eve vanish into the forest is on this checklist, and that's deliberate rather than an oversight. Both are recommended as an **in-engine effect** (a shader or animated dark overlay, e.g. a Godot `CanvasModulate` or a simple dark shape drawn and scaled in code) rather than a pre-generated image — a still image can't scale dynamically to cover an arbitrary map size, and "a shadow sweeping across a whole scene" is really a lighting effect, not a textured object. This is a job for Fable 5 during coding, not for ChatGPT/PixelLab.

One thing worth a quick gut-check while it's on the table, purely thematically: the voice asking "Where are you?" and the shadow that closes in read, to me, less like Satan and more like the presence Adam and Eve are actually hiding *from* in the first place — which lines up with Genesis 3, where God calls out "Where are you?" after the Fall. If that's the intended reading, it's worth preserving as a distinct thread from the bush-figure: the bush-figure (Satan) offers false shelter from something else entirely, rather than being the thing being fled. Worth confirming that's the shape you're going for, since it changes how "the shadow hovers over them" should feel when it's built — more like exposure/reckoning than the Light Figure's comforting-but-wrong register.

---

## 6. Animals — Deer, Rabbit, Monkey, Fox

For **each** animal, generate:

**Walk-cycle spritesheets**, front/back/left/right:
> A [deer / rabbit / monkey / fox], naturalistic but slightly stylized, muted warm color palette matching a sunlit forest scene, small scale appropriate for a top-down pixel art game.
*(Spritesheet Formula, N = 4–8)*

**Alert/staring pose** (separate, single frame or 2–3 frame short sequence, not a full walk cycle):
> The same [animal], standing completely still, tense and alert, head turned toward the viewer, ears up, clearly watching — an unsettling stillness rather than a natural pose. This pose is used when the animal is staring at the player character as they pass.

---

## 7. Environment Tileset (Path & Ground)

> A tileset image: a grid of individual square tiles, each tile clearly separated with consistent lighting and pixel-art style, for a top-down 2D forest path scene. Include: straight earthen/dirt road tiles, road-to-grass edge and corner transition tiles, 2–3 grass tile variants (to avoid visible repetition when tiled), forest floor tiles, and one larger distinct "hiding bush" tile with a noticeably denser silhouette than regular bushes. Warm daylight palette shifting toward dusk tones. Overhead top-down camera. Tiles evenly sized, neatly arranged, no gaps, ready for slicing into a game tileset.

**Export format note:** use PixelLab's **"Godot (3×3)"** export option specifically, not the raw preview/demo composition. Before handing anything to Fable, confirm the downloaded file is a small, compact minimal-terrain atlas (roughly 9–13 tiles), not the large multi-shape demo canvas PixelLab shows to preview the set — the two look very different and only one is actually importable as a working `TileSet`.

---

## 8. Trees & Simple Objects

Front-view only — these are static world objects, no side/back views needed.

**Trees:**
> A single tree, front-view only, top-down/high-angle appropriate for the game's overhead camera, muted warm forest palette shifting to dusk tones. Keep it simple: either one static frame, or a small 2–3 frame spritesheet showing a gentle ambient sway for the canopy only (trunk stays fixed). Matches the overall pixel art style.

**Simple foliage objects** (apples, ferns, small shrubs — one prompt per object, static only):
> A single [cluster of red apples on a branch / fallen apple / small fern / low shrub], front-view only, static, no animation, top-down pixel art style, matching the forest scene's warm muted palette.

---

## 9. Bedroom Interior (Extension — beyond original intro-only scope)

**⚠️ Scope flag — read before generating anything in this section.** The introduction sequence itself only needs "Ata lying on bed" as a mockup cut (brief §6) — no other bedroom features were ever in scope for the intro. A reference image was produced showing Ata **awake and standing**, with the Light Figure beside her and a health/lantern-fuel bar + item slots visible at the bottom of the screen. Per brief §9, that HUD only appears in the **main game, post-introduction** — meaning that reference is actually depicting a main-game location (Ata's likely bedroom/home base), which per brief §14 **isn't scoped as a level yet at all**. This section exists purely as get-ahead prep since the reference and visual direction already exist — it is not part of what the introduction requires. The HUD/bar/item-slot art itself is deliberately **not** included below; UI art direction is a separate, undecided task.

**Floor tileset:**
> A tileset image: a grid of individual square tiles for a top-down 2D wooden floorboard interior, same 64×64 tile size as the forest tileset. Warm worn wood tones, consistent plank direction, soft shading matching the approved character/tileset style. Include 2–3 plank variants to avoid repetition, and one rug/carpet tile set (soft muted color, simple woven border pattern). Neutral, even scene lighting — the moody glow effects are added in-engine, not baked into the tiles.

**Wall tileset:**
> A tileset image: wall tiles for a top-down interior, matching the floor tileset's palette and shading style. Include a plain wall variant and a baseboard/trim transition tile where wall meets floor. Neutral even lighting.

**Window (static object, front-view):**
> A single window set into a wall, front-view, top-down/high-angle appropriate, simple curtains to each side, muted glass tone — the moonlight/glow effect through it is added in-engine via a light source, not painted into the glass. Optional: a small 2–3 frame variant with a very subtle curtain sway.

**Furniture** (front-view only, static single frame unless noted — generate each as its own separate prompt, one object per prompt, same pattern as the Section 8 foliage objects):
> A [bed with pillow and blanket / writing desk with a simple chair / bookshelf with a row of books / dresser with a few small items on top / tall standing mirror / wall-mounted coat hook with a hanging robe / small framed picture for the wall / small potted plant], front-view only, top-down/high-angle appropriate, muted warm interior palette matching the floor and wall tilesets, neutral even lighting, no baked shadow.

---

## Checklist

**Flagged, not yet scoped (found 2026-07-02 while reviewing this file):** Adam & Eve curl-up "caught" pose (4–8 frames, per brief §6), and a distinct faster run/sprint cycle for the final dash to the bush, separate from their normal movement spritesheets below.

**Asset review findings (2026-07-03), against the actual delivered zip:**

- [x] Ata — Walking spritesheets, all 4 directions *(7 frames each — clean, consistent)*
- [x] Ata — Idle/Running frame count + naming inconsistencies *(accepted as-is 2026-07-06 — Daniel's call, not blocking)*
- [ ] Ata — dialogue portrait *(not generated — only rotations/animations exist)*
- [ ] Light Figure — front, back, left, right spritesheets
- [ ] Light Figure — dialogue portrait
- [x] Adam — Idle spritesheets, all 4 directions *(7 frames each — consistent)*
- [x] Adam — south-direction mismatches (Running 9 vs. 7, Walking 11 vs. 7) *(deprioritized 2026-07-06 — Daniel confirmed Adam only moves East, then North at the bush; South is unused in practice)*
- [~] Adam — Walking east vs. north *(5 frames vs. 7 — still open. Both of these ARE the directions actually used per the note above, so this specific pair still needs fixing even though South doesn't matter.)*
- [~] Adam — canvas size *(120×120 vs. Ata's 124×124 — small but real scale inconsistency; likely a Sprite Size setting drift, worth regenerating to match exactly)*
- [ ] Adam — dialogue portrait *(not generated)*
- [ ] Adam — look-at-woman, look-at-bush, look-back poses
- [ ] Adam — curl-up (caught) pose + sprint cycle *(newly flagged, not yet prompted — see note above)*
- [ ] Eve — front, back, left, right spritesheets
- [ ] Eve — look-at-bush, point-at-bush, look-back poses
- [ ] Eve — curl-up (caught) pose + sprint cycle *(newly flagged, not yet prompted — see note above)*
- [ ] Bush-Figure — dialogue portrait
- [ ] Hiding bush — rustle/flicker animation (on the Section 7 tileset bush)
- [ ] Deer — front, back, left, right spritesheets + alert pose
- [ ] Rabbit — front, back, left, right spritesheets + alert pose
- [ ] Monkey — front, back, left, right spritesheets + alert pose
- [ ] Fox — front, back, left, right spritesheets + alert pose
- [~] Environment tileset — **still open, but improving.** Latest candidate (2026-07-06) is 128×128px = a 2×2 grid of 4 tiles at 64×64 — much closer to a real compact atlas than the earlier 24×8 and 12×4 demo canvases, but 4 tiles is still low for a complete minimal terrain set (typically needs more like 9–13 to cover all corner/edge combinations). Need to confirm exactly what those 4 tiles depict before treating this as final.
- [x] Bushes — **3 final picks selected 2026-07-06** (down from the 57 raw candidates). **New flag:** the generation prompt used for these three ("true 16-bit fidelity... no smooth gradients, no painterly rendering, no heavy anti-aliasing") is the *discarded* flat-shading wording from the chibi experiment that got reverted — it doesn't match the currently locked Master Style Block above (which allows soft grain / painterly shading, matching Ata's approved look). Worth checking whether these three visually match Ata/the tileset before treating them as final, and likely regenerating with the current correct prompt if not.
- [x] Tree(s) — 2 delivered (one explicitly "large deciduous tree," one unlabeled)
- [ ] Simple foliage objects (apples, ferns, etc.) — not present in the delivered zip
- [ ] **Bedroom (extension — confirm scope before starting, see Section 9):** floor tileset, wall tileset, window, bed, desk + chair, bookshelf, dresser, mirror, coat hook + robe, picture frame(s), potted plant(s)
