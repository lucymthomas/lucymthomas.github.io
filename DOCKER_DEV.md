# Local Development with Docker

This document explains how to build and run your al-folio academic website locally using Docker, so you don't have to install Ruby or Jekyll directly on your Mac.

---

## Prerequisites

- **Docker Desktop** must be installed and running. You'll see the Docker whale icon in your Mac menu bar when it's active. Download it from [docker.com](https://www.docker.com/products/docker-desktop/) if needed.

---

## First-Time Setup

If you have just cloned the repo and are running for the first time, or after any changes to the `Dockerfile` or `Gemfile`:

```bash
# 1. Navigate to your site folder
cd path/to/yourusername.github.io

# 2. Delete any stale lock file
rm -f Gemfile.lock

# 3. Build the Docker image
docker compose build --no-cache

# 4. Start the site
docker compose up
```

Your site will be live at **http://localhost:4000** and will hot-reload as you edit files.

---

## Day-to-Day Workflow

On subsequent sessions, you only need:

```bash
# Start Docker Desktop (if not already running)
# Then, in your terminal:
cd path/to/yourusername.github.io
docker compose up
```

Open **http://localhost:4000** in your browser. Jekyll watches your local files and rebuilds automatically as you make changes — no need to restart the container.

When you are finished:

```bash
docker compose down
```

---

## Key Commands Reference

| Command | What it does |
|---|---|
| `docker compose up` | Start the site at http://localhost:4000 |
| `docker compose up -d` | Start in background (detached mode) |
| `docker compose down` | Stop and remove the container |
| `docker compose logs -f` | View logs (useful in detached mode) |
| `docker compose build --no-cache` | Rebuild the image from scratch |
| `docker compose exec jekyll bash` | Open a shell inside the running container |

---

## When to Rebuild (`docker compose build --no-cache`)

You need to rebuild the Docker image (not just restart it) when you change any of the following:

- `Dockerfile` — e.g. changing the Ruby version or adding system packages
- `Gemfile` — e.g. adding or removing Ruby gems

After any such change, run:

```bash
rm -f Gemfile.lock
docker compose build --no-cache
docker compose up
```

You do **not** need to rebuild when editing site content (posts, pages, config, images, etc.) — Jekyll picks those up automatically.

---

## Current Setup

- **Ruby version:** 3.4 (specified in `Dockerfile` as `FROM ruby:3.4`)
- **Jekyll version:** 4.4.1
- **Platform:** aarch64-linux-gnu (Apple Silicon Mac)
- **Site served at:** http://localhost:4000
- **Livereload port:** 35729

---

## Common Pitfalls and Fixes

### ❌ `Could not find <gem> in locally installed gems`

**Cause:** The `bundle_cache` Docker volume has stale gem data, or gems were installed for a different platform.

**Fix:**
```bash
docker compose down
rm -f Gemfile.lock
docker compose build --no-cache
docker compose up
```

---

### ❌ `cannot load such file -- <gemname>`

**Cause:** A gem required by al-folio is missing from your `Gemfile`.

**Fix:** Add the missing gem to `Gemfile`:
```ruby
gem 'missing-gem-name'
```
Then:
```bash
rm -f Gemfile.lock
docker compose build --no-cache
docker compose up
```

---

### ❌ `Because every version of <gem> depends on Ruby >= X.X`

**Cause:** A gem requires a newer Ruby version than what's in your `Dockerfile`.

**Fix:** Update the Ruby version in `Dockerfile`:
```dockerfile
FROM ruby:3.4   # or whichever version is required
```
Then rebuild:
```bash
rm -f Gemfile.lock
docker compose build --no-cache
docker compose up
```

---

### ❌ `No such file or directory - jupyter`

**Cause:** The `jekyll-jupyter-notebook` plugin requires Jupyter to be installed in the container, but it's missing.

**Fix:** Ensure your `Dockerfile` installs Python and Jupyter:
```dockerfile
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    python3 \
    python3-pip \
    && pip3 install jupyter --break-system-packages \
    && rm -rf /var/lib/apt/lists/*
```
Then rebuild.

---

### ❌ `ostruct` warning or error on Ruby 4.0+

**Cause:** `ostruct` was removed from Ruby's standard library in Ruby 4.0, and some gems (e.g. `jekyll-twitter-plugin`) haven't been updated yet.

**Fix:** Either stay on Ruby 3.4 (recommended), or add `gem 'ostruct'` to your `Gemfile`.

---

### ❌ Port 4000 already in use

**Cause:** Another process (or a previous container that wasn't stopped cleanly) is using port 4000.

**Fix:**
```bash
docker compose down   # stop any running containers
docker compose up     # restart
```
If the problem persists, find and kill the process using port 4000:
```bash
lsof -i :4000
kill -9 <PID>
```

---

### ❌ Changes to files not showing up in the browser

**Cause:** Browser cache, or livereload not working.

**Fix:** Hard refresh the browser (`Cmd + Shift + R` on Mac), or wait a few seconds for Jekyll to finish rebuilding (watch the terminal logs).

---

## Project File Structure (Docker-related files)

```
yourusername.github.io/
├── Dockerfile          # Defines the Ruby/Jekyll environment
├── docker-compose.yml  # Defines how the container runs
├── Gemfile             # Ruby gem dependencies
├── Gemfile.lock        # Auto-generated, do not edit manually
└── DOCKER_DEV.md       # This file
```

> **Note:** `Dockerfile`, `docker-compose.yml`, and `Gemfile` should all be committed to Git. `Gemfile.lock` should also be committed once stable, but delete it before rebuilding if you encounter gem errors.