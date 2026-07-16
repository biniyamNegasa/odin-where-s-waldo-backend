source "https://rubygems.org"

# API-only Rails backend for the Where's Waldo game
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 2.9"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Cross-origin requests from the frontend
gem "rack-cors", "~> 2.0"
# Rate limiting for the public API
gem "rack-attack", "~> 6.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "ruby-lsp"
  gem "rubocop-rails", require: false
end

group :test do
  # Rails 7.2's test runner is incompatible with minitest 6 (it calls
  # Runnable#run with an extra argument). Activesupport allows ">= 5.1".
  gem "minitest", "~> 5.25"
end
