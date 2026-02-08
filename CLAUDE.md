# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TudoBemMaman is a Ruby on Rails 7.0.4 e-commerce clothing store with Stripe payments, Devise authentication, Cloudinary image storage, and a session-based shopping cart. Ruby 3.1.2, PostgreSQL.

## Common Commands

### Development
```bash
bin/dev                    # Start dev server (Rails + Webpack watch via Foreman)
bin/rails server           # Rails server only
yarn build --watch         # Webpack watch only
```

### Database
```bash
rails db:create            # Create databases
rails db:migrate           # Run migrations
rails db:seed              # Seed with sample data (admin: toto@gmail.com / qwertz)
rails db:prepare           # Create + migrate
```

### Testing
```bash
rails test                 # Run all Minitest tests
rails test:system          # Run system tests (Capybara + Selenium)
rails test test/models/clothe_test.rb           # Run a single test file
rails test test/models/clothe_test.rb:10        # Run a single test by line number
```

### Linting
```bash
rubocop                    # Run RuboCop (config: .rubocop.yml, max line length 120)
rubocop -a                 # Auto-fix
```

### Assets
```bash
yarn build                 # One-time Webpack build
rails assets:precompile    # Precompile for production
```

## Architecture

### Models & Stripe Integration
- **User** — Devise auth, `admin` boolean flag, `stripe_customer_id`. A Stripe Customer is created via `after_create` callback.
- **Clothe** — Product with name, description, price (integer, cents), size, category, sales_count. A Stripe Product + Price are created via `after_create` callback. Price updates trigger a new Stripe Price via `after_update`.

### Controllers
- **ClothesController** — CRUD for clothes, admin-gated create/edit/destroy, plus cart actions (`add_to_cart`, `remove_from_cart`, `my_cart`) and admin `my_dashboard`.
- **CheckoutsController** — Creates Stripe Checkout Sessions from cart items, handles `success` (clears cart) and `cancel` redirects.
- **WebhooksController** — Receives Stripe `checkout.session.completed` webhooks, increments `sales_count` on purchased items.

### Shopping Cart
Session-based (`session[:cart]`), initialized in `ApplicationController` via `load_cart` before_action. Stores Stripe price IDs.

### Authentication & Authorization
Devise with `authenticate_user!` in ApplicationController. Public access: home, index, show. Admin checks done in controller before_actions.

### Frontend
- Hotwire (Turbo Rails + Stimulus) with Bootstrap 5.2.3
- Webpack bundles JS from `app/javascript/application.js` → `app/assets/builds/`
- SCSS in `app/assets/stylesheets/` (organized: config/, components/, pages/)

### Storage
Active Storage with Cloudinary service for all environments (configured in `config/storage.yml` and `cloudinary.yml`).

### Credentials & Environment Variables
- Stripe keys: `Rails.application.credentials[:secret_stripe]` and `Rails.application.credentials[:webhook_stripe]`
- Database password: `TUDO_BEM_MAMAN_2_DATABASE_PASSWORD` env var (production)
- Rails master key required for credentials decryption

## Deployment
Configured for Netlify (`netlify.toml`). Custom build script: `install_dependencies.sh`.

## Key Routes
- `root` → `clothes#home`
- `resources :clothes` with nested `POST /checkout`
- `/dashboard` → admin dashboard
- `/my_cart`, `/success`, `/cancel` — cart and checkout flow
- `resources :webhooks` — Stripe webhooks
