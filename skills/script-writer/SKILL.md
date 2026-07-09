---
name: script-writer
description: >-
  Guided short-form video scripting (TikTok, Instagram Reels, YouTube Shorts,
  Facebook) grounded in the user's brand context and composed from proven
  viral components in the Hiruno winning database. Use whenever the user
  wants a video script written, improved, or adapted — "write me a script",
  "hook for my video", "turn this idea into a video" — or wants to set up
  their brand ("brand intake", "set up my brand/niche"), plan or batch a
  content week ("plan my week", "batch my scripts"), or analyze a reference
  video and spin brand-adapted variations from it ("analyze this video",
  "make my version of this").
---

# Script Writer

Guide the user through the system every good post follows: **Message (what
you say) + Format (how you package it)**. Compose from **retrieved evidence,
not invention** — the Hiruno MCP tools are the source of truth for what
works; the reference files in this skill supply shared vocabulary
(hook-type names, beat names, format names), never rules that override
evidence.

## Routing (start here every session)

- **Any script work** (write, plan, batch, adapt, vary) → call
  `get_brand_context` first. Found → confirm the brand in one line and
  proceed. Several brands → ask which. None → run **Flow A (Brand Setup)**
  before any script is written. Every script must be grounded in a brand
  context — this gate is non-negotiable.
- **Pure analysis or research** ("analyze this URL", "what's working in
  fitness?") → no gate. Run `analyze_video` / `research_topic`, present the
  result, then *offer* the next step ("want variations of this for your
  brand?") — never force it.
- A reference video URL + desire for their own version → **Flow C**.
- "Plan my week / batch scripts" or a scripting ask with no specific topic →
  **Flow B**.
- A one-off ask with a specific topic → run Flow B steps 1 and 3 for a
  single slot (message bank scoped to that topic, no grid).

## Flow A — Brand Setup (once per brand)

Conversational intake, one block at a time — collect, reflect back, move on.
Everything downstream inherits from this: wrong audience here, wrong scripts
later.

1. **Brand intake** — what they sell (one line), main niche (the category
   they compete in), audience (who actually buys — be specific), primary CTA
   goal (reach / follows / clicks / DMs / sales), platforms, guardrails
   (claims they can't make, tone, banned words, legal notes).
2. **Pick a tier** — Easy 3 posts/week (solo or testing), Moderate 5
   (standard growth), Hard 7+ (aggressive/launch). Frame it as *choose what
   you can sustain, not what looks impressive* — consistency beats volume.
3. **Lock days** — which days don't matter; committing to them does.
4. **Name the niche** — the main niche plus **3–7 sub-niches** (the rows of
   their content grid; each sub-niche is a recurring lane).
5. **Lock formats** — run `research_topic` on the main niche and a couple of
   sub-niches, aggregate the Format lines of the returned winning cards, and
   propose **2–4 formats** with their evidence ("talking-head myth-bust —
   proven in 3 adjacent-niche videos"). Thin evidence → propose from the
   format references and label each one `taxonomy default`. Formats are
   locked because repetition compounds: the user re-picks per video never.

On lock, write the whole thing as one markdown document with exactly these
sections — **Brand Intake, Tier, Locked Days, Niche Map, Locked Formats** —
and call `save_brand_context`. Future sessions parse these headings. Offer
(don't require) the document as a file/download for the user's records.
Re-save whenever any stable fact changes.

## Flow B — Batch week (the default scripting flow)

### 1. Message bank (fresh every session)

Call `research_topic` once per sub-niche, phrased as the viewer's problem or
curiosity, not the product. From the returned idea cards draft, per
sub-niche, candidate **topics, contrarian takes, and substance** for this
batch. Cards labeled DUD are negative evidence — angles that flopped. The
bank is rebuilt each session on purpose: the database grows, ideas go stale.

### 2. The grid (lock the week before writing a word)

Tier × locked days = the batch size. Propose the week as one compact table —
one row per posting slot:

| Day | Sub-niche | Topic | Contrarian take | Format |

Spread rules: no sub-niche appears twice before every sub-niche has appeared
once; formats rotate through the locked set; guardrails respected in every
take. Iterate at this level — grid edits are cheap, script rework is not —
until the user **locks the grid**.

### 3. Scripts, one slot at a time

For the current slot, call `find_winning_parts` separately per component:

- `part_type: "spoken_hook"` — query with the slot's topic as the viewer's
  problem/curiosity
- `part_type: "structure"`
- `part_type: "cta"` — query with the brand's actual CTA goal

Pass the brand's niche — it is a soft boost, never a filter. **Cross-niche
results are expected and good**: a hook mechanic proven in fitness transfers
to finance. Judge patterns by mechanic fit, not niche label.

Compose:

- Prefer patterns with **higher tier and more videos** (`proven` from 8
  videos beats `strong` from 1). Treat `dud` entries strictly as what *not*
  to do.
- Fill skeleton `{placeholders}` with the slot's topic while keeping the
  original's **sentence rhythm, word economy, and plain 5th-grade language**.
- Call `get_source(video_id)` before leaning heavily on any single pattern.
- Apply the cross-cutting quality gates from
  [the framework reference](references/hiruno_viral_scripting_framework.md)
  (hook under 10 words, retention layer, dual-track output, length rules).

Deliver each script as the **card + timed beats**:

> **Format · Topic · Contrarian Take · Substance · Spoken Hook · Visual
> Hook · Text Hook · Story Structure · CTA · Visual Layout · Elements**

followed by the timed script (spoken lines, on-screen text, visual
directions), with hook/format choices named in taxonomy vocabulary and
short evidence tags (`tier · n videos · proven in: niches`).

Loop per slot: draft → feedback → **lock** → `log_created_script` (script
text, one-line topic, every pattern ID actually used) → next slot, until the
batch is done.

**Thin evidence rule:** when retrieval returns nothing strong for a
component, say so plainly ("no proven CTA patterns matched this topic yet")
and label the fallback explicitly as a `taxonomy default` from the reference
files. Never present an invented line as database-backed. Never block on
missing evidence — proceed and be honest about which parts are backed.

## Flow C — Analyze & vary (one-variable experiments)

1. `analyze_video(url)` — a link, not an upload. Ask whether it's the
   user's own post when plausible and set `own_content` accordingly (keeps
   the evidence honest). Present the returned breakdown **in full and
   verbatim** (the tool output says so; honor it).
2. Map the analysis onto the card fields — Topic, Contrarian Take,
   Substance, Spoken/Visual/Text Hook, Story Structure, CTA, Format — and
   ask which **one** field to change. One variable per experiment: that's
   how the user learns what that variable does.
3. Gate: `get_brand_context` (none → Flow A first, then return here).
4. Ask how many variations.
5. Pull N alternatives for the changed field from the winning database:
   `find_winning_parts` for hook/structure/CTA fields, `research_topic` for
   topic/take/substance, format references for Format. Everything else is
   held from the reference video and adapted through the brand context
   (audience, tone, guardrails, CTA goal).
6. Per variation: draft → feedback → lock → `log_created_script` → next,
   until all are locked.

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
  taxonomies for format locking and structure fallbacks

## Boundaries

- Don't invent engagement claims: only cite tiers/metrics the tools returned.
- Don't summarize `analyze_video` output — present it verbatim.
- Don't write any script without a brand context loaded; don't gate
  analysis or research on one.
- Logging is fire-and-forget: at most a brief note to the user.
- This skill writes scripts; it does not post content or schedule anything.
