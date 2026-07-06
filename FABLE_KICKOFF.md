# FABLE_KICKOFF.md — First Claude Code Session

You are picking up a Godot project mid-production. Read these fully before writing any code:

1. `PROJECT_BRIEF.md` — the full design. Priority: **§6** (intro sequence — your build target), **§11** (art/tech decisions), the coding-standards section (statically typed GDScript).
2. `INTRO_ASSET_PROMPTS.md` — the checklist at the bottom is the live asset status. `[~]` = exists but flawed, details inline.
3. `SCAFFOLD_NOTES.md` — what the project skeleton contains and why.
4. `reference/intro_wide_reference.png` — ChatGPT-generated mood/layout reference for the intro scene. **Layout truth:** straight east-west dirt path; berry bushes lining both edges; one larger, denser hiding bush on the **north side**, right of center; trees framing everything; warm golden light in the west shifting to dusk in the east. Recreate this composition with the real assets. Never import this image into the game itself.
5. `reference/tileset_48_labeled.png` — the real tileset atlas with index numbers overlaid, so tiles can be referenced by number ("tile 22"). Reference only, never a game asset.

## Environment — do not change these

- **Godot 4.7**, standard build, **Compatibility renderer** (already set in `project.godot`). The dev machine (2015 MacBook Air, Intel HD Graphics 6000) hard-crashes on Forward+ — a known Godot 4.7 Metal bug. Never switch the renderer.
- **GDScript, statically typed throughout** (`var health: int = 100`, `func take_damage(amount: int) -> void:`).
- **Git:** work on `develop`. Commit convention: `Feature: ...` / `Fix: ...` prefixes. Commit small, push after each working slice. Git LFS already handles `*.png` automatically.
- **Tile size 64×64.** Character exports are padded square canvases — Ata 124×124, Adam 120×120 (known small drift, accepted for now).

## Asset reality

- **Ata** — complete: idle/walk/run × 4 directions. Frame counts vary slightly per direction and naming mixes two styles (`frame_000.png` vs `north_0001.png`, different start indices). Accepted as-is: handle loading per-folder, and use per-animation FPS to even out cycle timing.
- **Adam** — idle/walk/run × 4 directions. **He only ever moves EAST, then NORTH at the bush.** Walking east = 5 frames vs north = 7 (mismatch known; tune per-animation FPS). South/west effectively unused.
- **Bushes** — `assets/objects/bush 1..3`, Daniel's three picks. Style match vs. Ata unconfirmed (they were generated with an older flat-shading prompt) — use them, but flag on sight if they visually clash in-scene.
- **Trees** — 2, in `assets/objects/trees`.
- **Tileset** — the 768×256 atlas (48 tiles at 64×64) in `assets/tiles/`. **No metadata exists** — every tile's Terrain + Peering Bits must be assigned by visual inspection. "Godot (3×3)" refers to the peering-bit mode, not tile count.
- **Does not exist yet — stub with clear TODOs, do not build:** Eve, all four animals, bush-figure dialogue portrait, dialogue-box art, Adam's curl-up + sprint poses, all audio (the "sound of many waters" pursuit cue, tension music, wind SFX).

## Session order — small slices, verify each before the next

1. **Open + Input Map.** Confirm the project opens clean. Add input actions per brief §6: WASD movement, with D doubling as RUN in the forward-locked intro ("Press D to RUN!" tooltip).
2. **TileSet resource.** Import the atlas at 64×64. First-pass Terrain + Peering Bits for all 48 tiles, using the labeled reference to reason tile-by-tile. Then paint a SMALL test strip — one straight run, one corner, one junction — and **stop for Daniel to visually verify** before building any real map.
3. **Adam controller.** `CharacterBody2D` + `AnimatedSprite2D`: east/north walking, running, idle. Per-animation FPS to normalize the frame-count differences.
4. **Intro map layout** matching the reference: straight east-west path corridor, bush rows lining both edges, the hiding bush on the north side right-of-center, trees framing. The west-warm→east-dusk lighting gradient is done **engine-side** (`CanvasModulate` / gradient overlay) — never baked into art (brief §11).
5. **State machine skeleton** per the brief §6 table: `auto_walk → player_control → frozen → pointing_sequence → dialogue → fleeing → caught → transition`. `Area2D` trigger zones advance state — no timers except genuinely duration-based beats. Stub every Eve/animal/audio-dependent beat with a clear TODO.
6. **Camera.** The intro plays pulled far back (wide `Camera2D` zoom, like the reference image); normal gameplay will zoom in later. Make the zoom level a parameter, not a hardcode.

## Working style — non-negotiable, from Daniel

- Flag design contradictions out loud; never quietly pick one side.
- Test one small thing before any bulk work.
- Ask on real creative forks; on trivial ones, proceed with a stated assumption.
- Keep `PROJECT_BRIEF.md` §15 and the `INTRO_ASSET_PROMPTS.md` checklist updated as things land — they are the source of truth for whoever picks this up next.
