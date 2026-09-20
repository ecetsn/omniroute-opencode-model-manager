# omniroute-opencode-model-manager

A small CLI (`omni-models`) that keeps [OpenCode](https://opencode.ai)'s
OmniRoute model list clean, instead of dumping in hundreds or 1000+ models
from OmniRoute's catalog.

**This is not an official OmniRoute project.** It's an independent helper
script for people who use OpenCode with OmniRoute.

## The problem

OmniRoute can expose a very large number of provider/model combinations to
OpenCode as a single `omniroute` provider. Importing all of them makes
OpenCode's model selector noisy and hard to use, and - importantly -
**a model being visible in the list doesn't mean it's actually usable**.
Many of those combinations only work if your specific provider account
supports them; picking the wrong one gets you an error at request time, not
at import time.

`omni-models` edits only the `omniroute` provider's model list inside your
OpenCode config, leaving every other provider and setting untouched, so you
can keep just the handful of models you actually use.

## Installation

```
git clone <this-repo>
cd omniroute-opencode-model-manager
./install.sh
```

This installs `omni-models` to `~/.local/bin/omni-models` and its presets
to `~/.local/share/omniroute-opencode-model-manager/presets`. If
`~/.local/bin` isn't on your `PATH`, the installer prints the export line
to add to your shell rc file - it won't edit your shell config for you.

To uninstall: `./uninstall.sh` (this never touches your OpenCode config or
its backups).

## Recommended workflow

1. Install and start OmniRoute.
2. Point OpenCode's `omniroute` provider at OmniRoute's API base:
   `http://localhost:20128/v1` (see `examples/opencode.jsonc.example`).
3. Let OmniRoute populate the full model catalog once, if you want to browse
   what's available.
4. Use `omni-models` to cut that down to only the models you want:

```
omni-models preset basic
# or curate manually:
omni-models keep kr/auto kr/claude-sonnet-5
```

## Usage

```
omni-models list                       # show currently enabled models
omni-models add kr/claude-sonnet-5   # add a model
omni-models preset recommended         # replace the list with a preset
omni-models remove openrouter/openrouter/free
omni-models restore                    # restore the most recent backup
omni-models help
```

There are no aliases - you always pass real model IDs (e.g.
`kr/claude-sonnet-5`, `openrouter/z-ai/glm-5.2:free`), exactly as
OmniRoute/OpenCode expect them.

### Presets

| Preset | Use case |
|---|---|
| `basic` | Minimal starting point |
| `recommended` | Well-rounded default set |
| `free-openrouter` | OpenRouter free-tier models only |
| `coding` | Day-to-day coding models |
| `research` | Long-context / reasoning-heavy models |

Presets live as plain text files in `presets/*.txt` (one model ID per
line) - edit them or add your own.

## How it works

`omni-models` reads and writes `~/.config/opencode/opencode.jsonc`
directly (override with `OMNI_MODELS_CONFIG=/path/to/opencode.jsonc`). It
only touches the `provider.omniroute.models` block; every other provider,
setting, and comment in your config is left alone. A timestamped backup is
made before every write, and `omni-models restore` brings back the most
recent one.

See `docs/providers.md` for notes on specific providers and
`docs/troubleshooting.md` for common error messages.

## License

MIT, see [LICENSE](LICENSE).
