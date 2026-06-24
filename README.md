# Resume Site

A simple resume website hosted in a self updating docker container.

## Why this instead of WordPress

- No database to back up, corrupt, or migrate.
- No PHP runtime or plugin ecosystem to patch.
- The entire site is three files — fully readable, fully portable.
- A fresh container is always a clean, known state — no accumulated cruft from years of updates.
- Security headers and caching are set once in `nginx.conf`, not fought over in fifteen plugin settings panels.
