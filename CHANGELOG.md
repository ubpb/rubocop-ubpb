# Changelog

## 2.0.0 (2026-10-10)

### Breaking changes

- `rubocop.yml` is removed. Use `rails.yml` for Rails apps and `ruby.yml` for
  plain Ruby projects.
- `rubocop-rails` is no longer a dependency. Rails apps add it to their Gemfile.
- `NewCops: enable`. About 200 cops that were `pending` (off) in 1.x are now on.
- Requires Ruby >= 3.4, RuboCop >= 1.72.1 and < 2, rubocop-performance >= 1.24
  and rubocop-minitest >= 0.37.

### Changes

- Extensions are loaded with `plugins:` instead of the deprecated `require:`.
- Removed `DisabledByDefault: true` and the department-wide `Enabled: true`
  entries. Together they resulted in RuboCop's defaults anyway, so the
  configuration now states this directly.
- `Style/StringLiteralsInInterpolation` uses double quotes, like
  `Style/StringLiterals`.
- `Style/WordArray` uses brackets, like `Style/SymbolArray`.
- Minitest cops use rubocop-minitest's default file patterns
  (`**/test/**/*`, `**/*_test.rb`) instead of `test/**/*`.
- `public/` and `storage/` are no longer excluded in `ruby.yml`. rubocop-rails
  excludes them for Rails apps.
- The Rails installer writes `rails.yml` and adds `rubocop-rails` to the Gemfile.

### Added

- Tests that run RuboCop against fixture projects for both configurations.
- GitHub Actions CI and Dependabot.
- README with usage and upgrade notes.

## 1.1

- Initial configuration.
