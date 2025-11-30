#!/usr/bin/env bash

# Utility functions for husky hooks

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running in CI environment
is_ci() {
  [ -n "${CI:-}" ] || [ -n "${GITHUB_ACTIONS:-}" ] || [ -n "${GITLAB_CI:-}" ] || [ -n "${CIRCLECI:-}" ]
}

# Skip hook with a message
skip_hook() {
  local message="$1"
  echo -e "${YELLOW}⏭  Skipping hook: ${message}${NC}"
  exit 0
}

# Print header message
print_header() {
  local message="$1"
  echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${BLUE}  ${message}${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Print info message
print_info() {
  local message="$1"
  echo -e "${BLUE}ℹ  ${message}${NC}"
}

# Print success message
print_success() {
  local message="$1"
  echo -e "${GREEN}✓  ${message}${NC}"
}

# Print error message
print_error() {
  local message="$1"
  echo -e "${RED}✗  ${message}${NC}" >&2
}

# Start timer
start_timer() {
  HOOK_START_TIME=$(date +%s)
}

# End timer and print duration
end_timer() {
  local label="$1"
  if [ -n "${HOOK_START_TIME:-}" ]; then
    local end_time=$(date +%s)
    local duration=$((end_time - HOOK_START_TIME))
    echo -e "${BLUE}⏱  ${label} completed in ${duration}s${NC}\n"
  fi
}

# Exit with error message
exit_with_error() {
  local title="$1"
  local message="${2:-}"

  print_error "${title}"
  if [ -n "$message" ]; then
    echo -e "${RED}   ${message}${NC}"
  fi
  echo ""
  exit 1
}
