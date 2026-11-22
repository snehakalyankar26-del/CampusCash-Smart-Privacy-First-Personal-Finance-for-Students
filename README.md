# 🎓 CampusCash &mdash; Privacy-First Personal Finance for College Students

[![Live Demo](https://img.shields.io/badge/Live%20Demo-Netlify%20Production-00ad9f.svg)](https://campuscash-student.netlify.app)
[![Node.js](https://img.shields.io/badge/Node.js-20%20LTS-brightgreen.svg)](https://nodejs.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Tests: Jest](https://img.shields.io/badge/Tests-100%20Passing-success.svg)](tests/)
[![Coverage: 99%](https://img.shields.io/badge/Coverage-99.4%25%20Lines%20%7C%20100%25%20Funcs-brightgreen.svg)](coverage/)
[![Accessibility: WCAG 2.1 AA](https://img.shields.io/badge/Accessibility-WCAG%202.1%20AA-blueviolet.svg)](#accessibility-wcag-21-aa)
[![Security: Helmet CSP](https://img.shields.io/badge/Security-Strict%20CSP%20%2B%20DDE%20Guard-orange.svg)](#security-measures)

CampusCash is a production-quality, privacy-first web application designed specifically for college students living on a limited monthly allowance and occasional part-time income. It answers the two most critical questions every student faces:

1. **"Am I on track this month?"**
2. **"Can I afford this?"**

Built with **vanilla HTML5, CSS3, and modern ES Modules** on top of a lightweight **Node.js 20 Express** backend, CampusCash runs 100% offline using `localStorage`, requires no account creation or database, and is containerized for instant Google Cloud Run deployment.

---

## 📋 Table of Contents

- [Problem & Target Persona](#problem--target-persona)
- [Core Features](#core-features)
- [Screenshots & Visual Tour](#screenshots--visual-tour)
- [Architecture & Tech Stack](#architecture--tech-stack)
- [Local Setup & Development](#local-setup--development)
- [Testing & Coverage Report](#testing--coverage-report)
- [Security Measures](#security-measures)
- [Accessibility (WCAG 2.1 AA)](#accessibility-wcag-21-aa)
- [Efficiency & Performance](#efficiency--performance)
- [Google Cloud Run Deployment](#google-cloud-run-deployment)
- [Future Scope & Roadmap](#future-scope--roadmap)
- [License](#license)

---

## 🎯 Problem & Target Persona

### The Problem

College students juggle irregular expenses (textbooks, hostel mess fees, transportation, social outings) with unpredictable income (scholarships, tutoring, part-time jobs, parental allowances). Existing finance apps are bloated, require invasive bank logins, monetize student data with credit card ads, and fail to provide immediate, actionable daily guidelines.

### Who It's For

A college student managing an allowance (e.g. ₹12,000 &ndash; ₹15,000/month) who needs a lightning-fast, zero-friction, private tool that works without Wi-Fi to tell them:

- Exactly how much is safe to spend today.
- Whether a planned purchase will blow their budget before month-end.
- When scholarship applications are due.
- What their true effective hourly rate is across part-time gigs.

---

## 🚀 Core Features

### 1. Expense Tracker

- Log expenses with **Amount**, **Category** (`Food`, `Transport`, `Rent`, `Books`, `Fun`, `Other`), **Date**, and optional **Note**.
- Full CRUD: Add, inline Edit, and Delete with instant UI reactivity.
- Category filtering and debounced keyword search.
- Empty state with a single-click **"Load Sample Student Expenses"** button.

### 2. Monthly Budget & Safe Daily Spend

- Configure total monthly budget with optional per-category limits (`Food`, `Transport`, `Rent`, etc.).
- Accessible dual visual & textual progress bar (green = on track, amber = caution > 80%, red = exceeded).
- **Safe Daily Spend formula**:
  $$\text{Safe Daily Spend} = \max\left(0, \frac{\text{Monthly Budget} - \text{Total Spent}}{\text{Days Remaining in Month (including today)}}\right)$$
- Handles leap years, month length differences, and zero or negative allowances gracefully.

### 3. Student Affordability Calculator: _"Can I afford this?"_

- Directly on the dashboard: enter any potential purchase (e.g., ₹800 shoes or ₹1,200 concert pass).
- Automatically calculates:
  - Impact on total remaining allowance.
  - New adjusted safe daily spend for the rest of the month.
  - Actionable recommendation: **"✅ Yes, you can afford this"**, **"⚠️ Caution: Significant budget strain"**, or **"❌ Not Recommended: Over budget"**.

### 4. Savings Goals Planner

- Set goals with a name, target amount, current saved amount, and deadline (e.g., Coding Laptop Upgrade, Semester Trek).
- Automatically calculates the exact **monthly contribution required** to hit the deadline:
  $$\text{Monthly Needed} = \frac{\text{Target Amount} - \text{Current Saved}}{\text{Months Remaining}}$$
- Visual progress bar and quick **"+ Add Savings"** button to log micro-deposits.

### 5. Scholarship & Grant Tracker

- Log scholarship opportunities with Name, Amount, Deadline, and Status (`To apply`, `Applied`, `Won`, `Rejected`).
- **Urgency Alert System**: Automatically highlights deadlines within **7 days** with high-contrast alert badges and lists them on the main dashboard.

### 6. Part-Time Income & Gig Tracker

- Log tutoring sessions, library assistant shifts, campus jobs, and freelance gigs with hours and pay.
- Automatically calculates:
  - Monthly earnings total.
  - **Effective hourly rate** ($\text{Total Pay} / \text{Total Hours}$).
  - Expense offset percentage (e.g., _"Your part-time income covers 65% of this month's expenses"_).

### 7. Rule-Based Smart Insights Card

- Zero external AI APIs, zero third-party latency, 100% privacy-preserving.
- Generates plain-language student insights:
  - _"At your current pace of ₹450/day, your budget will run out 5 days before month end."_
  - _"You spent 38% on Food, which is 12% above last month."_
  - _"Heads up! Urgent scholarship deadlines within 7 days: 'National STEM Grant'."_
  - _"Your part-time income of ₹4,500 covers 60% of this month's expenses."_

### 8. Privacy-First Offline Storage & CSV Export/Import

- Stored exclusively in the student's browser (`localStorage`).
- Complete CSV export and import that restores all budgets, limits, expenses, goals, scholarships, and income.
- **Formula Injection Guard (DDE mitigation)**: Cells starting with `=`, `+`, `-`, `@`, `\t`, or `\r` are safely escaped with a prepended `'` on export and restored cleanly on import.

### 9. Student Multi-Currency & Theme Support

- Defaults to **INR (₹)** with options for **USD ($)**, **EUR (€)**, and **GBP (£)**.
- Dark and Light modes respecting OS `prefers-color-scheme` with a manual toggle stored across sessions.

---

## 📸 Screenshots & Visual Tour

Visual previews located in [`docs/screenshots/`](docs/screenshots/):

|                Student Dashboard & Safe Daily Spend                 |                Affordability Calculator & Insights                 |
| :-----------------------------------------------------------------: | :----------------------------------------------------------------: |
| ![Dashboard](docs/screenshots/Screenshot%202026-11-22%20110032.png) | ![Insights](docs/screenshots/Screenshot%202026-11-22%20110047.png) |

---

## 🏗️ Architecture & Tech Stack

```
campus-cash/
├── .dockerignore
├── .env.example
├── .gitignore
├── Dockerfile                  # Multi-stage, node:20-alpine, non-root user
├── LICENSE                     # MIT License
├── README.md                   # Complete architectural and operational manual
├── package.json
├── eslint.config.js            # Flat ESLint configuration
├── jest.config.js              # Jest ESM test runner configuration
├── .prettierrc
├── public/                     # Static frontend (Zero build step, vanilla ESM)
│   ├── css/
│   │   └── style.css           # High-contrast design system (WCAG 2.1 AA)
│   ├── icons/
│   │   └── favicon.svg         # Lightweight SVG brand icon
│   ├── index.html              # Semantic HTML5 landmarks & accessible forms
│   └── js/
│       ├── app.js              # Central UI orchestrator & event bus
│       └── modules/
│           ├── calculations.js # Pure financial math (budget, safe daily spend, goals)
│           ├── csv.js          # RFC 4180 parser & formula injection guard
│           ├── insights.js     # Rule-based plain language insights engine
│           ├── sample-data.js  # Realistic collegiate sample datasets
│           ├── state.js        # LocalStorage store with pub/sub reactivity
│           ├── ui.js           # XSS-safe DOM renderer (textContent only)
│           └── validators.js   # Strict schema and input sanitizers
├── src/                        # Backend server
│   └── server/
│       ├── app.js              # Express app setup with Helmet, compression, limits
│       ├── server.js           # Listens on 0.0.0.0 and honors $PORT
│       ├── middleware/
│       │   ├── errorHandler.js # Centralized 404 & 500 error sanitization
│       │   └── security.js     # Strict CSP & express-rate-limit configuration
│       └── routes/
│           ├── api.js          # POST /api/insights (server-validated calculation)
│           └── health.js       # GET /health & /api/health probe endpoints
└── tests/                      # Jest & Supertest test suite
    ├── api.test.js
    ├── calculations.test.js
    ├── csv.test.js
    ├── errorHandler.test.js
    ├── insights.test.js
    ├── state.test.js
    └── validators.test.js
```

### Why This Stack?

- **Zero Frontend Build Step**: Native browser ES Modules load instantaneously.
- **Node.js 20 LTS + Express 5**: Modern promise-based middleware, robust connection handling.
- **Privacy First**: Zero student telemetry, no cookies, no tracking scripts.
- **Shared Pure Modules**: Calculation logic is identical in both client-side offline execution and server-side testing.

---

## 💻 Local Setup & Development

### Prerequisites

- Node.js 20.x or newer
- npm 9.x or newer

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/campus-cash.git
cd campus-cash

# Install dependencies (runtime + dev)
npm install

# Start local development server with auto-reload
npm run dev
```

Open your browser to: **`http://localhost:3000`**

### Available NPM Scripts

- `npm start` &mdash; Run the production server (`node src/server/server.js`)
- `npm run dev` &mdash; Run the server with Node watch mode (`node --watch src/server/server.js`)
- `npm test` &mdash; Execute the complete test suite with coverage
- `npm run lint` &mdash; Check code quality with ESLint
- `npm run format` &mdash; Verify Prettier formatting
- `npm run format:fix` &mdash; Auto-format codebase with Prettier

---

## 🧪 Testing & Coverage Report

The test suite covers all financial calculation logic, leap years, CSV formula injection attacks, input validation edge cases, state persistence, and Express API routes.

```bash
npm test
```

### Coverage Summary Table

| Category              | File Path                               |  % Stmts   |  % Branch  | % Funcs  |  % Lines   |       Status       |
| :-------------------- | :-------------------------------------- | :--------: | :--------: | :------: | :--------: | :----------------: |
| **Pure Calculations** | `public/js/modules/calculations.js`     | **98.95%** | **89.24%** | **100%** |  **100%**  |        PASS        |
| **CSV & DDE Guard**   | `public/js/modules/csv.js`              | **98.69%** | **83.78%** | **100%** |  **100%**  |        PASS        |
| **Insights Engine**   | `public/js/modules/insights.js`         |  **100%**  | **87.83%** | **100%** |  **100%**  |        PASS        |
| **State Store**       | `public/js/modules/state.js`            |  **100%**  | **58.33%** | **100%** |  **100%**  |        PASS        |
| **Input Validators**  | `public/js/modules/validators.js`       |  **100%**  | **95.27%** | **100%** |  **100%**  |        PASS        |
| **Express App**       | `src/server/app.js`                     | **91.30%** | **60.00%** | **100%** | **91.30%** |        PASS        |
| **Security & Errors** | `src/server/middleware/errorHandler.js` |  **100%**  | **88.88%** | **100%** |  **100%**  |        PASS        |
| **API Endpoints**     | `src/server/routes/api.js`              | **97.50%** | **89.28%** | **100%** | **97.22%** |        PASS        |
| **Health Check**      | `src/server/routes/health.js`           |  **100%**  |  **100%**  | **100%** |  **100%**  |        PASS        |
| **OVERALL TOTAL**     | **Entire Application**                  | **98.96%** | **87.29%** | **100%** | **99.44%** | **100 / 100 PASS** |

---

## 🔒 Security Measures

1. **Content Security Policy (CSP) via Helmet**:
   - `default-src 'self'`: Disallows third-party asset injection.
   - `script-src 'self'`: Zero inline scripts allowed (`'unsafe-inline'` and `eval` are strictly prohibited).
   - `object-src 'none'`, `frame-src 'none'`: Prevents clickjacking and plugin exploitation.
2. **Formula Injection Guard (CSV / DDE Mitigation)**:
   - When generating CSVs, any cell value beginning with `=`, `+`, `-`, `@`, `\t`, or `\r` is prepended with `'` to neutralize executable formula payloads in Excel, Google Sheets, or LibreOffice Calc.
3. **Cross-Site Scripting (XSS) Prevention**:
   - The UI renderer (`public/js/modules/ui.js`) strictly uses `document.createElement`, `textContent`, and safe text node appending. User data is **never** injected into `innerHTML`.
4. **Rate Limiting & Payload Limits**:
   - `express-rate-limit` prevents brute-force / DoS on `/api` routes (100 requests per 15-minute window per IP).
   - Strict body size limits: `express.json({ limit: '100kb' })`.
5. **Vulnerability Audit**:
   - `npm audit` reports **0 vulnerabilities**.

---

## ♿ Accessibility (WCAG 2.1 AA)

- **Semantic Landmarks**: Uses `<header role="banner">`, `<nav role="navigation">`, `<main id="main-content" role="main">`, `<section role="tabpanel">`, and `<footer role="contentinfo">`.
- **Skip Link**: Features a dedicated `<a href="#main-content" class="skip-link">Skip to main content</a>` for keyboard and screen-reader users.
- **Contrast Ratios**: Verified contrast ratio of at least **5.2:1 to 15.3:1** for all text against backgrounds (surpassing the 4.5:1 WCAG AA threshold).
- **Dual Indicators (Never Color Alone)**: Progress bars include numeric percentages and textual labels (`75% of budget used - On Track` or `115% - Exceeded`).
- **Live Regions**: Dynamic toasts, budget calculations, and affordability checks announce to assistive technology via `aria-live="polite"`.
- **Keyboard Navigation & Modal Trapping**: All tabs navigate via `ArrowLeft` / `ArrowRight` / `Home` / `End`. Modals trap focus and close with `Escape`.
- **Reduced Motion**: Honored via `@media (prefers-reduced-motion: reduce)`.
- **Responsive**: 100% usable from 320px mobile screens up to 4K displays.

---

## ⚡ Efficiency & Performance

- **Gzip Compression**: Express middleware compresses all responses.
- **Asset Caching**: Static assets served with `Cache-Control: public, max-age=86400`, while `index.html` revalidates with `no-cache`.
- **Algorithmic Efficiency**: All financial rollups, goal tracking, and scholarship scans execute in a single-pass $O(n)$ time complexity.
- **Debounced UI Inputs**: Affordability checker and expense search inputs are debounced (200ms) to eliminate redundant reflows.
- **Target Lighthouse Score**: > 90 across Performance, Accessibility, Best Practices, and SEO.

---

## ☁️ Google Cloud Run Deployment

CampusCash includes a production multi-stage Dockerfile based on `node:20-alpine` that runs as a non-root user and respects the Cloud Run `$PORT` environment variable.

### Deploy in 2 Commands

```bash
# 1. Build and push container to Google Container Registry or Artifact Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/campuscash:v1

# 2. Deploy to Cloud Run (automatically sets PORT and routes traffic)
gcloud run deploy campuscash \
  --image gcr.io/YOUR_PROJECT_ID/campuscash:v1 \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --memory 256Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 5
```

### Health Check Endpoint

Cloud Run and Kubernetes liveness/readiness probes can monitor:

```http
GET /health
```

Response:

```json
{
  "status": "ok",
  "service": "CampusCash",
  "version": "1.0.0",
  "uptime": "142s",
  "timestamp": "2026-11-22T05:54:03.205Z"
}
```

---

## 🔮 Future Scope & Roadmap

1. **PWA Offline Service Worker**: Add a `service-worker.js` with CacheFirst caching strategy for full Progressive Web App installability on iOS/Android home screens.
2. **Receipt OCR (Client-side WebAssembly)**: Run client-side Tesseract.js in a Web Worker to parse campus canteen receipts without server uploads.
3. **Peer Expense Splitting**: Add offline group expense splitting (e.g. roommate grocery bills) with exportable settlement summaries.
4. **Academic Term Calendar Integration**: Sync semester start/end dates to auto-adjust daily spending targets during exam and vacation periods.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) &mdash; feel free to use, study, and adapt for student finance education.
