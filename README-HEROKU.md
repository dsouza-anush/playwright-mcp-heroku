# Playwright MCP for Heroku

This repository contains a Heroku-ready version of the [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) server, which provides web browsing capabilities via the Model Context Protocol (MCP).

## Deployment Instructions

### Prerequisites

- Heroku CLI installed
- Git installed
- Node.js installed (v18 or higher)

### Deploy to Heroku

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/heroku-playwright-mcp.git
   cd heroku-playwright-mcp
   ```

2. Login to Heroku:
   ```
   heroku login
   ```

3. Create a new Heroku app:
   ```
   heroku create your-app-name
   ```

4. Push to Heroku:
   ```
   git push heroku main
   ```

5. Register the MCP server with Heroku Managed Inference:
   - Ensure you have the Managed Inference add-on
   - The Procfile includes the `mcp_playwright` entry needed for registration

### Configuration

The following environment variables can be set in Heroku:

- `NODE_ENV`: Set to "production" by default
- Any other environment variables supported by Playwright MCP with the prefix `PLAYWRIGHT_MCP_`

### Keeping Up-to-Date with Upstream

This repository is configured to track the original Microsoft Playwright MCP repository as an upstream remote. To update:

#### Automatic Update (Recommended)

Use the provided update script which preserves Heroku-specific files:

```
./update-from-upstream.sh
```

This script will:
1. Backup Heroku-specific files
2. Fetch and merge upstream changes
3. Restore Heroku-specific files
4. Provide instructions for deployment

#### Manual Update

If you prefer to update manually:

1. Fetch updates from upstream:
   ```
   git fetch upstream
   ```

2. Merge updates (from the main branch):
   ```
   git merge upstream/main
   ```

3. Make sure you didn't lose Heroku-specific files (Procfile, app.json, etc.)

4. Push to Heroku:
   ```
   git push heroku main
   ```

## Usage

Once deployed, your Playwright MCP server will be available at:

- Streamable HTTP endpoint: `https://your-app-name.herokuapp.com/mcp`
- SSE endpoint: `https://your-app-name.herokuapp.com/sse`

## Limitations

- Heroku's ephemeral filesystem means any files saved during a session will be lost when the dyno restarts
- Heroku has resource limitations that may affect browser performance

## Support

For issues related to the Heroku deployment, please open an issue in this repository.
For issues related to Playwright MCP functionality, please refer to the [original repository](https://github.com/microsoft/playwright-mcp).