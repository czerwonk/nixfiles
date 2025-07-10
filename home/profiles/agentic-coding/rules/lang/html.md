# HTML Style Guide

## Code Formatting
- **Always run `prettierd` after modifying any HTML files**
- Follow Prettier's opinionated formatting for consistent structure
- Configure prettier settings in `.prettierrc` or `package.json`

## HTML Structure
- Use semantic HTML5 elements (`<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`, `<footer>`)
- Properly nest elements and maintain hierarchy
- Use appropriate heading levels (`<h1>` to `<h6>`) in logical order
- Include proper `<!DOCTYPE html>` declaration
- Use `<meta charset="UTF-8">` for character encoding

## Accessibility
- Use `alt` attributes for all images
- Include `aria-label` or `aria-describedby` for interactive elements
- Ensure proper color contrast ratios
- Use `tabindex` appropriately for keyboard navigation
- Include `lang` attribute on `<html>` element
- Use proper form labels and fieldsets

## Attributes and IDs
- Use meaningful `id` and `class` names
- Prefer kebab-case for CSS classes and IDs
- Use `data-*` attributes for custom data storage
- Quote all attribute values
- Order attributes consistently: `id`, `class`, `data-*`, other attributes

## Links and Navigation
- Use descriptive link text (avoid "click here")
- Use `rel="noopener noreferrer"` for external links with `target="_blank"`
- Implement proper navigation structure with `<nav>` elements
- Use breadcrumb navigation for deep site structures

## Forms
- Use proper form structure with `<form>`, `<fieldset>`, and `<legend>`
- Associate labels with form controls using `for` attribute
- Use appropriate input types (`email`, `tel`, `url`, `number`, etc.)
- Include `required` attribute for mandatory fields
- Provide clear validation messages

## Performance
- Optimize images and use appropriate formats (WebP, AVIF when supported)
- Use `loading="lazy"` for images below the fold
- Minimize HTTP requests by combining resources when possible
- Use `preload` for critical resources
- Implement proper caching strategies

## SEO and Meta Tags
- Include descriptive `<title>` tags (50-60 characters)
- Use `<meta name="description">` for page descriptions
- Include Open Graph and Twitter Card meta tags
- Use structured data markup when appropriate
- Implement proper URL structure and canonical tags

## Comments and Documentation
- Use `<!-- -->` for HTML comments
- Document complex sections or non-obvious markup
- Include comments for conditional code or browser-specific fixes
- Avoid leaving TODO comments in production code

## Validation and Quality
- Validate HTML using W3C Markup Validator
- Check for accessibility issues using tools like axe or WAVE
- Test across different browsers and devices
- Ensure proper rendering without CSS (progressive enhancement)

## Post-Modification Checklist
1. Run `prettierd --write .` to format HTML code
2. Validate HTML markup using W3C validator
3. Check accessibility with automated tools
4. Test rendering across different browsers
5. Verify responsive design on various screen sizes
6. Commit changes following git discipline rules
