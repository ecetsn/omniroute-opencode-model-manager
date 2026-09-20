# Troubleshooting

## "Authentication required"

Your OmniRoute instance (or the underlying provider account) isn't
authenticated for that model. Check the OmniRoute dashboard for the
provider in question and re-authenticate there - `omni-models` only edits
OpenCode's config, it has no control over OmniRoute's own auth state.

## "1000+ models imported"

This is exactly the problem `omni-models` exists to fix. Run:

```
omni-models preset basic
```

or `omni-models keep <id> [id ...]` to cut the list down to only what you
actually use, then add models back one at a time as needed.

## "model is not available in the active live catalog"

The model ID is listed in your config but OmniRoute's current catalog
doesn't have it (it may have been renamed, removed, or your account lost
access). Remove it:

```
omni-models remove <the-model-id>
```

## "Request too large" / "Input exceeds maximum input tokens"

The selected model's context window is smaller than what you're sending.
Switch to a model with a larger context limit, or trim the input. This is
a model/provider limitation, not something `omni-models` controls.

## OpenCode free tier errors

Some models require a paid tier or specific account entitlement on the
underlying provider, even if OmniRoute shows them as available. Check the
provider's own dashboard/billing status.

## OmniRoute dashboard works but OpenCode model fails

This usually means the model is visible in OmniRoute's catalog but not
actually reachable with your current credentials/account - "visible" and
"usable" are not the same thing. Try a different model from the same
provider, or check OmniRoute's logs for the actual upstream error.

## How to restore from backup

`omni-models` backs up your config before every write, next to the config
file itself (e.g. `~/.config/opencode/opencode.jsonc.bak-20260101-120000`).
To restore the most recent one:

```
omni-models restore
```

This asks for confirmation and backs up the current (possibly broken)
config first, so restoring is itself non-destructive. To restore an older
backup manually, copy it over your config yourself:

```
cp ~/.config/opencode/opencode.jsonc.bak-<timestamp> ~/.config/opencode/opencode.jsonc
```


## Kiro models use the wrong `kiro/` prefix

Older versions of this repository used `kiro/` in examples and presets.
OmniRoute expects the Kiro provider prefix to be `kr/`.

Update the tool first:

```bash
git pull
./install.sh
```

Then back up and migrate only the model ID prefix in your OpenCode config:

```bash
omni-models backup
sed -i 's#kiro/#kr/#g' ~/.config/opencode/opencode.jsonc
```

Verify the result:

```bash
omni-models list
```
