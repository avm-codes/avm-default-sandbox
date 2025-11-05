# Release Guide for v1.0.0

## Pre-Release Checklist

### ✅ Files Ready for v1.0.0

- [x] **Dockerfile** - Multi-language base image configured
- [x] **README.md** - Complete documentation with Docker Hub references
- [x] **CHANGELOG.md** - v1.0.0 dated 2025-11-06
- [x] **test.sh** - Comprehensive test suite
- [x] **.gitignore** - Proper exclusions
- [x] **.github/workflows/test.yml** - CI/CD for testing and edge builds
- [x] **.github/workflows/publish.yml** - Automated publishing on version tags

### 🔧 Required Setup

Before creating the v1.0.0 release, ensure these GitHub repository secrets are configured:

1. Go to: Repository Settings → Secrets and variables → Actions
2. Add the following secrets:
   - `DOCKERHUB_USERNAME` = `avmcodes`
   - `DOCKERHUB_TOKEN` = Your Docker Hub access token

**Creating a Docker Hub Access Token:**
1. Log in to Docker Hub (https://hub.docker.com)
2. Go to Account Settings → Security → New Access Token
3. Name it (e.g., "github-actions-avm-sandbox")
4. Copy the token and add it as `DOCKERHUB_TOKEN` secret

### 📦 Release Contents

**Version:** 1.0.0
**Release Date:** 2025-11-06
**Docker Image:** `avmcodes/avm-default-sandbox`

#### Included Software

**Base System:**
- Ubuntu 22.04 LTS

**Languages & Runtimes:**
- Node.js v24.11
- Bun (latest stable)
- Python 3.11
- Go 1.22.0
- TypeScript (global)

**Package Managers:**
- npm (with Node.js)
- pnpm (global)
- pip (Python)

**Pre-installed Python Packages:**
- numpy, pandas, scipy, matplotlib, scikit-learn
- jupyter, jupyterlab, seaborn, plotly
- requests, beautifulsoup4, lxml

**System Tools:**
- ffmpeg, git, curl, wget, unzip, build-essential

**Platform Support:**
- linux/amd64
- linux/arm64

## Release Process

### Step 1: Verify Everything is Committed

```bash
git status
git add .
git commit -m "Prepare for v1.0.0 release"
git push origin main
```

### Step 2: Create and Push the Tag

```bash
# Create annotated tag
git tag -a v1.0.0 -m "Release v1.0.0 - Initial stable release"

# Push the tag to trigger the publish workflow
git push origin v1.0.0
```

### Step 3: Monitor GitHub Actions

1. Go to: https://github.com/avmcodes/avm-default-sandbox/actions
2. Watch the "Publish Docker Image" workflow
3. The workflow will:
   - Run the complete test suite
   - Build multi-platform images (amd64 + arm64)
   - Push to Docker Hub with tags: `v1.0.0`, `v1`, `latest`
   - Create a GitHub Release with changelog

### Step 4: Verify the Release

**Check Docker Hub:**
```bash
# Pull and test the published image
docker pull avmcodes/avm-default-sandbox:v1.0.0
docker pull avmcodes/avm-default-sandbox:latest

# Verify it runs
docker run -d --name test-sandbox avmcodes/avm-default-sandbox:v1.0.0
docker exec test-sandbox node --version
docker exec test-sandbox bun --version
docker exec test-sandbox python3 --version
docker exec test-sandbox go version
docker stop test-sandbox
docker rm test-sandbox
```

**Check GitHub Release:**
- Visit: https://github.com/avmcodes/avm-default-sandbox/releases
- Verify v1.0.0 release is created with changelog

**Check Docker Hub Page:**
- Visit: https://hub.docker.com/r/avmcodes/avm-default-sandbox
- Verify tags are visible: `v1.0.0`, `v1`, `latest`

## Post-Release

### Update for Next Development Cycle

After v1.0.0 is released, update CHANGELOG.md to prepare for future changes:

```markdown
## [Unreleased]

### Added

### Changed

### Fixed

## [1.0.0] - 2025-11-06
...
```

## Rollback (If Needed)

If something goes wrong with the release:

1. Delete the tag locally and remotely:
   ```bash
   git tag -d v1.0.0
   git push origin :refs/tags/v1.0.0
   ```

2. Delete the GitHub Release from the web interface

3. Delete the Docker Hub tags (if needed) from Docker Hub web interface

4. Fix issues and re-release

## Available Image Tags After Release

- `avmcodes/avm-default-sandbox:latest` - Always points to latest stable
- `avmcodes/avm-default-sandbox:v1` - Major version 1
- `avmcodes/avm-default-sandbox:v1.0.0` - Exact version
- `avmcodes/avm-default-sandbox:edge` - Latest development (from main branch)
- `avmcodes/avm-default-sandbox:sha-<commit>` - Specific commit builds

## Testing the Release

After publishing, users can test with:

```bash
# Quick start
docker pull avmcodes/avm-default-sandbox:v1.0.0
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:v1.0.0

# Test all runtimes
docker exec avm-sandbox node --version      # v24.x.x
docker exec avm-sandbox bun --version       # latest
docker exec avm-sandbox python3 --version   # 3.11.x
docker exec avm-sandbox go version          # go1.22.0
docker exec avm-sandbox tsc --version       # latest
docker exec avm-sandbox pnpm --version      # latest

# Cleanup
docker stop avm-sandbox && docker rm avm-sandbox
```

## Support & Documentation

- **Documentation:** README.md
- **Changelog:** CHANGELOG.md
- **Issues:** https://github.com/avmcodes/avm-default-sandbox/issues
- **Docker Hub:** https://hub.docker.com/r/avmcodes/avm-default-sandbox
