# Bright Data MCP for Heroku

This is a fork of the [Bright Data MCP](https://github.com/brightdata/brightdata-mcp) repository, adapted for deployment on Heroku.

## Deploying to Heroku

You can deploy this MCP server to Heroku with one click using the button below:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dsouza-anush/brightdata-mcp-heroku)

## Configuration

After deployment, make sure to set the following environment variables in your Heroku app settings:

- `API_TOKEN` (required): Your Bright Data API token
- `WEB_UNLOCKER_ZONE` (optional): Zone name for web unlocker (default: mcp_unlocker)
- `BROWSER_ZONE` (optional): Zone name for browser (default: mcp_browser)
- `PRO_MODE` (optional): Enable pro mode tools (true/false)
- `RATE_LIMIT` (optional): Rate limit in format '100/1h' or '50/30m'

## Keeping Up to Date with the Original Repository

This repository includes a script (`update_from_upstream.sh`) that can be used to update your fork with changes from the original Bright Data MCP repository while preserving the Heroku-specific changes.

To update:

```bash
./update_from_upstream.sh
```

## Files Added for Heroku Compatibility

- `app.json`: Configuration for Heroku deployment
- `Procfile`: Process type definitions for Heroku
- `verify_heroku_config.js`: Script to verify Heroku configuration
- `update_from_upstream.sh`: Script to update from upstream repository
- `README_HEROKU.md`: This file

## Original README

For details about the Bright Data MCP, please refer to the [original README](README.md).