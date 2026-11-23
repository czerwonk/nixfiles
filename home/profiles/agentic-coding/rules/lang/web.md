# Web UI Guide (HTML, templates, frontend JS)

Goal: every web UI works with a strict Content-Security-Policy and has no injection points by default.

## No Inline CSS or JS
- No `<style>` or `<script>` blocks with content, no `style="..."` attributes
- No inline event handlers (`onclick="..."` etc.), no `javascript:` URLs
- Put CSS and JS in separate files and attach behavior with `addEventListener`
- Pass server data to JS via `data-*` attributes, not via inline scripts

## No HTML Injection
- **Never use `innerHTML`** or its equivalents (`outerHTML`, `insertAdjacentHTML`, `document.write`); build the DOM with `textContent`, `createElement`, `append` etc.
- Never bypass template auto-escaping (`|safe` in Askama/Jinja, `{!! !!}` in Blade, `template.HTML(...)` in Go, `v-html`, `dangerouslySetInnerHTML`) - unless the content is trusted, with a comment explaining why
- No `eval`, `new Function`, or `setTimeout`/`setInterval` with string arguments
- Only allow `http`/`https` schemes for user-supplied URLs in links and redirects

## Resources
- No third-party CDN scripts or styles: self-host them; if that's impossible, use Subresource Integrity (`integrity=`)

## Server Side
- Send security headers: `Content-Security-Policy` with `default-src 'self'` (no `unsafe-inline`, no `unsafe-eval`), `frame-ancestors 'none'`, `X-Content-Type-Options: nosniff`, `Referrer-Policy`
- State-changing requests only via POST/PUT/DELETE, with CSRF protection
- Cookies: `Secure`, `HttpOnly`, `SameSite=Lax` or stricter
