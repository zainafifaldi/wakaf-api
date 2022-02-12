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

2. Copy environment file, and edit based on your configuration
   ```bash
   cp .env.example .env
   ```

3. Install dependencies
   ```bash
   bundle install
   ```

4. Migrate database and run seeder for dummy data
   ```bash
   rails db:migrate
   rails db:seed
   ```

5. Setup secret key base, by running this command, and put the result on `SECRET_KEY_BASE` value inside .env file
   ```bash
   rake secret
   ```

6. Start application
   ```bash
   rails s
   ```
