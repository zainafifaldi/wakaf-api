# Wakaf API Service

This service belongs to client service (application) that has a purposes as waqf platform.

## Stacks

- Ruby (v2.6.5)
- Ruby on Rails (v6.0.3)
- MySQL
- Redis

## How To Install

1. Clone repository (SSH recommended)
   ```bash
   git clone git@github.com:zainafifaldi/wakaf-api.git
   ```

Copy environment file, and edit based on your configuration
   ```bash
   cp .env.example .env
   ```

Install dependencies
   ```bash
   bundle install
   ```

Migrate database
   ```bash
   rails db:migrate
   ```

Setup secret key base, by running this command, and put the result on `SECRET_KEY_BASE` value inside .env file
   ```bash
   rake secret
   ```

Start application
   ```bash
   rails s
   ```
