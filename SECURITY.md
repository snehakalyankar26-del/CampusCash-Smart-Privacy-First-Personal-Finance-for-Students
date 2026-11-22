# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Security Architecture

CampusCash is built strictly according to zero-trust, privacy-first principles:

1. **Client-Side Data Storage**: All student data lives exclusively in browser `localStorage`. No database credentials, no authentication tokens, and no server-side user data persistence.
2. **Formula Injection Guard (DDE Protection)**: Spreadsheet export and import sanitize dangerous formula characters (`=`, `+`, `-`, `@`, `\t`, `\r`) by prefixing with an apostrophe (`'`).
3. **Strict Content Security Policy**: HTTP edge and server headers disallow remote script injection (`script-src 'self'`), framing (`frame-ancestors 'none'`), and dangerous objects.
4. **XSS Protection**: Frontend rendering uses exclusively DOM element creation (`document.createElement`) and `textContent` rather than `innerHTML` when handling user input.

## Reporting a Vulnerability

If you discover a security issue, please email the maintainers directly or open a confidential GitHub advisory instead of posting a public issue.
