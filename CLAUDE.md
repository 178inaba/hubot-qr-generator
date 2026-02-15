# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

hubot-qr-generator is a Hubot script plugin that generates QR code image URLs using the [QR Code Generator API](https://goqr.me/api/doc/create-qr-code/). Users send `hubot qr gen <data>` and receive a QR code URL.

## Commands

```bash
# Install dependencies
npm install

# Run tests
npm test          # or: grunt test
grunt test:watch  # Watch mode

# Bootstrap development environment
script/bootstrap
```

## Architecture

- **Language**: CoffeeScript
- **Test framework**: Mocha + Chai + hubot-test-helper
- **Task runner**: Grunt (grunt-mocha-test)

### Key Files

- `src/qr-generator.coffee` - Main script. Listens for `qr gen <data>`, builds QR API URL, applies adapter-specific hacks (e.g., HipChat `.png` hash fragment)
- `index.coffee` - Hubot script loader entry point. Loads all scripts from `src/`
- `test/qr-generator-test.coffee` - Tests covering URL generation, URL encoding, adapter hacks, and 900-char limit

### Design Notes

- Data over 900 characters is rejected with an error message
- HipChat adapters get `#.png` appended to the URL for image rendering
- The `adapterHack` function modifies URL objects based on `robot.adapterName`
