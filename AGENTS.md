# AGENTS.md — agents shared workspace

## What this is

This is the **user-independent agent landing zone** on Art 2 for Communication Juice creative automation.

It bundles four sibling repositories as Git submodules:

| Submodule | Role | Local path |
|---|---|---|
| `Creator` | Creative direction hub | `./Creator` |
| `video-editing` | HyperFrames motion & edit | `./video-editing` |
| `ai-media-generation` | Higgsfield / Magnific / Canva generation | `./ai-media-generation` |
| `Affinity-Automation` | Affinity & Canva automation | `./Affinity-Automation` |

The parent directory is `/Users/Shared/Agents/agents`. Sibling references inside the original repos (e.g. `../ai-media-generation`) are **re-mapped** through the local adaptation layer; agents should consult `local/applications.yaml` and the environment instead of assuming relative paths.

## Agent rules

1. **Always run inside `/Users/Shared/Agents/agents`** after sourcing `bin/activate` so Node, Hyperframes, and helper scripts are on PATH.
2. **Do not commit secrets.** All credentials come from Infisical or from Art 2's keychain/secure storage.
3. **Do not modify submodule contents directly.** If a local adaptation is required, put it in `local/` or open a PR against the upstream private repo.
4. **Check local app manifest first.** Read `local/applications.yaml` before invoking Affinity, Hyperframes, Canva, or other local tools.
5. **Run `./scripts/update.sh` before starting work** to ensure you have the latest upstream changes.

## Local app manifest

See `local/applications.yaml` for the current paths:

- `affinity.app`: `/Applications/Affinity.app`
- `hyperframes.cli`: available via `npx hyperframes` after `source ../bin/activate`
- `node.runtime`: `/Users/Shared/Agents/.node/bin/node`

## Update flow

```bash
./scripts/update.sh
```

This script:
1. Pulls the latest `agents` repo.
2. Runs `git submodule update --init --recursive` to refresh all submodules.
3. Records the result and timestamp in `/Users/Shared/Agents/var/log/agents-update.log`.

## Troubleshooting

- If submodule auth fails, verify the deploy key in `/Users/Shared/Agents/.ssh/id_ed25519_agents` is present and has `0600` permissions.
- If Hyperframes is missing, run `./scripts/install.sh`.
- If Affinity is missing, install it from Serif/MAS and update `local/applications.yaml` if the path differs.
