# Hiruno Plugin

Write short-form video scripts composed from **proven viral components**, not
guesses. Hiruno analyzes winning TikToks / Reels / Shorts into a compounding
database of hooks, structures, and CTAs with real engagement evidence — and
gives Claude validated building blocks to write your scripts from.

**Beta.** Analysis is capped at 5 videos per rolling 24h per account; script
retrieval and writing are unlimited.

## What you get

- `analyze_video` — drop a viral video URL; a multimodal model watches it and
  stores the full breakdown (hooks, structure, CTA, script) with engagement
  evidence.
- `find_winning_parts` — evidence-ranked script components for any topic
  (similarity × tier × multi-video proof × share rate).
- `research_topic` — what proven videos actually SAY around a topic: ranked
  idea cards (topic, substance, contrarian take), flops included as negative
  evidence.
- `get_brand_context` / `save_brand_context` — your brand context (intake,
  posting tier, locked days, niche map, locked formats) saved to your
  account, so every script is grounded in it without re-uploading anything.
  Multiple named brands per account (agencies welcome).
- `script-writer` skill — the guided workflow: one-time brand setup, weekly
  batch planning (message bank → week grid → script-by-script), and
  analyze-and-vary (change exactly one variable of a reference video into N
  brand-adapted variations).
- `get_source` / `log_created_script` — provenance drill-down and automatic
  tracking of what was written from which patterns.

## Install — Claude Code

```
/plugin marketplace add angelobaricante/hiruno-plugin
/plugin install hiruno@hiruno
```

On first tool use, Claude Code opens the OAuth sign-in — create your Hiruno
account there.

## Install — claude.ai / Claude Desktop

1. **Connector**: Settings → Connectors → *Add custom connector* →
   `https://www.hiruno.com/mcp`
   Sign in / create your account when the authorization page opens.
2. **Skill**: download `script-writer.zip` from this repo's
   [Releases](../../releases) (or build it with `scripts/package-skill.sh`)
   and upload it under Settings → Capabilities → Skills.

## Use

> set up my brand

> plan my content week

> analyze this video https://www.tiktok.com/@.../video/... — then make 3
> versions with a different hook

> write me a 45s reel script about why most people fail at meal prepping

Script writing always starts from your saved brand context (a one-time
guided setup: intake → posting tier → locked days → niche map → locked
formats). The skill then researches what winning videos say in your
sub-niches, plans your week as a grid, and writes each script from winning
hooks/structures/CTAs — every choice tagged with its evidence (tier, number
of proven videos, niches). Cross-niche transfer is the point — a hook
mechanic proven in fitness works in finance. Analyzing videos and topic
research need no setup at all.

## Layout

```
.claude-plugin/plugin.json     plugin manifest + hosted MCP server config
.claude-plugin/marketplace.json  lets this repo act as its own marketplace
skills/script-writer/          the composition workflow + taxonomy references
scripts/package-skill.sh       builds script-writer.zip for claude.ai upload
```
