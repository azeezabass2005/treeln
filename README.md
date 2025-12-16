# treeln

A simple `tree`-like command line tool written in Rust.

## Installation

### Quick Install (Recommended)

#### Linux / macOS
```bash
curl -fsSL https://raw.githubusercontent.com/azeezabass2005/treeln/main/install.sh | bash
```

#### Windows (PowerShell - Run as Administrator)
```powershell
irm https://raw.githubusercontent.com/azeezabass2005/treeln/main/install.ps1 | iex
```

Or download a prebuilt binary from the releases page.

## Usage

```bash
treeln
treeln -d src
treeln -D 3
```

## Options

* `-d, --directory` Directory to print
* `-D, --depth` Max depth

## Example

```text
.
├── src
│   ├── args.rs
│   ├── main.rs
│   ├── validation.rs
│   └── walk_dir.rs
└── Cargo.toml
```
