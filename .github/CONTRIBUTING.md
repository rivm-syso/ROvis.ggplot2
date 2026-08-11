# Contributing to ROvis

Hey! 👋 Thank you for your interest in contributing to ROvis! We welcome all support and value your input.

## About ROvis

Before contributing, please remember that ROvis is designed specifically to implement **official Rijksoverheid (Dutch Government) design guidelines** for data visualization. The package's primary purpose is to ensure consistency in visualizations across Rijksoverheid organizations by providing tools for:

- Applying Rijksoverheid color palettes
- Styling plots and tables according to Rijksoverheid standards
- Supporting the Rijksoverheid visual identity

While the package was originally developed for RIVM (and was previously called DARAvis), it now serves the broader Rijksoverheid community. All contributions should align with this core mission and official Rijksoverheid design guidelines.

## How to contribute

### 1. Open an issue

**Before submitting any code changes**, please open an issue on the [GitHub issue board](TODO) to:

- Describe the bug you want to fix or the feature you want to add
- Explain why the change is needed
- Discuss your proposed approach
- Allow maintainers and other contributors to provide feedback

This applies to both major features and small fixes. Opening an issue first helps us:

- Avoid duplicate work
- Ensure the contribution aligns with Rijksoverheid design standards
- Discuss the best implementation approach
- Maintain focus on the package's core purpose

### 2. Wait for discussion

Give maintainers and other contributors time to respond to your issue. This discussion ensures that:

- The proposed change fits within the package's scope
- The implementation approach is appropriate
- There are no conflicts with planned changes
- The change adheres to Rijksoverheid design guidelines

### 3. Fork and create a branch

Once your issue has been discussed and approved:

1. Fork the repository
2. Create a feature branch from `main`
3. Name your branch descriptively (e.g., `fix-color-palette`, `add-new-theme`)

### 4. Make your changes

When coding:

- **Follow our code style**: we stick to the [Tidyverse style guide](https://style.tidyverse.org) and we use [air](https://posit-dev.github.io/air) for code formatting
- **Follow existing patterns**: look at similar functions in the code base to maintain consistency
- **Keep it simple**: avoid over-engineering and only add what's necessary for the task at hand
- **Build on existing functions**: don't duplicate logic and use/extend existing functions where possible
- Write clear, self-documenting code
- Add `roxygen2` documentation for new functions
- Include examples in your documentation
- Write tests for new functionality
- Update existing tests if modifying behavior
- Run `devtools::check()` to ensure your changes don't break anything

### 5. Test your changes

- Run the test suite: `devtools::test()`
- For theme changes, verify visual regression tests pass (with `vdiffr`)
- Test your changes with real-world examples
- Ensure your code works with R versions as mentioned in DESCRIPTION

### 6. Submit a pull request

- Push your branch to your fork
- Create a pull request targeting the `main` branch
- Reference the issue number in your pull request
- Provide a clear description of what your changes do
- Include examples or screenshots if applicable

## Code standards

- **Single source of truth**: all color definitions live in `color()`. Build on existing functions rather than duplicating logic.
- **Maintain Rijksoverheid standards**: Verify your changes against the style guidelines.
- **Version carefully**: Use version parameters for breaking changes; never replace existing behavior
- **Document clearly**: Users across Rijksoverheid organizations may not be R experts. Provide clear examples.
- **Test visually**: Use `vdiffr` for theme changes to catch visual regressions

## AI/LLM-Generated Contributions

We welcome contributions assisted by AI tools (ChatGPT, Claude, GitHub Copilot, etc.), but please keep the following in mind:

**You are responsible for your contributions.** Before submitting AI-generated code:

- **Understand the code completely.** Don't submit code you don't fully comprehend. You should be able to explain every line and decision.
- **Test thoroughly.** AI-generated code may contain subtle bugs, incorrect assumptions, or non-standard patterns. Run all tests and verify the code works as intended.
- **Review for package consistency.** AI tools may not be aware of our specific architecture patterns, dependency chains, or design philosophy. Ensure the code follows our standards.
- **Check for quality.** AI can generate verbose, over-engineered, or redundant code. Simplify and refine before submitting.

**Why this matters:** Reviewing AI-generated pull requests takes significant maintainer time, especially when contributors haven't verified the code themselves. Submitting untested or poorly understood code creates unnecessary burden on maintainers who must identify issues, explain problems, and request fixes.

We appreciate AI as a helpful tool, but the responsibility for code quality, correctness, and understanding remains with the contributor.

## What we're looking for

We particularly welcome contributions that:

- Fix bugs in existing functionality
- Improve documentation and examples
- Add support for new Rijksoverheid design guideline features
- Add themes for additional plotting libraries
- Add themes for additional table libraries
- Enhance error messages and user feedback
- Improve test coverage
- Extend functionality to serve other Rijksoverheid organizations

## What to avoid

Please avoid contributions that:

- Deviate from official Rijksoverheid design guidelines
- Add features unrelated to Rijksoverheid visualization standards
- Introduce breaking changes without discussion
- Duplicate existing functionality
- Add unnecessary dependencies

## Questions?

If you have questions about contributing:

- Open a discussion issue on [GitHub](TODO)
- Email the SPIN team: [spin@rivm.nl](mailto:spin@rivm.nl)
- Review existing code and documentation in the repository to understand patterns and conventions

## License

By contributing to ROvis, you agree that your contributions will be licensed under the [EUPL v.1.2](https://eupl.eu/1.2/en/) license.

---

Thank you for helping us maintain and improve ROvis!

