#!/bin/bash

# Test suite for avm-default-sandbox Docker image
# Tests all installed languages, runtimes, and tools

set -e  # Exit on first error

FAILED_TESTS=0
PASSED_TESTS=0

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "AVM Default Sandbox - Test Suite"
echo "=========================================="
echo ""

# Helper functions
pass_test() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED_TESTS++))
}

fail_test() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED_TESTS++))
}

test_command_exists() {
    if command -v "$1" &> /dev/null; then
        pass_test "$1 is installed"
        return 0
    else
        fail_test "$1 is not installed"
        return 1
    fi
}

# Test Node.js
echo "Testing Node.js..."
if test_command_exists node; then
    NODE_VERSION=$(node --version)
    echo "  Version: $NODE_VERSION"

    # Test running JavaScript
    if node -e "console.log('Hello from Node.js')" &> /dev/null; then
        pass_test "Node.js can execute JavaScript"
    else
        fail_test "Node.js cannot execute JavaScript"
    fi
fi

test_command_exists npm
echo ""

# Test Bun
echo "Testing Bun..."
if test_command_exists bun; then
    BUN_VERSION=$(bun --version)
    echo "  Version: $BUN_VERSION"

    # Test running JavaScript with Bun
    if bun -e "console.log('Hello from Bun')" &> /dev/null; then
        pass_test "Bun can execute JavaScript"
    else
        fail_test "Bun cannot execute JavaScript"
    fi
fi
echo ""

# Test pnpm
echo "Testing pnpm..."
if test_command_exists pnpm; then
    PNPM_VERSION=$(pnpm --version)
    echo "  Version: $PNPM_VERSION"
fi
echo ""

# Test Python
echo "Testing Python..."
if test_command_exists python3; then
    PYTHON_VERSION=$(python3 --version)
    echo "  Version: $PYTHON_VERSION"

    # Check if Python 3.11
    if python3 --version | grep -q "3.11"; then
        pass_test "Python 3.11 is installed"
    else
        fail_test "Python version is not 3.11"
    fi

    # Test running Python
    if python3 -c "print('Hello from Python')" &> /dev/null; then
        pass_test "Python can execute code"
    else
        fail_test "Python cannot execute code"
    fi
fi

test_command_exists pip3
echo ""

# Test Python packages
echo "Testing Python packages..."
PYTHON_PACKAGES=("numpy" "pandas" "scipy" "matplotlib" "sklearn" "jupyter" "seaborn" "plotly" "requests" "bs4")

for package in "${PYTHON_PACKAGES[@]}"; do
    if python3 -c "import $package" &> /dev/null; then
        pass_test "Python package '$package' is importable"
    else
        fail_test "Python package '$package' is not importable"
    fi
done
echo ""

# Test Go
echo "Testing Go..."
if test_command_exists go; then
    GO_VERSION=$(go version)
    echo "  Version: $GO_VERSION"

    # Test Go compilation
    mkdir -p /tmp/go-test
    cat > /tmp/go-test/hello.go << 'EOF'
package main
import "fmt"
func main() {
    fmt.Println("Hello from Go")
}
EOF

    if cd /tmp/go-test && go run hello.go &> /dev/null; then
        pass_test "Go can compile and run programs"
    else
        fail_test "Go cannot compile and run programs"
    fi
    rm -rf /tmp/go-test
fi
echo ""

# Test TypeScript
echo "Testing TypeScript..."
if test_command_exists tsc; then
    TSC_VERSION=$(tsc --version)
    echo "  Version: $TSC_VERSION"

    # Test TypeScript compilation
    mkdir -p /tmp/ts-test
    cat > /tmp/ts-test/hello.ts << 'EOF'
const greeting: string = "Hello from TypeScript";
console.log(greeting);
EOF

    if cd /tmp/ts-test && tsc hello.ts &> /dev/null; then
        pass_test "TypeScript can compile .ts files"

        # Test running compiled JS
        if node hello.js &> /dev/null; then
            pass_test "Compiled TypeScript runs successfully"
        else
            fail_test "Compiled TypeScript does not run"
        fi
    else
        fail_test "TypeScript cannot compile .ts files"
    fi
    rm -rf /tmp/ts-test
fi
echo ""

# Test ffmpeg
echo "Testing ffmpeg..."
if test_command_exists ffmpeg; then
    FFMPEG_VERSION=$(ffmpeg -version | head -n1)
    echo "  Version: $FFMPEG_VERSION"

    # Test basic ffmpeg command
    if ffmpeg -version &> /dev/null; then
        pass_test "ffmpeg responds to version command"
    else
        fail_test "ffmpeg does not respond correctly"
    fi
fi
echo ""

# Test additional system tools
echo "Testing system tools..."
test_command_exists git
test_command_exists curl
test_command_exists wget
test_command_exists gcc
test_command_exists g++
test_command_exists make
echo ""

# Test environment
echo "Testing environment..."
# Test GOPATH
if [ -n "$GOPATH" ]; then
    pass_test "GOPATH is set ($GOPATH)"
else
    fail_test "GOPATH is not set"
fi
echo ""

# Summary
echo "=========================================="
echo "Test Results Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed!${NC}"
    exit 1
fi
