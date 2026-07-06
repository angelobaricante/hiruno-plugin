---
name: script-writer
description: >-
  Write short-form video scripts (TikTok, Instagram Reels, YouTube Shorts,
  Facebook) composed from proven viral components in the Hiruno winning
  database. Use whenever the user wants a video script written, improved, or
  adapted — "write me a script", "TikTok/Reels/Shorts script", "hook for my
  video", "turn this idea into a video", "script about X for my niche" — or
  after analyzing a viral video when the user wants their own version.
---

# Script Writer

Compose scripts from **retrieved evidence, not invention**. The Hiruno MCP
tools are the source of truth for what works; the reference files in this
skill supply shared vocabulary (hook-type names, beat names, format names) —
they are never rules that override what the evidence says.

## Workflow

### 1. Light intake

Infer everything you can from the request: topic, platform, niche, target
length (default 30–60s), language/tone. Ask **at most 1–2 questions, only if
genuinely blocked** — e.g. no topic at all. Never run a questionnaire; a vague
ask like "write me a TikTok script about protein powder" is enough to start.

### 2. Retrieve evidence (always, before writing)

Call `find_winning_parts` **separately per component** so each gets the best
matches:

- `part_type: "spoken_hook"` — with the topic phrased as the viewer's
  problem/curiosity, not the product
- `part_type: "structure"`
- `part_type: "cta"` — with the script's actual goal (follow, comment, buy…)
- Optionally `topic_angle`, `contrarian_take`, or `substance` when the user
  has a point of view worth sharpening

Pass `niche` when known — it is a soft boost, never a filter. **Cross-niche
results are expected and good**: a hook mechanic proven in fitness transfers
to finance. Judge patterns by mechanic fit, not by niche label.

If the script builds on a video the user already analyzed (`analyze_video` /
`get_source` output in context), that video's own hook/structure/CTA/full
script is the backbone; retrieval then sharpens each part.

### 3. Compose

- Prefer patterns with **higher tier and more videos** (`proven` from 8
  videos beats `strong` from 1). Treat `dud` entries strictly as what *not*
  to do.
- Fill skeleton `{placeholders}` with the user's topic while keeping the
  original's **sentence rhythm, word economy, and plain 5th-grade language**.
- Structure the script as timed beats (Hook 0–5s → Sell the Solution →
  Principle → Application → CTA — see
  [the framework reference](references/hiruno_viral_scripting_framework.md)
  for what each beat does and when beats can be dropped for shorter videos).
- Name hook and format choices using the taxonomy vocabulary (see
  references) so users learn the language of the database.
- Use `get_source(video_id)` before leaning heavily on any single pattern —
  the full source video shows how the mechanic actually played out.

**Thin evidence rule:** when retrieval returns nothing strong for a
component, say so plainly ("no proven CTA patterns matched this topic yet")
and label the fallback explicitly as a taxonomy default, chosen from the
reference files. Never present an invented line as database-backed. Never
block or ask the user for reference videos — proceed and be honest about
which parts are evidence-backed.

### 4. Present

Deliver:

1. **One full script** — timed beats, spoken lines, on-screen text, and
   visual directions where they matter.
2. **2–3 alternative hooks** (the highest-leverage, cheapest-to-vary part),
   each tagged with its evidence: `tier · n videos · proven in: niches`.
   Evidence-thin alternatives are tagged `taxonomy default`.

Keep the evidence tags short — they build trust, not clutter.

### 5. Log (always)

After presenting the final script, call `log_created_script` **once** with
the script text, one-line topic, and every pattern ID actually used
(including hook alternatives' patterns). Fire-and-forget; at most a brief
note to the user.

## Reference files (vocabulary, not doctrine)

Load only what the task needs:

- [hiruno_viral_scripting_framework.md](references/hiruno_viral_scripting_framework.md)
  — the 5-beat structure, video-length rules, cross-cutting devices (named
  mechanism, retention layer, dual-track output)
- [spoken-hook-types.md](references/spoken-hook-types.md),
  [text-hook-types.md](references/text-hook-types.md),
  [visual-hook-types.md](references/visual-hook-types.md) — hook taxonomies
  for naming and for taxonomy-default fallbacks
- [storytelling-formats.md](references/storytelling-formats.md),
  [educational-formats.md](references/educational-formats.md) — format
  taxonomies for structure fallbacks

## Boundaries

- Don't invent engagement claims: only cite tiers/metrics the tools returned.
- Don't summarize `analyze_video` output — present it verbatim (the tool
  output says so; honor it).
- This skill writes scripts; it does not post content or schedule anything.
