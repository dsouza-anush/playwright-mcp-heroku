# Playwright MCP for Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This is a fork of [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) adapted for Heroku deployment. This repository contains minimal changes to make the Playwright MCP server work on Heroku while ensuring it can continue to receive updates from the original repository.

## Added Files

- **Procfile**: Required for Heroku deployment
- **app.json**: Heroku app configuration
- **update-from-upstream.sh**: Script to update from the original repo while preserving Heroku changes
- **.heroku-files**: List of files specific to this Heroku adaptation

## Deployment

For deployment instructions, see [README-HEROKU.md](README-HEROKU.md).

## License

Same as the original repository - Apache License 2.0.