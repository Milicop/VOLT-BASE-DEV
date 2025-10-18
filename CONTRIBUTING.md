# Contributing to Volt

Thank you for your interest in contributing to Volt! We welcome contributions from the community and are grateful for your support in making Volt better.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Community](#community)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for everyone. Be kind, professional, and constructive in all interactions.

## How Can I Contribute?

There are many ways to contribute to Volt:

- **Bug Reports**: Help us identify and fix issues
- **Feature Requests**: Suggest new features or improvements
- **Code Contributions**: Submit patches, bug fixes, or new features
- **Documentation**: Improve guides, tutorials, and documentation
- **Testing**: Test new releases and provide feedback
- **Design**: Contribute to UI/UX improvements
- **Package Maintenance**: Help maintain packages in the Ractor repository
- **Community Support**: Help other users on Discord or the forum

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Volt.git
   cd Volt
   ```
3. **Add the upstream repository**:
   ```bash
   git remote add upstream https://github.com/Milicop/Volt.git
   ```
4. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### System Requirements

- 64-bit x86_64 processor
- 4GB RAM (minimum 2GB)
- 20GB available storage
- OpenGL 3.0+ compatible GPU

### Setting Up Development Environment

1. **Install Volt** following the installation guide:
   ```bash
   curl -fsSL https://github.com/Milicop/VOLT-BASE-DEV/releases/download/voltinstall/install | bash
   ```

2. **Install development tools**:
   ```bash
   sudo pacman -S base-devel git
   ```

3. **Set up your development environment** according to the component you're working on:
   - **Desktop Environment**: Familiarity with C/C++ and GUI frameworks
   - **System Components**: Knowledge of Linux system administration
   - **Package Management**: Understanding of Pacman and AUR

## Contribution Guidelines

### Code Style

- Follow the existing code style in the project
- Use meaningful variable and function names
- Comment complex logic and algorithms
- Keep functions focused and modular

### Commit Messages

Write clear, descriptive commit messages:

```
[Component] Brief description of change

Detailed explanation of what changed and why. Include any
relevant context or issue numbers.

Fixes #123
```

Examples:
- `[Desktop] Add window tiling feature`
- `[Package] Update system dependencies`
- `[Docs] Improve installation guide clarity`

### Branch Naming

Use descriptive branch names:
- `feature/window-tiling`
- `bugfix/login-crash`
- `docs/installation-guide`
- `refactor/config-parser`

### Documentation

- Update relevant documentation for any changes
- Add comments to code where necessary
- Include usage examples for new features
- Update the README if adding major features

## Pull Request Process

1. **Update your fork** with the latest upstream changes:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Test your changes thoroughly**:
   - Ensure the system builds without errors
   - Test on a clean Volt installation if possible
   - Verify no regressions in existing functionality

3. **Push your changes**:
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request** on GitHub with:
   - Clear title describing the change
   - Detailed description of what changed and why
   - Reference to any related issues
   - Screenshots or videos for UI changes

5. **Respond to feedback**:
   - Address review comments promptly
   - Make requested changes in new commits
   - Keep the discussion focused and professional

6. **Squash commits** if requested before merge

### PR Checklist

Before submitting, ensure:
- [ ] Code follows the project's style guidelines
- [ ] All tests pass (if applicable)
- [ ] Documentation is updated
- [ ] Commit messages are clear and descriptive
- [ ] No merge conflicts with main branch
- [ ] PR description clearly explains the changes

## Reporting Bugs

### Before Submitting a Bug Report

- Check existing issues to avoid duplicates
- Test on the latest version of Volt
- Gather relevant system information

### How to Submit a Bug Report

Create an issue with the following information:

**Title**: Clear, concise description of the bug

**Description**:
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Steps to reproduce**: Detailed steps to trigger the bug
- **System information**:
  - Volt version
  - Desktop environment version
  - Hardware specifications (CPU, GPU, RAM)
  - Kernel version (`uname -r`)
- **Logs**: Relevant error messages or logs
- **Screenshots**: If applicable

## Suggesting Enhancements

We welcome ideas for new features! When suggesting enhancements:

1. **Check existing feature requests** to avoid duplicates
2. **Describe the feature** in detail
3. **Explain the use case**: Why is this feature needed?
4. **Provide examples**: How would users interact with it?
5. **Consider alternatives**: Are there other ways to achieve this?

## Component-Specific Guidelines

### Desktop Environment

- Follow GTK/Qt best practices if applicable
- Ensure accessibility features are maintained
- Test on multiple screen resolutions
- Consider performance impact

### System Components

- Maintain backward compatibility where possible
- Document any breaking changes
- Update configuration file examples
- Test on clean installations

### Package Management

- Follow Arch Linux packaging guidelines
- Test package installation and removal
- Verify dependencies are correct
- Update package metadata appropriately

## Community

Join our community to discuss contributions:

- **Discord**: [Join our server](https://discord.gg/6naeNfwEtY) for real-time chat
- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For general questions and discussions

## Additional Resources

- [Volt Documentation](#) - Comprehensive guides and tutorials
- [Arch Linux Wiki](https://wiki.archlinux.org/) - General Linux and Arch-specific information
- [Pacman Documentation](https://wiki.archlinux.org/title/Pacman) - Package management reference

## Recognition

Contributors will be recognized in:
- The project's README
- Release notes for significant contributions
- The Volt website (when available)

## Questions?

If you have questions about contributing, feel free to:
- Ask on Discord
- Open a discussion on GitHub
- Reach out to the maintainers

---

Thank you for contributing to Volt! Your efforts help make this distribution better for everyone.

**Built with ❤️ by the Volt community**
