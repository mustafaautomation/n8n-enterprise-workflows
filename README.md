# n8n Enterprise Workflows

[![Validate](https://github.com/mustafaautomation/n8n-enterprise-workflows/actions/workflows/validate.yml/badge.svg)](https://github.com/mustafaautomation/n8n-enterprise-workflows/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![n8n](https://img.shields.io/badge/n8n-Workflows-FF6D5A.svg?logo=n8n&logoColor=white)](https://n8n.io)

Production-ready n8n workflow templates for enterprise automation. CI/CD notifications, AI-powered code review, QA test routing, daily standup bots, and data pipelines — all importable into any n8n instance.

---

## Workflows

### CI/CD

| Workflow | Trigger | Actions |
|----------|---------|---------|
| **GitHub PR → Slack** | PR opened webhook | Filter → format → post to #engineering |
| **CI Failure → Jira + Slack** | CI conclusion webhook | Create Jira bug → alert #ci-alerts |

### AI-Powered

| Workflow | Trigger | Actions |
|----------|---------|---------|
| **AI PR Review (Claude)** | PR opened webhook | Fetch diff → Claude analysis → post review comment |
| **AI Incident Responder** | PagerDuty webhook | Claude root cause analysis → Slack #incidents |

### QA Automation

| Workflow | Trigger | Actions |
|----------|---------|---------|
| **Test Results Router** | Test results webhook | Parse → route critical failures to Jira + Slack |

### Communication

| Workflow | Trigger | Actions |
|----------|---------|---------|
| **Daily Standup Bot** | Cron (9 AM weekdays) | Fetch GitHub PRs + Jira tickets → digest to Slack |

### Data Operations

| Workflow | Trigger | Actions |
|----------|---------|---------|
| **CSV → PostgreSQL Pipeline** | HTTP upload | Parse CSV → validate rows → insert to DB |

---

## Quick Start

```bash
# Start n8n locally
docker compose up -d

# Open n8n UI
open http://localhost:5678

# Import a workflow:
# 1. Open n8n → Workflows → Import from File
# 2. Select any JSON from workflows/
# 3. Configure credentials (Slack, Jira, GitHub, etc.)
# 4. Activate the workflow
```

---

## AI-Powered Workflows

These workflows use the **Claude API** (Anthropic) for intelligent automation:

### AI PR Review
```
PR Opened → Fetch Diff → Claude Analyzes Code → Posts Review Comment on PR
```
Set `ANTHROPIC_API_KEY` in n8n environment. Claude provides:
- What changed (summary)
- Potential risks
- Improvement suggestions

### AI Incident Responder
```
PagerDuty Alert → Claude Root Cause Analysis → Slack #incidents
```
Provides immediate:
- Likely root cause
- Mitigation steps
- Escalation recommendations

---

## Project Structure

```
n8n-enterprise-workflows/
├── workflows/
│   ├── ci-cd/
│   │   ├── github-pr-slack-notification.json
│   │   └── ci-failure-alert-jira.json
│   ├── ai-powered/
│   │   ├── ai-pr-review-summary.json          # Claude-powered
│   │   └── ai-incident-responder.json          # Claude-powered
│   ├── qa-automation/
│   │   └── test-results-router.json
│   ├── communication/
│   │   └── daily-standup-bot.json
│   └── data-ops/
│       └── csv-to-db-pipeline.json
├── docker-compose.yml                           # n8n + PostgreSQL
└── .github/workflows/validate.yml               # JSON syntax validation
```

---

## Required Credentials

| Credential | Used By |
|------------|---------|
| Slack API | All notification workflows |
| Jira Cloud | CI failure, test results |
| GitHub Token | PR review, standup bot |
| Anthropic API Key | AI PR review, incident responder |
| PostgreSQL | Data pipeline |
| PagerDuty | Incident responder |

---

## Integration Pattern

```
┌─────────────────┐     Webhook/Schedule     ┌──────────────┐
│  GitHub Actions  │ ────────────────────────→│              │
│  PagerDuty       │                          │    n8n       │
│  CI/CD Systems   │                          │  Workflows   │
│  HTTP Uploads    │                          │              │
└─────────────────┘                           └──────┬───────┘
                                                     │
                                    ┌────────────────┼────────────────┐
                                    ▼                ▼                ▼
                              ┌──────────┐    ┌──────────┐    ┌──────────┐
                              │  Slack   │    │  Jira    │    │  Claude  │
                              │  Alerts  │    │  Tickets │    │  AI      │
                              └──────────┘    └──────────┘    └──────────┘
```

---

## License

MIT

---

Built by [Quvantic](https://quvantic.com)
