# AVM Default Sandbox

[![Build and Test](https://github.com/avmcodes/avm-default-sandbox/workflows/Build%20and%20Test/badge.svg)](https://github.com/avmcodes/avm-default-sandbox/actions)
[![Docker Image](https://img.shields.io/docker/pulls/avmcodes/avm-default-sandbox)](https://hub.docker.com/r/avmcodes/avm-default-sandbox)

The official reference Docker image for the **AVM.codes AI Agents Sandbox Platform**. This multi-language base image provides a secure, pre-configured environment for running AI agents with support for multiple programming languages and popular data science tools.

## Quick Start

Pull and run the latest stable image:

```bash
docker pull avmcodes/avm-default-sandbox:latest
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:latest
```

Execute commands in the running container:

```bash
# Python
docker exec avm-sandbox python3 -c "print('Hello from Python')"

# Node.js
docker exec avm-sandbox node -e "console.log('Hello from Node.js')"

# Interactive shell
docker exec -it avm-sandbox /bin/bash
```

## What's Included

### Programming Languages & Runtimes

- **Node.js** v24.11
- **Bun** (latest stable)
- **Python** 3.11
- **Go** 1.22.0
- **TypeScript** (installed globally)

### Package Managers

- **npm** (included with Node.js)
- **pnpm** (fast, disk-efficient package manager)
- **pip** (Python package installer)

### Python Data Science Stack

Pre-installed packages for data analysis and machine learning:
- numpy, pandas, scipy
- matplotlib, seaborn, plotly
- scikit-learn
- jupyter, jupyterlab
- requests, beautifulsoup4, lxml

### System Tools

- **ffmpeg** - Multimedia processing
- **git** - Version control
- **curl/wget** - HTTP utilities
- **build-essential** - C/C++ compilation tools (gcc, g++, make)
- **unzip** - Archive extraction

### Base System

- **Ubuntu 22.04 LTS**
- **Working Directory**: `/workspace`
- **Multi-platform**: linux/amd64, linux/arm64

## Available Tags

- `latest` - Latest stable release
- `v1`, `v1.0`, `v1.0.0` - Specific version tags
- `edge` - Latest development build (unstable)

## Usage Examples

### Running the Container

```bash
# Start container in detached mode
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:latest

# Use a specific version
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:v1.0.0
```

### Executing Commands

```bash
# Check versions
docker exec avm-sandbox node --version
docker exec avm-sandbox python3 --version
docker exec avm-sandbox go version
docker exec avm-sandbox bun --version

# Run Python script
docker exec avm-sandbox python3 -c "import pandas; print(pandas.__version__)"

# Run Node.js code
docker exec avm-sandbox node -e "console.log(process.version)"

# Use pnpm
docker exec avm-sandbox pnpm --version
```

### Interactive Development

```bash
# Get a bash shell
docker exec -it avm-sandbox /bin/bash

# Run Python interpreter
docker exec -it avm-sandbox python3

# Run Node.js REPL
docker exec -it avm-sandbox node
```

### With Mounted Volumes

```bash
# Mount your code directory
docker run -d --name avm-sandbox \
  -v $(pwd):/workspace/code \
  avmcodes/avm-default-sandbox:latest

# Execute your code
docker exec avm-sandbox python3 /workspace/code/script.py
```

## Container Characteristics

This image is designed for the AVM execution environment with the following characteristics:

- **Runs indefinitely**: Uses `tail -f /dev/null` as entrypoint for exec-based control
- **Root user**: Default user is root (suitable for sandboxed environments)
- **Stateless**: No persistent data by default (use volumes for persistence)
- **Multi-platform**: Works on both Intel/AMD64 and ARM64 architectures

## Environment Variables

- `GOPATH`: `/root/go`
- `PATH`: Includes Node.js, Bun, Go, and npm global binaries

## Platform & Registry

- **Docker Hub**: `avmcodes/avm-default-sandbox`
- **Platform**: [AVM.codes](https://avm.codes) - AI Agents Sandbox Platform
- **Source**: [GitHub](https://github.com/avmcodes/avm-default-sandbox)
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

## License

This project is the official reference image for the AVM (Agents Virtual Machine) platform.
