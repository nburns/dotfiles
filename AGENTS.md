# Global Claude Code Guidelines

## Shell and Command-Line Safety

Always quote paths and variables in shell commands and Makefiles, even if they appear not to contain spaces (`"$var"`, not `$var`). Quote command substitutions too (`"$(cmd)"`, not `$(cmd)`). When piping `find` to `xargs`, always use null-terminated output to handle whitespace and special characters safely (`find ... -print0 | xargs -0 ...`). Use `"$@"` (not `$*`) when forwarding arguments to preserve argument boundaries. Use `--` to separate options from file arguments to guard against filenames starting with `-` (e.g. `rm -- "$f"`). Start bash scripts with `set -euo pipefail` to catch unset variables, failed commands, and pipeline failures. Apply the same discipline in Makefiles, CI scripts, and anywhere shell expansion occurs.

## Network Requests

Always check the HTTP status and raise/throw on failure — never silently swallow errors. Never return a value from a failed network call that could be mistaken for a successful empty or null response (e.g. returning `None`, `""`, `[]`, or `{}` on error). This is especially critical for expensive or stateful calls such as LLM API requests, where a silent failure wastes money and corrupts downstream logic. Prefer raising an exception or returning a typed error so the caller is forced to handle the failure explicitly.

This principle applies to regular method and function calls too: don't return a sentinel value (null, empty string, zero, empty collection) to signal failure when that same value could also be a valid successful result. Raise an exception or return a typed error/result type instead, so failures are always unambiguous to callers.

## Linting and Static Analysis

Use linters, type checkers, and static analysis tools wherever available (e.g. `mypy`/`pyright` for Python, `eslint`/`tsc` for JS/TS, `go vet`/`staticcheck` for Go, `shellcheck` for shell scripts). For languages not listed here, research the standard tooling or ask the user what they prefer before proceeding. Prefer catching errors statically over discovering them at runtime. When adding new code, ensure it passes existing linter/checker configuration without warnings.

## Fix Root Causes, Not Symptoms

When something is broken or awkward, fix the underlying cause rather than layering workarounds on top. A growing stack of compensating hacks is a signal that the core issue hasn't been addressed. Prefer a clean fix at the source over an increasingly complex series of patches that treat symptoms — the latter compounds complexity and makes the system harder to reason about over time.

## Return Values

Prefer returning a single meaningful value or a structure with named elements (object, dataclass, struct, hash, named tuple) over returning a plain tuple or positional array. Positional returns force callers to remember order and make destructuring fragile — named elements make the meaning self-evident at the call site. (See Rich Hickey's "Simple Made Easy": complecting multiple values into a positional sequence introduces incidental complexity.)

## Error Handling

Prefer raising/throwing exceptions when an error occurs rather than returning error codes, sentinel values, or success flags. Exceptions make failures impossible to silently ignore and keep the happy path uncluttered. Only return a result-style type (e.g. `Result`/`Either`) when errors are a routine, expected part of the API contract and callers must handle both cases explicitly — not as a general substitute for exceptions.

## Missing vs. Null vs. Empty

Treat missing, null/nil, and falsey empty values as distinct states — conflating them is a common source of subtle bugs. A missing key in a dict/map means the data was never provided; `null`/`nil` means it was explicitly set to nothing; an empty collection (`[]`, `{}`, `""`) means it was provided but contains no elements. Never use `if x:` or truthiness checks when you need to distinguish between these states — check explicitly (e.g. `x is None` vs `len(x) == 0` vs `x not in data`). Design APIs and data structures to preserve this distinction rather than collapsing it.

## Communicating Tradeoffs

When making a decision that involves meaningful tradeoffs — choosing between approaches, libraries, data structures, or architectural patterns — explain the tradeoffs clearly rather than just presenting a conclusion. Call out what is gained and what is sacrificed (performance, simplicity, flexibility, safety, etc.), and flag when a choice is context-dependent so the user can make an informed decision or redirect if their priorities differ.

## Generating Structured Data

When generating messages or payloads in a structured format (JSON, YAML, etc.), prefer building native data structures (e.g. dicts in Python, objects/maps in JS/TS, structs or maps in Go, hashes in Ruby) and serializing them, rather than constructing the output via string concatenation.

## Vendor and Provider Neutrality

Never suggest, prefer, or default to a specific vendor, service, or provider — for AI models, APIs, cloud platforms, databases, or any other external dependency — unless the user has already made that choice or the project is explicitly locked to one. Always leave the choice to the user. Do not name classes, variables, files, or modules after a specific vendor or product (e.g. avoid `ClaudeClient`, `StripeHelper`, `aws_service.py`) unless the code is specifically and exclusively for that provider and the user has named it that way themselves. Use generic, capability-describing names (e.g. `LLMClient`, `payment_service.py`, `storage_backend`) by default.
