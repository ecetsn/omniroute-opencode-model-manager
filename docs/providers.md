# Provider notes

Quick, practical notes on the providers commonly exposed through OmniRoute.
None of this is authoritative - availability, pricing, and rate limits
change; always check the provider/OmniRoute dashboard for current status.

## Kiro

Useful for Claude-style coding models. Generally a solid default for
day-to-day coding work if your account has access.

## Antigravity

Useful for Gemini/Claude/GPT-OSS-style routing where available. Coverage
depends on what your OmniRoute setup actually has enabled.

## OpenRouter free models

Useful for experimentation, but rate limits and availability vary a lot
between models and over time. Don't rely on a `:free` model for anything
time-sensitive.

## Groq

Fast inference, but context limits can be small depending on the specific
model. Good for quick, short interactions; less good for large-context
tasks.

## NVIDIA

Useful for fast hosted inference with NVIDIA-backed models such as Nemotron, especially for experimentation and fallback routes.

Coverage depends on your NVIDIA account, available credits, region, and what your OmniRoute setup actually has enabled.


## OpenCode built-in models

These do not go through OmniRoute at all and don't need to be managed by
`omni-models`.

## Recommendation

Start small: Kiro + Antigravity + a couple of OpenRouter free models is
usually enough to cover most work. Add more only when you find a specific
model you actually need. See the `recommended` preset as a starting point.
