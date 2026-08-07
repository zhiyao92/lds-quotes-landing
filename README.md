# LDS Quotes — link-in-bio landing page

A single-page, mobile-first landing page for the **LDS Quotes** iOS app, built for the
Instagram "link in bio" slot.

- `index.html` — the whole page (no build step, no dependencies except Google Fonts)
- `go/index.html` — click-counting interstitial: auto-redirects to the App Store, with a manual button and in-app-browser instructions as fallback
- `assets/app-icon.png` — app icon, exported from the app's asset catalog
- `assets/favicon.png` — favicon / Apple touch icon
- `assets/shots/` — real screenshots captured from the app in the iOS Simulator
- `.nojekyll` — stops GitHub Pages running the site through Jekyll

## Where the links point

Every call-to-action goes to `/go`, which counts the click and bounces on to the App
Store link with the Instagram campaign token attached:

```
https://apps.apple.com/app/apple-store/id1506121689?pt=118418326&ct=Instagram&mt=8
```

In-app browsers (Instagram's especially) suppress JS-initiated navigation, so the
auto-redirect can quietly fail there. `/go` is designed for that: it shows a big
"Open the App Store" button (a real user tap always gets through) and instructions
to use the ··· menu → "Open in external browser" for the stubborn case.

The landing page also carries Apple's Smart App Banner meta tag, so Safari visitors
get a native GET banner at the top for free.

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

## Measuring the funnel

| Number | Where to read it |
|---|---|
| People who opened the link | Cloudflare Web Analytics — pageviews of `/` |
| People who tapped "Download" | Cloudflare Web Analytics — pageviews of `/go` (`?src=` says which button) |
| Store page views & installs | **App Store Connect → Analytics → Sources** — campaign `Instagram` |

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
