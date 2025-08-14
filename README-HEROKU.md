# Playwright MCP for Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dsouza-anush/playwright-mcp-heroku)

This repository contains a Heroku-ready version of the [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) server, which provides web browsing capabilities via the Model Context Protocol (MCP).

## Deployment Instructions

### Option 1: One-Click Deployment (Recommended)

Simply click the "Deploy to Heroku" button at the top of this page. This will:

1. Create a new Heroku app
2. Set up the required buildpacks and configuration
3. Deploy the application

After deployment completes, your Playwright MCP server will be ready to use.

### Option 2: Manual Deployment

#### Prerequisites

- Heroku CLI installed
- Git installed
- Node.js installed (v18 or higher)

#### Deploy to Heroku

1. Clone this repository:
   ```
   git clone https://github.com/dsouza-anush/playwright-mcp-heroku.git
   cd playwright-mcp-heroku
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

### How the Heroku Deployment Works

This repository includes several files that enable smooth deployment on Heroku:

1. `Procfile`: Defines the processes to run (web and mcp_playwright)
2. `heroku-setup.sh`: Configures the environment for Heroku deployment
3. `heroku.package.json`: Modified package.json that includes TypeScript as a dependency

These files ensure that the TypeScript compilation process works properly on Heroku.

### Registering with Heroku Managed Inference

To register the MCP server with Heroku Managed Inference:
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

### Using with Heroku Inference

This server follows the Heroku Inference MCP standards and can be registered as an MCP tool for your AI models. The server provides web browsing capabilities that can be used by AI models through the Model Context Protocol.

#### Registering with Heroku Inference

After deployment, you need to attach the server to your Heroku Managed Inference and Agents chat model:

```bash
# Create a new model (if you don't have one already)
heroku ai:models:create MODEL_NAME -a your-playwright-mcp-app --as INFERENCE

# Or attach to an existing model
heroku addons:attach MODEL_RESOURCE -a your-playwright-mcp-app --as INFERENCE
```

The MCP entry in the Procfile (`mcp-playwright`) will be automatically registered with your model.

#### Using in API Requests

Once registered, you can use the Playwright web browsing capability in your model API requests:

```json
{
  "model": "your-model-name",
  "messages": [
    {"role": "user", "content": "Search the web for information about climate change"}
  ],
  "tools": [
    {
      "type": "mcp",
      "mcp_key": "mcp-playwright"
    }
  ]
}
```

#### MCP Server Endpoints

This deployment provides two endpoints for MCP communication:
- Primary Streamable HTTP endpoint: `https://your-app-name.herokuapp.com/mcp`
- Legacy SSE endpoint: `https://your-app-name.herokuapp.com/sse`

### Using with Claude or other MCP clients

## Limitations

- Heroku's ephemeral filesystem means any files saved during a session will be lost when the dyno restarts
- Heroku has resource limitations that may affect browser performance

## Support

For issues related to the Heroku deployment, please open an issue in this repository.
For issues related to Playwright MCP functionality, please refer to the [original repository](https://github.com/microsoft/playwright-mcp).