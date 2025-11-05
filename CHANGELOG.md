# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Updated Node.js from v20 to v24.11

### Added
- Bun runtime (latest stable)
- pnpm package manager
- Multi-platform support (linux/amd64, linux/arm64)
- Automated Docker image publishing to GitHub Container Registry
- Comprehensive test suite with validation for all installed components

## [1.0.0] - TBD

### Added
- Ubuntu 22.04 LTS base image
- Node.js v24.11
- Bun runtime
- Python 3.11 with pip
- Go 1.22.0
- TypeScript (via npm)
- pnpm package manager
- Python data analysis packages:
  - numpy
  - pandas
  - scipy
  - matplotlib
  - scikit-learn
  - jupyter
  - jupyterlab
  - seaborn
  - plotly
  - requests
  - beautifulsoup4
  - lxml
- ffmpeg
- System tools: git, curl, wget, build-essential
- Automated testing via GitHub Actions
- Multi-platform builds (amd64, arm64)

### Technical
- Container runs indefinitely via `tail -f /dev/null`
- Working directory: `/workspace`
- GOPATH configured for Go development
- All runtimes accessible via exec commands
