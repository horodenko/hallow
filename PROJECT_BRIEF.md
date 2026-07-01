# Untitled Godot Game — Pre-Production Brief

**Purpose of this document:** This is the source-of-truth context for Fable 5 (or any AI/human developer) to read *before* writing any code or the project's actual README.md. It consolidates every design, technical, and process decision made during pre-production. Fable 5's first task should be to set up the project skeleton and write the real README using this brief as its foundation — this document is not the README itself, and should be treated as internal reference, not a public-facing file.

**Repository:** https://github.com/horodenko/untitled-godot-game (public)

---

## 1. Core Concept

A top-down 2D introspective narrative game, visually and tonally inspired by *Mad Father*, *The Witch's House*, *Ib*, *Undertale*, and *Stardew Valley* — moody pixel art, small intimate cast, missable content that changes the ending.

**The hidden premise:** underneath the surface story, this is a Christian allegory — never named, never stated, never labeled as a "Christian game" anywhere in marketing or text. Players unfamiliar with Christianity should experience a complete, emotionally satisfying story on its own terms. Players familiar with scripture should be able to recognize the parallels and, ideally, only fully realize the depth of it after finishing.

**Protagonist:** Ata (working name), a silent protagonist, identity/name revealed after the introduction sequence (Ata does not appear in the introduction itself).

**Core mechanic — "The Bar":** represents the sum of Ata's good works across the game. Player choices raise or lower it by set percentages, capping naturally at 99% through ordinary play. Reaching true 100% is not possible through choices alone — see Section 3.

**Default ending (current draft):** normal daily life continues — sunrise, ordinary motion — then a sudden flash of light and "the sound of many waters" (deliberately not a clear trumpet sound) fills the sky, and the game ends. Plays whenever the player finishes the game without completing the requirements in Section 3.

**The Light Figure (companion):** warm, glowing, friendly, deliberately designed to never look sinister or read as suspicious at any point during normal play. Accompanies Ata at all times throughout the main game (post-introduction). Encourages Ata toward *good deeds* specifically (never toward cruelty or obvious sin) — this is the mechanism of its deception. Its true nature (the deceiver) is never confirmed to the player in-game. **Critical behavioral rule:** it never reacts, emotionally or visibly, to any appearance of the Christ-figure motif (see below) — no matter how many times it occurs. This is the primary (and only) discernment cue in the entire game, and it should only become noticeable in hindsight or on replay. **See Section 3 for an open tension between this rule and the dove-proximity mechanic — unresolved, needs a decision before implementation.**

**The Christ-figure motif:** extremely subtle, background presence only — e.g., a dove appearing briefly in open-sky/field areas. Never emphasized, explained, or pointed out by any UI or dialogue.

**No combat. No upgrades/leveling. Linear critical path with missable content**, in the mold of *Mad Father* — side interactions and attentiveness to characters are what unlock the "true" ending; rushing past them silently produces the default ending. Inventory exists in the main game (not during the introduction).

---

## 2. The 12-Day Structure

The main game (everything after the introduction) is divided into **12 days**, deliberately mirroring the 12 doves (Section 3). Each day offers a distinct set of activities — dialogue choices, dove-finding, conversations, exploration — all taking place before night falls.

- The introduction sequence is being built first, as its own self-contained phase. The day structure is a later development phase.
- Each night **may** include a nightmare sequence. Mechanic, structure, and purpose TBD — explicitly deferred for later discussion.
- **Open question (not yet decided):** does a day end automatically at a fixed point, forcing any undone content to be missed for good (stricter, more in line with the Mad Father missability philosophy) — or can the player choose when to end the day and sleep? This materially affects how "missable" the doves and choices feel, so it's worth deciding deliberately rather than by default.

---

## 3. The Doves & the Path to 100%

It is impossible to reach 100% on the Bar without collecting all 12 hidden doves scattered across the game **and** performing the kneeling action once the full set is collected. There is no other path to true completion.

**The doves:**
- 12 wounded doves hidden throughout the game world, in a wide variety of contexts — e.g. inside a pile of dirt, in Ata's bedroom, revealed only after a specific dialogue choice, etc. Exact placements TBD.
- Each dove should be very well hidden — deliberately, significantly missable on a first playthrough.
- The 12th and final dove is only obtainable at the very end of the game.
- Dove collection is tracked separately from the visible Bar percentage — it is not reflected numerically on the Bar itself.

**Dove visibility & proximity reveal (map-placed doves):**
- Doves placed directly in the game world are **completely invisible by default**.
- Concept: if Ata is within a small radius of tiles around a hidden dove, the Light Figure flickers once. If Ata is immediately adjacent (a single tile away), the dove fades into visibility; moving away fades it back out. Exact tile radius / grid size TBD.
- **⚠️ Open design tension — unresolved:** this mechanic means the Light Figure visibly reacts (via the flicker) to the proximity of the Christ-motif, which directly conflicts with the Section 1 rule that the Light Figure *never* reacts to any appearance of that motif, in any way, at any time. This needs a deliberate decision before implementation — possible directions include: (a) reframe the flicker as a generic "nearby secret" pulse unrelated to doves specifically, so it isn't uniquely tied to the Christ-motif; (b) narrow the "never reacts" rule to mean no emotional/behavioral acknowledgment specifically, treating a flicker as neutral/mechanical rather than a reaction; (c) drop the flicker and rely on level design/audio cues instead, preserving the Light Figure's rule exactly as originally written. Not decided — flagging so it isn't silently contradictory in the design.
- Doves obtained via dialogue choices or container items (see Section 5) are a separate delivery method and are not affected by the proximity-reveal mechanic above.

**The kneel action:**
- Once all 12 doves are collected, an option becomes available (tentatively somewhere in Ata's bedroom — exact placement TBD) for Ata to kneel.
- After a short pause, this leads into a final area, followed by a distinct alternate ending (different from the default ending described in Section 1). Full content of the final area and this ending is still TBD.

**Design continuity note:** the doves double as the game's existing Christ-motif made literal and collectible — the same dove imagery that appears ambiently and unacknowledged throughout the world (see Section 1) is also the exact thing the player must notice and gather to reach the true ending.

---

## 4. Dialogue & Choice System

The game is fundamentally choice-based; most meaningful choices are delivered through dialogue prompts.

**Standard dialogue choice structure:**
- A "do good" option (wording/context varies per scene)
- A "do bad" option (wording/context varies per scene)
- An "X" icon in the top-right corner of the dialogue box, allowing the player to leave without choosing — neither raises nor lowers the Bar

**Critical rule:** which option is "good" and which is "bad" is never signaled by position, order, or obvious phrasing. The player must judge based on their own read of the situation, not pattern recognition. One option always raises the Bar and the other always lowers it, but which is which should never become predictable across the game.

Doves (Section 3) may sometimes be tied to specific dialogue choices, rewarding attentive and compassionate play rather than optimal Bar-maximizing play.

---

## 5. Interaction System

**Global HUD rule (applies to everything):** whenever the player is *not* in free movement/control — dialogue, scripted sequences, cutscenes, any interaction animation, losing control for any reason — **all HUD elements disappear**, and return only when free control is restored. This should be built as a single mechanism that every non-free-control state routes through, not handled case-by-case per interaction.

**Two kinds of interactable objects:**
- **Container objects** (objects that hold items) → interacting opens an inventory-like menu showing the items inside. Selecting an item resolves it (see dove flow below for the pattern).
- **Plain interactables** (nothing inside) → interacting simply opens a dialogue box with Ata's own comment/observation about the object. No menu.

**Dove interaction flow:**
- A dove may be encountered a few ways:
  - **Placed directly in the world** → invisible by default; revealed via the Light Figure proximity mechanic described in Section 3. Once visible, rendered as a sprite (max 4 frames) and interacted with directly.
  - **Hidden inside a container** (drawer, pile, etc.) → appears as a wounded-dove icon inside that container's item menu. When the player selects it, the menu closes and the dove appears on the ground. The player is then free to move — they may tend to the dove or walk away and leave it.
- **Tending a dove:** Ata kneels, closes her eyes, and touches the dove. 2s after the touch, the dove — still in the same wounded pose but now visibly healthier with open eyes — fades out over 3s. After it disappears, a centered on-screen message reads "Something happened elsewhere..." (2s fade-in, ~3s hold, 2s fade-out). Control returns to the player afterward.
- Per the global HUD rule above, all HUD is hidden throughout this entire animation.

**Design note:** the "Something happened elsewhere..." line conveys that Ata's small, hidden act of mercy has an unseen consequence — deliberately never shown or explained.

---

## 6. Introduction Sequence (First Playable Scene)

**Characters on screen:** a shadowy man (player-controlled) and a shadowy woman (auto-follows). Both are **blurred, interpretive Adam-and-Eve representatives** — not literally Adam and Eve, not named, not explained. **Ata is not present in this scene.**

**Setting:** a beautiful, sunlit forest — fruit, animals, life. Something is wrong; they are fleeing.

### Sequence — built on position-based triggers, not timers

Story beats are tied to **where the player is on the path** (via `Area2D` trigger zones), not elapsed time. This avoids desync if the player moves at an unexpected pace, pauses, or gets briefly stuck. Only things that are genuinely duration-based (letter-fade-in text, fixed run-to-bush animation) use time internally.

| Stage | Trigger | Event |
|---|---|---|
| Auto-walk | Scene start, after 2s fade-in | Man + woman auto-walk in from left edge, no player input |
| Handoff | Figures reach ~33% screen mark | Control passes to player. Tooltip appears: WASD shown, **D highlighted red**, text "**Press D to RUN!**". Forward-lock engages (no backward or vertical movement — forward only). Tension music fades in. |
| Trigger Zone 1 | Player crosses this x-position | "Where are you?" — low, deep, uncanny (not scary) voice. Bottom-screen text only, no dialogue box, letter-by-letter fade-in. |
| Animal Zones | Series of zones along the path | Progressive animal reveal/staring, tied to distance traveled, not time |
| Pursuit mechanic | Continuous, background | A fixed, invisible shadow entity trails the player at a set distance. **Closes the gap only while the player is idle/stationary.** Does not close while player moves forward. Proximity indicator is diegetic: the ambient "sound of many waters" (the same motif used in the default ending, Section 1) swells louder as the shadow approaches and grows distant as it recedes. Even at closest proximity, the sound should stay restrained — never overwhelming or "exploding." Actual sound asset to be provided later. |
| — Catch state (branch) | Shadow reaches the player | Both characters curl up (new pose, 4–8 frames). Shadow hovers over them. Screen fades to black. **Scene restarts from Auto-walk.** |
| Trigger Zone 2 (Freeze Point) | Player nears the bush | Hard stop: music cuts, both characters freeze, animals snap a glance offscreen toward the bush |
| Sequential (no timer) | Immediately following freeze | Woman looks at bush → woman points at bush → man looks at woman → man looks at bush |
| — | On last look | Dialogue box opens. Shadowy bush-figure — **visually distinct from the later Light Figure model**, deliberately, so the connection isn't obvious — says: "Come here! Quick!" |
| — | On dialogue close | Both glance back briefly |
| — | +short fixed-duration beat | Both run (faster animation) toward the bush |
| — | On arrival | Figures disappear into the forest |
| — | Immediately after | Gigantic shadow sweeps across the whole map + wind SFX cue (placeholder) |
| — | +short beat | Quick flashy pull-in transition |
| Cut to | — | Bedroom. Ata lying on bed (mockup only for this phase — no other bedroom features yet) |

**Architecture note:** implement as a single scene driven by a **state machine** (e.g., `auto_walk → player_control → frozen → pointing_sequence → dialogue → fleeing → caught → transition`), using `Area2D` trigger zones to advance state rather than timers.

---

## 7. Animation Frame Budgets

| Category | Frame count |
|---|---|
| Protagonist (Ata) & Light Figure | 5–10 frames |
| All other characters (incl. intro's man/woman) & animals | 4–8 frames (additional poses added as needed — e.g. pointing, look-over-shoulder, curl-up) |
| Environment (trees, rocks, ambient world motion) | 15–25 frames |
| Unfightable "disturbing" enemies (later in game) | 15–25 frames, high detail |

**Design rationale:** character frame counts stay modest and readable; the "very animated, alive" feeling comes primarily from ambient environmental motion and easing, not from character frame count.

---

## 8. Core Game Mechanics

- Movement: WASD or arrow keys, **4-directional only** (no diagonal movement)
- Interact: `E` key or left mouse click
- Inventory selection: mouse wheel or number keys `1`/`2`/`3`
- No combat, no upgrade/leveling systems
- Linear critical path with missable side content affecting the ending
- Inventory present in main game only (not in the introduction)

---

## 9. UI / UX Rules

- **Introduction sequence:** no UI at all except the movement tooltip and bottom-screen narration text. No dialogue box until the bush-figure scene.
- **Main game (post-intro):** dialogue box appears at the bottom of the screen with a small character portrait beside it; inventory and bar UI become active.
- **Text rendering rule (applies everywhere):** all on-screen text appears via a **per-letter fade-in** (not a typewriter reveal) — each letter fades in sequentially. Skipping dialogue makes the box disappear **immediately**, no fade-out. Text that finishes naturally fades out **all at once**.
- UI should include tooltips throughout — target audience spans a wide age range and the story/setting is conceptually demanding even if the interface shouldn't be.

---

## 10. Sound Design

- Footstep sound reflects terrain (wood, carpet, rain, earth, sand, etc.)
- Ambient sound is location-dependent (e.g., rain is louder outdoors, muffled/quiet in a basement)
- "The sound of many waters" is a recurring motif, not a one-off effect — it appears both as the introduction's pursuit-proximity cue (Section 6) and as part of the default ending (Section 1). Keep it as the same underlying sound identity in both places.
- **All music and SFX will be provided externally by the developer** (self-made or Suno-generated). Do not include placeholder or default engine sound/music unless explicitly instructed.

---

## 11. Engine & Technical Stack

- **Engine:** Godot — chosen for 2D suitability, lightweight footprint, free/open-source, clean Mac + Windows export, and a scene/node model well suited to room-by-room level structure.
- **Language:** GDScript, **statically typed** throughout (e.g. `var health: int = 100`, `func take_damage(amount: int) -> void:`).
- **Scripted-sequence architecture:** state machines + `Area2D` position-based triggers, not timers, for cinematic/scripted sequences like the introduction.
- **Data-driven design:** dialogue lines, item definitions, and bar-modifying event values should live in Godot `.tres` resource files or structured data files rather than being hardcoded into scripts, so values can be tuned without touching code.
- Must run on **Mac and Windows**. Must remain lightweight despite high animation/interactivity goals.

---

## 12. Coding Standards

- **Formatting:** tabs for indentation (Godot's own convention). No inline `if` statements with side effects — break onto their own line, except trivial guard clauses (`if not is_active: return`). Soft line-length cap (~100 chars).
- **Naming:** `snake_case` for variables/functions, `PascalCase` for classes/nodes/file names, `ALL_CAPS` for constants.
- **Typing:** static typing everywhere — no untyped variables or function signatures.
- **Structure:** one scene = one responsibility. Prefer **signals** over direct cross-node references for decoupling. Autoload/singleton scripts reserved only for genuinely global state (e.g. bar value, save data, dialogue manager) — everything else stays local to its scene.
- **No magic numbers:** thresholds, timings, and percentages become named constants, not bare literals in logic.
- **Comments:** short header comment at the top of every script stating its purpose. Doc-comments on public functions. Inline comments explain *why*, not *what*.
- **Documentation tone:** written clearly enough that a senior developer could be explaining it to a junior — no unexplained jargon.
- Security: no login/auth systems needed (offline game), but general safe-handling practices should still be followed for any local file I/O (e.g. save data).

---

## 13. Repository & Version Control

- Repo: https://github.com/horodenko/untitled-godot-game (public)
- **Branch strategy:**
  - `develop` — active branch, all day-to-day work is committed and pushed here.
  - `main` — reserved exclusively for tagged stable releases, starting at v1.0. Not touched during active development.
- **Commit message convention** (a lightweight prefix system layered on top of the branch strategy above — distinct from full Gitflow, which also involves feature/release/hotfix branches):
  - `Feature | [component/file] - [description]` — new functionality
  - `Fix | [component/file] - [description]` — bug fixes
  - Suggested additions, pending confirmation: `Refactor | [component/file] - [description]`, `Docs | [component/file] - [description]`, `Chore | [component/file] - [description]` — adopt if useful, otherwise stick to just Feature/Fix.
- Fable 5's first concrete task: initialize the Godot project skeleton, establish the folder structure, write the actual README.md (using this brief as source material, not a copy), and make the initial commit to `develop`.

---

## 14. Open Items / Not Yet Decided

- Working title for the game
- Full character roster beyond Ata and the Light Figure
- Complete list of Bar-modifying choices/events across the main game
- Exact placement list for the 12 doves
- Full staging of the kneel scene and the final area/alternate ending that follows it
- Level/map design beyond the introduction and the bedroom mockup
- Specific animal species list for the forest scene (currently "several kinds," not yet finalized)
- Final color palette (pending further mood-board generation)
- Exact naming for the "give up / move on" prompt that appears if the Bar hits zero on solid ground — placeholder names only so far, deliberately avoiding language that reads as a generic "overcome" framing
- Whether a day ends automatically at a fixed point or the player chooses when to sleep (Section 2)
- Nightmare mechanic during nights — not yet designed (Section 2)
- **The Light Figure proximity-flicker vs. the "never reacts to Christ-motif" rule (Section 3) — genuine open contradiction, needs a deliberate resolution before implementation**
