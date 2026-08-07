# LDS Quotes — link-in-bio landing page

A single-page, mobile-first landing page for the **LDS Quotes** iOS app, built for the
Instagram "link in bio" slot.

- `index.html` — the whole page (no build step, no dependencies except Google Fonts)
- `go/index.html` — click-counting redirect to the App Store (see *Measuring clicks*)
- `assets/app-icon.png` — app icon, exported from the app's asset catalog
- `assets/favicon.png` — favicon / Apple touch icon
- `assets/shots/` — real screenshots captured from the app in the iOS Simulator
- `.nojekyll` — stops GitHub Pages running the site through Jekyll

## Where the links point

Every call-to-action goes to `/go`, which counts the click and then forwards to the App
Store link with the Instagram campaign token attached, so installs still show up under
**Instagram** in App Store Connect → App Analytics:

```
https://apps.apple.com/app/apple-store/id1506121689?pt=118418326&ct=Instagram&mt=8
```

## Deploy — Cloudflare Pages

The live link is served from Cloudflare Pages so the URL doesn't say "github.io".

1. Cloudflare dashboard → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**
2. Pick the `lds-quotes-landing` repo.
3. Build settings: framework preset **None**, build command **empty**, output directory
   **`/`** (it's a static site — there is nothing to build).
4. Deploy. The page goes live at `https://lds-quotes-landing.pages.dev`.
   Rename the project in **Settings → General** if you want a shorter host, e.g.
   `ldsquotes.pages.dev`.

Every push to `main` redeploys automatically.

### Custom domain (optional)

**Settings → Custom domains → Set up a domain**. If the domain is already on Cloudflare
DNS the record is created for you.

## Measuring clicks

**Cloudflare Pages → the project → Metrics → Web Analytics → Enable.** Cloudflare injects
its beacon automatically; nothing needs to be pasted into `index.html`.

Two numbers matter, and you read both from the same dashboard:

| Number | Where to read it |
|---|---|
| People who opened the link | pageviews of `/` |
| People who tapped "Download" | pageviews of `/go` |

Cloudflare Web Analytics is free and unlimited, is cookieless, and needs no consent
banner. It only counts pageviews — it has no custom-event API — which is exactly why the
CTAs route through the real `/go` page instead of firing a JS event.

`/go?src=hero`, `?src=final` and `?src=sticky` distinguish which button was tapped; the
query strings show up in the path breakdown.

## GitHub Pages (backup)

Still enabled at `https://zhiyao92.github.io/lds-quotes-landing/` as a fallback. The
`.nojekyll` file is what keeps that build passing — without it Jekyll tries to process
the site and fails.

## Preview locally

```bash
python3 -m http.server 8000
# open http://localhost:8000
```

## Editing notes

- **Colours** live in the `:root` block at the top of `index.html` — they're taken from
  the app icon (cream `#FBF4E4`, sage `#8C9C6E`, gold `#E0A32E`).
- **Screenshots** are in `assets/shots/`, captured from the iOS Simulator. To refresh
  them, build the app from `../LDS-Quotes`, run it on an iPhone 16 Pro Max simulator and
  `xcrun simctl io booted screenshot`.
- **Quote wall**: the `<blockquote class="pull">` elements.
