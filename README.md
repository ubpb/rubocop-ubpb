# rubocop-ubpb

Default [RuboCop](https://rubocop.org) configuration for projects at UB Paderborn.

## Configurations

| File        | Use for                                   | Plugins                                  |
|-------------|-------------------------------------------|------------------------------------------|
| `ruby.yml`  | Plain Ruby projects: gems, scripts, CLIs  | rubocop-performance, rubocop-minitest    |
| `rails.yml` | Rails apps. Builds on `ruby.yml`.         | adds rubocop-rails                       |

Use `ruby.yml` for everything that is not a Rails app. The Rails cops assume
Rails: they flag `puts` and `exit` in `lib/` and suggest Active Support methods
such as `blank?`, which do not exist without Active Support.

## Usage

### Plain Ruby projects

```ruby
# Gemfile
group :development do
  gem "rubocop-ubpb", github: "ubpb/rubocop-ubpb", require: false
end
```

```yaml
# .rubocop.yml
inherit_gem:
  rubocop-ubpb: ruby.yml
```

### Rails projects

`rubocop-rails` is not a dependency of this gem. Add it to the app:

```ruby
# Gemfile
group :development do
  gem "rubocop-rails", require: false
  gem "rubocop-ubpb", github: "ubpb/rubocop-ubpb", require: false
end
```

```yaml
# .rubocop.yml
inherit_gem:
  rubocop-ubpb: rails.yml
```

If the gem is loaded by Rails (no `require: false`), `bin/rails rubocop-ubpb:install`
writes this `.rubocop.yml` and adds `rubocop-rails` to the Gemfile.

### Project-specific settings

Add them below `inherit_gem`. To add excludes without replacing the inherited
ones, merge them:

```yaml
inherit_mode:
  merge:
    - Exclude

AllCops:
  Exclude:
    - "vendor/**/*"
```

## What the configuration does

- RuboCop's defaults, with these changes: Metrics cops off, double quotes
  (also inside interpolation), no spaces inside hash braces, brackets for
  word and symbol arrays, `end` aligned with the assigned variable, no
  documentation comments and no frozen string literal comment required.
  See `ruby.yml` for the full list.
- `NewCops: enable`: cops added by a RuboCop upgrade are on. Projects pick up
  upgrades through their `Gemfile.lock`, so a dependency update shows the new
  offenses before it is merged.

## Upgrading from 1.x

1. Replace `rubocop-ubpb: rubocop.yml` with `rails.yml` (Rails apps) or
   `ruby.yml` (everything else).
2. Rails apps: add `gem "rubocop-rails", require: false` to the Gemfile.
3. Run `bundle update rubocop-ubpb rubocop rubocop-performance rubocop-minitest rubocop-rails`.
4. Expect new offenses. Version 1.x left about 200 newer cops in `pending` state,
   which means off. Run `bundle exec rubocop -a` for the safe autocorrections and
   review the rest.

## Development

```sh
bundle exec rake
```

runs the tests and lints this repository. The tests run RuboCop against small
fixture projects that inherit `ruby.yml` or `rails.yml` through `inherit_gem`,
the same way consuming projects do.
