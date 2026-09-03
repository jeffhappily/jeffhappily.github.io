# jeffhappily.github.io

Personal site — homepage + now section + things I've worked on + a stream of
short notes, with older learning notes kept in an archive. Built with
[Hakyll](https://jaspervdj.be/hakyll/).

## Structure

- `index.html` — homepage (intro, now, things I've worked on, recent notes)
- `about.html` — redirect stub so the old `/about.html` URL still resolves
- `notes/` — short writeups, no schedule; a note can be 150 words and still be finished
- `posts/` — old learning notes (2019–2022), listed on `/archive.html`; kept as-is, not being "finished"
- `site.hs` — Hakyll rules
- `templates/`, `css/` — layout and styles

## Build

```sh
stack build
stack exec site -- watch   # local preview at http://localhost:8000
stack exec site -- rebuild # full rebuild into _site/
```

Deployed to GitHub Pages via `.github/workflows/main.yml` on push to `master`.
