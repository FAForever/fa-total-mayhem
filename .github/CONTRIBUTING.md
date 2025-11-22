# Contributing to Total Mayhem

Thank you for your interest in contributing to Total Mayhem! This document provides guidelines and instructions for contributing to this Supreme Commander: Forged Alliance mod.

## Table of Contents

- [Getting Started](#getting-started)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Guidelines](#coding-guidelines)
- [Submission Guidelines](#submission-guidelines)
- [Community and Support](#community-and-support)

## Getting Started

Total Mayhem is a community-maintained mod for Supreme Commander: Forged Alliance Forever. Before contributing, please:

1. Read the [README.md](README.md) to understand the project
2. Check existing [issues](https://github.com/FAForever/fa-total-mayhem/issues) and [pull requests](https://github.com/FAForever/fa-total-mayhem/pulls)
3. Join our [Discord server](https://discord.gg/mqJmjQgUUk) for discussions and support
4. Visit the [Modification Resources channel](https://discord.gg/eQZRwhAP) for modding resources

## How Can I Contribute?

### Reporting Bugs

If you find a bug, please [create an issue](https://github.com/FAForever/fa-total-mayhem/issues/new) with:

- **Clear title**: Brief description of the issue
- **Description**: Detailed explanation of what went wrong
- **Steps to reproduce**: How to trigger the bug
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Game version**: Your FAF version and mod version
- **Additional context**: Screenshots, logs, or other relevant information

### Suggesting Features

For feature suggestions:

- Check if the feature has already been suggested
- Create a detailed issue explaining the feature and its benefits
- Be open to discussion and feedback from maintainers

### Bug Fixes

We welcome pull requests that fix bugs! Please:

1. Reference the issue number in your PR
2. Provide a clear description of the fix
3. Test your changes thoroughly before submitting

### Balance Changes

**Important**: We do **not** accept balance changes via pull requests to this repository.

If you want to adjust balance:
- Create a separate balance mod using [blueprint merging](https://github.com/The-Balthazar/SupCom-Mod-Tutorials/wiki/102-%E2%80%94-Blueprint-merge)
- Share your balance mod with the community
- Discuss balance ideas in the Discord server

### Documentation

Help improve documentation by:

- Fixing typos or unclear instructions
- Adding missing documentation
- Improving code comments
- Creating tutorials or guides

## Development Setup

### Prerequisites

- [FAForever client](https://www.faforever.com/)
- Supreme Commander: Forged Alliance
- Git
- Text editor or IDE (VS Code recommended with [FA Lua extension](https://github.com/FAForever/fa-lua-vscode-extension))
- Node.js and npm (for code formatting)

### Setting Up Your Development Environment

1. **Fork the repository** on GitHub

2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/fa-total-mayhem.git
   cd fa-total-mayhem
   ```

3. **Add the upstream repository**:
   ```bash
   git remote add upstream https://github.com/FAForever/fa-total-mayhem.git
   ```

4. **Install dependencies** (for code formatting):
   ```bash
   npm install
   ```

5. **Create a symbolic link** to your local mod folder in your FAF mods directory:
   - FAF mods directory is typically at: `C:\ProgramData\FAForever\user\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods`
   - Create a junction/symlink from your cloned repository to the mods folder

### Testing Your Changes

1. Enable the mod in the FAF client
2. Create a custom game or skirmish
3. Test the specific changes you made
4. Verify no errors appear in the game log
5. Check that the game remains stable

## Coding Guidelines

### Lua Style Guide

- **Indentation**: Use 4 spaces (not tabs)
- **Naming conventions**:
  - Variables: `camelCase` or `PascalCase` (follow existing patterns in the file)
  - Functions: `PascalCase` for global functions, `camelCase` for local functions
  - Constants: `UPPER_CASE_WITH_UNDERSCORES`
- **Comments**: Add comments for complex logic
- **File structure**: Follow the existing mod structure

### Code Formatting

Before submitting, format your code:

```bash
npm run format
```

This will automatically format `.lua` and `.bp` files using Prettier.

### File Organization

```
fa-total-mayhem/
├── lua/              # Lua scripts (weapons, effects, custom units, AI)
├── projectiles/      # Projectile definitions
├── units/            # Unit blueprints
├── effects/          # Effect definitions
├── sounds/           # Sound files
├── textures/         # Texture files
├── icons/            # Unit icons
└── hook/             # Hook files for modifying base game
```

### Best Practices

1. **Keep changes focused**: One feature/fix per pull request
2. **Don't break existing functionality**: Test thoroughly
3. **Follow existing patterns**: Match the style of surrounding code
4. **Comment complex logic**: Help future contributors understand your code
5. **Avoid unnecessary changes**: Don't reformat entire files unless necessary

## Submission Guidelines

### Creating a Pull Request

1. **Create a feature branch**:
   ```bash
   git checkout -b fix/issue-123-description
   # or
   git checkout -b feature/description
   ```

2. **Make your changes** following the coding guidelines

3. **Commit your changes** with clear commit messages:
   ```bash
   git add .
   git commit -m "Fix: Description of what was fixed"
   ```

   Commit message format:
   - `Fix: ...` for bug fixes
   - `Add: ...` for new features
   - `Update: ...` for updates to existing features
   - `Docs: ...` for documentation changes
   - `Refactor: ...` for code refactoring

4. **Push to your fork**:
   ```bash
   git push origin your-branch-name
   ```

5. **Open a Pull Request** on GitHub:
   - Use a clear, descriptive title
   - Reference any related issues (e.g., "Fixes #123")
   - Describe what changes you made and why
   - List how you tested the changes

### Pull Request Checklist

Before submitting, ensure:

- [ ] Code follows the style guidelines
- [ ] Changes have been tested in-game
- [ ] No new errors or warnings in game logs
- [ ] Code has been formatted with `npm run format`
- [ ] Commit messages are clear and descriptive
- [ ] PR description explains the changes
- [ ] Related issues are referenced

### Review Process

1. Maintainers will review your PR
2. You may be asked to make changes
3. Once approved, a maintainer will merge your PR
4. Your contribution will be included in the next release!

## Community and Support

### Resources

- **Discord**: [Join our Discord](https://discord.gg/mqJmjQgUUk) for discussions
- **Forums**: [FAForever Forums](https://forum.faforever.com/category/11/modding-tools)
- **Modding Tutorials**: [SupCom Mod Tutorials](https://github.com/The-Balthazar/SupCom-Mod-Tutorials/wiki)
- **Lua Extension**: [FA Lua VSCode Extension](https://github.com/FAForever/fa-lua-vscode-extension)
- **Language Server**: [FA Lua Language Server](https://github.com/FAForever/fa-lua-language-server)

### Getting Help

If you need help:

1. Check the [modding tutorials](https://github.com/The-Balthazar/SupCom-Mod-Tutorials/wiki)
2. Ask in the Discord [Modification Resources channel](https://discord.gg/eQZRwhAP)
3. Search the [FAForever forums](https://forum.faforever.com/category/11/modding-tools)
4. Open a discussion on GitHub

### Code of Conduct

- Be respectful and constructive
- Help others learn and grow
- Focus on what's best for the community
- Accept constructive criticism gracefully

## Important Notes

### Redistribution

**Do not re-distribute the content of this repository in the FAForever vault.** This repository is the official source for the FAF-compatible version of Total Mayhem.

### License

By contributing, you agree that your contributions will be licensed under the MIT License (see [LICENSE](LICENSE) file).

### Credits

Total Mayhem was originally created by:
- **Burnie22** (author)
- **OrangeKnight** (models, textures)
- **Brandon** (models, textures)
- **adamstrange** (custom sounds)
- **Domino** (scripts)

All contributors to this repository will be acknowledged in the project.

---

Thank you for contributing to Total Mayhem! Your efforts help keep this mod alive and enjoyable for the community. 🎮
