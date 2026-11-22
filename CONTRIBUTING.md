# Contributing to CampusCash 🎓

Thank you for your interest in contributing to **CampusCash**! This project is built to empower college students worldwide with a fast, private, and accessible financial companion.

## Development Workflow

1. **Fork and Clone**:

   ```bash
   git clone https://github.com/snehakalyankar26-del/CampusCash-Smart-Privacy-First-Personal-Finance-for-Students.git
   cd CampusCash-Smart-Privacy-First-Personal-Finance-for-Students
   ```

2. **Install Dependencies**:

   ```bash
   npm install
   ```

3. **Run the Development Server**:

   ```bash
   npm run dev
   ```

   Open `http://localhost:3000` in your browser.

4. **Run Tests & Verify Coverage**:

   ```bash
   npm test
   ```

   All contributions must maintain **100% test coverage** across statements, branches, functions, and lines.

5. **Lint and Format**:
   ```bash
   npm run lint
   npm run format
   ```

## Code Quality Standards

- **Zero Third-Party Frontend Frameworks**: Use vanilla HTML5, modern CSS3, and ES Modules.
- **Privacy First**: Never introduce external trackers, telemetry, or third-party storage. All user financial data belongs exclusively in browser `localStorage`.
- **Accessibility**: All interactive UI components must maintain WCAG 2.1 AA compliance with semantic landmarks, keyboard focus management, and `aria-live` announcements.
- **Security**: Guard all CSV imports/exports against formula injection (DDE) and maintain Helmet Content-Security-Policy compliance.
