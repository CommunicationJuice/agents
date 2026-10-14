# agents — Shared Agent Workspace for Communication Juice

A public, user-independent workspace on Art 2 that bundles the agency's creative agent repos and keeps them automatically in sync with GitHub.

## Why this exists

The sibling repos (`Creator`, `video-editing`, `ai-media-generation`, `Affinity-Automation`) are private development workspaces under `github.com/communicationjuice`. This repo is a **read-only, shared landing pad** for agents running on the office Mac mini (`Art 2`, `10.0.0.180`). It is checked out to `/Users/Shared/Agents` so it is available regardless of who is logged in.

## Layout

```
/Users/Shared/Agents/
├── .ssh/                          # deploy key used for private submodule pulls
├── .node/                         # shared Node.js runtime (user-independent)
├── agents/                        # this repository
│   ├── AGENTS.md                  # agent operating protocol
│   ├── README.md                  # this file
│   ├── bin/
│   │   └── activate               # source to put shared tools on PATH
│   ├── local/
│   │   ├── applications.yaml      # Art 2 local app paths
│   │   └── env.example            # environment variables template
│   ├── scripts/
│   │   ├── update.sh              # pulls latest agents + all submodules
│   │   └── install.sh             # installs Node + Hyperframes CLI on Art 2
│   ├── Creator/                   # submodule → CommunicationJuice/creator
│   ├── video-editing/             # submodule → CommunicationJuice/video-editing
│   ├── ai-media-generation/       # submodule → CommunicationJuice/ai-media-generation
│   └── Affinity-Automation/       # submodule → CommunicationJuice/affinity-automation
```

## Local applications

- **Affinity** is expected at `/Applications/Affinity.app` (Affinity 3 unified app). If it is missing, run `scripts/install.sh --check` to see install notes.
- **Hyperframes CLI** is installed by `scripts/install.sh` into `.node/` and is available after sourcing `bin/activate`.

## Quick start on Art 2

```bash
# From any account with access to /Users/Shared
cd /Users/Shared/Agents/agents
source bin/activate
./scripts/install.sh
./scripts/update.sh
```

## Automatic updates

A system-wide `LaunchDaemon` runs `scripts/update.sh` every 5 minutes. It pulls the latest `agents` repo and recursively updates all submodules. Logs go to `/Users/Shared/Agents/var/log/agents-update.log`.

## Security

- This repo is **public**. No secrets, credentials, or client material live here.
- The private submodules are pulled with a dedicated, read-only SSH deploy key stored in Infisical. The key file is restricted to `cjadmin:staff` with `0600` permissions.
- If you need to rotate the deploy key, regenerate it on Art 2 and update the deploy keys in each private repository.

## Repo URLs

- `agents` (public): `https://github.com/CommunicationJuice/agents`
- `Creator`: `https://github.com/CommunicationJuice/creator`
- `video-editing`: `https://github.com/CommunicationJuice/video-editing`
- `ai-media-generation`: `https://github.com/CommunicationJuice/ai-media-generation`
- `affinity-automation`: `https://github.com/CommunicationJuice/affinity-automation`
