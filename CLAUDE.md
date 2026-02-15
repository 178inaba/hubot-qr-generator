# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

hubot-qr-generator is a Hubot script plugin that generates QR code image URLs using the [QR Code Generator API](https://goqr.me/api/doc/create-qr-code/). Users send `hubot qr gen <data>` and receive a QR code URL.

## Commands

```bash
# Install dependencies
npm install

# Run tests
npm test
```

## Architecture

- **Language**: JavaScript (ES Modules)
- **Runtime**: Node.js 18+
- **Test framework**: Mocha + Chai
- **Hubot**: v14 (peerDependencies: >=11)

### Key Files

- `src/qr-generator.js` - Main script. Listens for `qr gen <data>`, builds QR API URL
- `index.js` - Hubot script loader entry point. Loads all scripts from `src/`
- `test/qr-generator-test.js` - Tests covering URL generation, URL encoding, and 900-char limit
- `test/doubles/DummyAdapter.js` - Minimal Hubot adapter for testing (replaces hubot-test-helper)

### Design Notes

- Data over 900 characters is rejected with an error message
