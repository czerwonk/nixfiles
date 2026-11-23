# HTML Guide

## Conventions
- **Never inline CSS or JS** (security: allows a strict Content-Security-Policy without `unsafe-inline`):
  - no `<style>` or `<script>` blocks with content, no `style="..."` attributes
  - no inline event handlers (`onclick="..."` etc.), no `javascript:` URLs
  - put CSS and JS in separate files and attach behavior with `addEventListener`
- Semantic HTML5 elements, accessible forms (labels, alt texts, keyboard navigation)
- Public sites additionally need SEO basics: descriptive `<title>`, meta description, Open Graph tags, canonical URLs - not needed for internal tools

## Checklist
1. `prettierd --write .`
2. Check changes visually (screenshots at ~390px and ~1440px width) - if that's not possible, report the change as not visually verified
