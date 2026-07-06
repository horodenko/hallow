# Project Scaffold Notes

Created 2026-07-06, by Claude, as the initial Godot project skeleton — before Fable's first coding session.

## What's here

- `project.godot` — confirmed settings only: project name, Godot 4.7, **Compatibility renderer** (`gl_compatibility`, hand-confirmed working on this machine). `run/main_scene` is intentionally left blank — there's no scene yet.
- Folder structure, empty except for `.gitkeep` placeholders (git doesn't track empty folders otherwise):
  - `scenes/` — for `.tscn` scene files
  - `scripts/` — for `.gd` scripts
  - `assets/characters/` — Ata, Adam, Eve, Light Figure, animals
  - `assets/tiles/` — the environment tileset
  - `assets/objects/` — bushes, trees, foliage
  - `assets/ui/` — not used yet; main-game HUD is unscoped (see `PROJECT_BRIEF.md` §14)

## What's deliberately NOT here

- **No Input Map.** Godot's input actions (movement, run) involve a fairly verbose resource syntax that's safer to set up through the editor UI than hand-written — Fable should configure this directly in Godot, using the "Press D to RUN" detail from `PROJECT_BRIEF.md` §6 as the one confirmed control so far. The rest of the control scheme isn't fully specified yet.
- **No scenes, no scripts, no imported assets yet.** This is intentionally just the empty shell — asset import and the first real scene should be Fable's first actual coding task, not something pre-built here.

## Known open issues before art import (see `INTRO_ASSET_PROMPTS.md` checklist for full detail)

- Environment tileset: still unconfirmed whether the latest export is a complete, usable minimal atlas
- Adam's Walking cycle: East (5 frames) vs. North (7 frames) mismatch, still unfixed
- The 3 selected bushes: generated with a discarded flat-shading prompt, not yet confirmed to visually match the rest of the art
- Light Figure, Eve, all four animals, both dialogue portraits, foliage objects, bedroom set: not generated yet

## Suggested first Fable session

1. Open this project in Godot, confirm it loads without the earlier Metal/renderer crash
2. Set up the Input Map (movement + run)
3. Import whatever character/tile assets are confirmed-good at that point
4. Build the first scene (likely the forest path, given it's the most complete asset category)
