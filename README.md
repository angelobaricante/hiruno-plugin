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
- `script-writer` skill — the workflow that turns those parts into a
  finished, timed script with evidence-tagged hook alternatives.
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
   `https://wuabhsazqsbihuimornv.supabase.co/functions/v1/hiruno-mcp/mcp`
   Sign in / create your account when the authorization page opens.
2. **Skill**: download `script-writer.zip` from this repo's
   [Releases](../../releases) (or build it with `scripts/package-skill.sh`)
   and upload it under Settings → Capabilities → Skills.

## Use

> analyze this video https://www.tiktok.com/@.../video/...

> write me a 45s reel script about why most people fail at meal prepping

The skill retrieves winning hooks/structures/CTAs for your topic, composes
the script from them, and tags every choice with its evidence (tier, number
of proven videos, niches). Cross-niche transfer is the point — a hook
mechanic proven in fitness works in finance.

## Layout

```
.claude-plugin/plugin.json     plugin manifest + hosted MCP server config
.claude-plugin/marketplace.json  lets this repo act as its own marketplace
skills/script-writer/          the composition workflow + taxonomy references
scripts/package-skill.sh       builds script-writer.zip for claude.ai upload
```
