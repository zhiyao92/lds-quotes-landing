# LDS Quotes — link-in-bio landing page

A single-page, mobile-first landing page for the **LDS Quotes** iOS app, built for the
Instagram "link in bio" slot.

- `index.html` — the whole page (no build step, no dependencies except Google Fonts)
- `assets/app-icon.png` — app icon, exported from the app's asset catalog
- `assets/favicon.png` — favicon / Apple touch icon

Every call-to-action points at the App Store link with the Instagram campaign token
attached, so installs show up under **Instagram** in App Store Connect → App Analytics:

```
https://apps.apple.com/app/apple-store/id1506121689?pt=118418326&ct=Instagram&mt=8
```

## Deploy to GitHub Pages

```bash
gh repo create lds-quotes-landing --public --source=. --push
```

Then in the repo: **Settings → Pages → Build and deployment → Deploy from a branch →
`main` / `(root)`**. The page goes live at
`https://<username>.github.io/lds-quotes-landing/` in a minute or two.

To use a custom domain (e.g. `ldsquotes.app`), add a `CNAME` file containing the domain
and point a DNS `CNAME` record at `<username>.github.io`.

## Preview locally

```bash
python3 -m http.server 8000
# open http://localhost:8000
```

## Editing notes

- **Colours** live in the `:root` block at the top of `index.html` — they're taken from
  the app icon (cream `#FBF4E4`, sage `#8C9C6E`, gold `#E0A32E`).
- **Rotating quotes** in the phone mockup: the `quotes` array in the script at the bottom.
- **Quote wall**: the `<blockquote class="pull">` elements.
- The phone and widget mockups are pure CSS — swap them for real App Store screenshots
  by dropping images into `assets/` and replacing `.screen` / `.wgt` markup.
