# Resume Site

A self-contained resume/credentials site, served by nginx inside Docker.
No database, no PHP, no plugins — just static files in a container.

## Run it

You need Docker installed. Then, from this folder:

```bash
docker compose up -d
```

Visit **http://localhost:8080**

To stop it:

```bash
docker compose down
```

Prefer plain Docker commands instead of compose?

```bash
docker build -t resume-site .
docker run -d -p 8080:80 --name resume-site resume-site
```

## Customize the content

Everything lives in three files — edit them in any text editor, no build step required:

| File          | What's in it                                                  |
|---------------|----------------------------------------------------------------|
| `index.html`  | All page content: name, skills, certifications, experience, education, contact |
| `style.css`   | Colors, fonts, spacing — see the `:root` variables at the top |
| `script.js`   | Mobile nav + active-section highlighting (rarely needs edits) |

Search `index.html` for `<!-- EDIT ME` comments — they mark every block you'll want to personalize:

- **Hero**: name, title, one-line thesis, email link
- **Skills**: category rows in the ledger — add/remove `.ledger__row` blocks
- **Certifications**: duplicate a `.cert-card` block per credential
- **Experience**: duplicate a `.timeline__item` block per role
- **Contact**: email, phone, LinkedIn, location

To add a headshot or logo, drop the image in `assets/` and reference it as `assets/yourfile.jpg`.

After editing, rebuild the image so the changes take effect:

```bash
docker compose up -d --build
```

## Push it to GitHub and publish a pullable image

This repo includes a GitHub Actions workflow (`.github/workflows/docker-publish.yml`)
that builds the image and pushes it to **GitHub Container Registry (GHCR)**
automatically on every push to `main`. No Docker Hub account needed — it
uses GitHub's own registry and the token GitHub already provides to Actions.

**1. Push the repo to GitHub**

```bash
cd resume-site
git init
git add .
git commit -m "Initial commit: resume site"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin main
```

(Create the empty repo on GitHub first, via the web UI or `gh repo create`.)

**2. Let the workflow run**

Go to the **Actions** tab of your repo on GitHub — the workflow runs
automatically after the push and builds + publishes the image. It takes
a couple of minutes the first time.

**3. Make the package pullable**

By default, packages publish as **private**. To pull without logging in:

- Go to your GitHub profile → **Packages** tab → select the package
- **Package settings** → **Change visibility** → **Public**

(If you'd rather keep it private, `docker login ghcr.io -u <username>` with
a Personal Access Token that has `read:packages` scope works fine instead.)

**4. Pull and run it anywhere**

```bash
docker pull ghcr.io/<your-username>/<your-repo>:latest
docker run -d -p 8080:80 ghcr.io/<your-username>/<your-repo>:latest
```

That's it — any machine with Docker can now run your resume site without
ever cloning the repo or rebuilding the image. Every future `git push` to
`main` rebuilds and republishes it automatically.

## Deploy it anywhere

Because it's just a container, it runs identically on any host that has Docker:
a VPS (DigitalOcean, Linode, Hetzner), a Raspberry Pi, Fly.io, Render, or a
home server. Copy this folder over, run `docker compose up -d`, and put a
reverse proxy (Caddy, Traefik, or your host's load balancer) in front for
HTTPS — Caddy in particular makes this a 3-line Caddyfile.

If you want a quick HTTPS option without managing your own server, a static
site host like Netlify, Vercel, GitHub Pages, or Cloudflare Pages will also
serve `index.html` directly — you wouldn't even need the Docker layer for those,
though it's handy for local development, self-hosting, and CI consistency.

## Why this instead of WordPress

- No database to back up, corrupt, or migrate.
- No PHP runtime or plugin ecosystem to patch.
- The entire site is three files — fully readable, fully portable.
- A fresh container is always a clean, known state — no accumulated cruft from years of updates.
- Security headers and caching are set once in `nginx.conf`, not fought over in fifteen plugin settings panels.
