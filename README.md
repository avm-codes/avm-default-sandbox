# AVM Default Sandbox

[![Build and Test](https://github.com/avmcodes/avm-default-sandbox/workflows/Build%20and%20Test/badge.svg)](https://github.com/avmcodes/avm-default-sandbox/actions)
[![Docker Image](https://img.shields.io/docker/pulls/avmcodes/avm-default-sandbox)](https://hub.docker.com/r/avmcodes/avm-default-sandbox)

A multi-language base Docker container image designed for the AVM (Agents Virtual Machine) secure sandbox execution environment.

## Quick Start

Pull and run the latest stable image:

```bash
docker pull avmcodes/avm-default-sandbox:latest
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:latest
```

Or try the latest development version:

```bash
docker pull avmcodes/avm-default-sandbox:edge
```

## Overview

This Docker image provides a comprehensive development environment with multiple programming languages and tools commonly used for AI agent tasks, data analysis, and general software development.

### Available Image Tags

- `latest` - Latest stable release
- `v1`, `v1.0`, `v1.0.0` - Specific version tags (for pinning)
- `edge` - Latest development build from main branch (unstable)
- `sha-<commit>` - Specific commit builds

## Included Software

### Operating System

- **Ubuntu 22.04 LTS**

### Programming Languages & Runtimes

- **Node.js**: v24.11
- **Bun**: Latest stable
- **Python**: 3.11
- **Go**: 1.22.0
- **TypeScript**: Latest (installed globally via npm)

### Python Packages

Pre-installed data analysis and scientific computing packages:

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

### Additional Tools

- **pnpm**: Fast, disk space efficient package manager
- **ffmpeg**: For multimedia processing
- **git**: Version control
- **curl/wget**: HTTP utilities
- **build-essential**: Compilation tools (gcc, g++, make)

## Building the Image

Pre-built images are available from Docker Hub (recommended). To build locally:

```bash
docker build -t avm-default-sandbox .
```

### Build with Custom Go Version

```bash
docker build --build-arg GO_VERSION=1.21.5 -t avm-default-sandbox .
```

### Multi-Platform Build

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t avm-default-sandbox .
```

## Usage

This image is designed to be used with the AVM execution environment, which controls the container via direct exec commands. The container runs indefinitely with a `tail -f /dev/null` entrypoint.

### Using Pre-Built Images

Run the latest stable version from Docker Hub:

```bash
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:latest
```

Or use a specific version:

```bash
docker run -d --name avm-sandbox avmcodes/avm-default-sandbox:v1.0.0
```

### Running Locally Built Image

```bash
docker run -d --name avm-sandbox avm-default-sandbox
```

### Executing Commands

```bash
# Python
docker exec avm-sandbox python3 -c "print('Hello from Python')"

# Node.js
docker exec avm-sandbox node -e "console.log('Hello from Node.js')"

# Bun
docker exec avm-sandbox bun --version

# Go
docker exec avm-sandbox go version

# TypeScript
docker exec avm-sandbox tsc --version

# pnpm
docker exec avm-sandbox pnpm --version
```

### Interactive Shell

```bash
docker exec -it avm-sandbox /bin/bash
```

## Environment Variables

- `GOPATH`: `/root/go`
- `PATH`: Includes Go binaries and GOPATH bin directories
- `DEBIAN_FRONTEND`: Reset to default after build

## Container Characteristics

- **Working Directory**: `/workspace`
- **User**: root (can be modified for your use case)
- **Entrypoint**: Runs indefinitely for exec-based control

## Version Information

To check installed versions:

```bash
docker exec avm-sandbox node --version
docker exec avm-sandbox bun --version
docker exec avm-sandbox pnpm --version
docker exec avm-sandbox python3 --version
docker exec avm-sandbox go version
docker exec avm-sandbox tsc --version
docker exec avm-sandbox ffmpeg -version
```

## Testing

This repository includes a comprehensive test suite to validate all installed components.

### Running Tests Locally

Build the image and run the test suite by mounting the test script:

```bash
docker build -t avm-default-sandbox .
docker run --rm -v $(pwd)/test.sh:/test.sh avm-default-sandbox bash /test.sh
```

Or copy the test script into a running container:

```bash
docker run -d --name avm-sandbox avm-default-sandbox
docker cp test.sh avm-sandbox:/test.sh
docker exec avm-sandbox bash /test.sh
docker stop avm-sandbox
```

### Test Coverage

The test suite (`test.sh`) validates:

- **Node.js**: Installation, version, and JavaScript execution
- **Bun**: Installation, version, and JavaScript execution
- **pnpm**: Installation and version
- **Python**: 3.11 installation, version, and code execution
- **Python packages**: Import tests for numpy, pandas, scipy, matplotlib, scikit-learn, jupyter, seaborn, plotly, requests, bs4
- **Go**: Installation, version, and compilation/execution of Go programs
- **TypeScript**: Installation, version, and compilation of .ts files
- **ffmpeg**: Installation and basic functionality
- **System tools**: git, curl, wget, gcc, g++, make
- **Environment**: GOPATH configuration

### CI/CD

GitHub Actions automatically runs the test suite on every push and pull request. The workflow:

1. Builds the Docker image
2. Mounts and runs the test suite inside the container
3. Validates that the container stays running (for exec-based control)
4. Tests exec commands for all languages
5. Reports image size

The test script is kept separate from the image and mounted at runtime to keep the production image clean.

See `.github/workflows/test.yml` for the full workflow configuration.

## Versioning and Releases

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** version for incompatible changes (e.g., removing languages, Ubuntu version upgrade)
- **MINOR** version for new features (e.g., adding new languages or tools)
- **PATCH** version for bug fixes and package updates

### Creating a Release

To publish a new version:

1. Update `CHANGELOG.md` with the new version and changes
2. Create and push a git tag:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```
3. GitHub Actions will automatically:
   - Run the test suite
   - Build multi-platform images (amd64, arm64)
   - Push to Docker Hub with version tags
   - Create a GitHub Release with changelog

### Image Registry

All images are published to Docker Hub:
- Registry: `avmcodes/avm-default-sandbox`
- Public access (no authentication required for pulling)
- Multi-platform support (linux/amd64, linux/arm64)

See [CHANGELOG.md](CHANGELOG.md) for version history.

## License

This project is designed for use with AVM (Agents Virtual Machine).

## Contributing

This is a base sandbox image. Modifications should maintain compatibility with the AVM execution environment and focus on broadly useful languages and tools.
