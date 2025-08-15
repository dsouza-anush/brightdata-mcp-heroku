# Bright Data MCP for Heroku

<p align="center">
  <a href="https://heroku.com/deploy?template=https://github.com/dsouza-anush/brightdata-mcp-heroku">
    <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy to Heroku">
  </a>
</p>

This is a fork of the [Bright Data MCP](https://github.com/brightdata/brightdata-mcp) repository, adapted for deployment on Heroku.

## Configuration

After deployment, make sure to set the following environment variables in your Heroku app settings. Note that the app is configured to scale to 0 web dynos when not in use, which is recommended for MCP servers:

- `API_TOKEN` (required): Your Bright Data API token
- `WEB_UNLOCKER_ZONE` (optional): Zone name for web unlocker (default: mcp_unlocker)
- `BROWSER_ZONE` (optional): Zone name for browser (default: mcp_browser)
- `RATE_LIMIT` (optional): Rate limit in format '100/1h' or '50/30m'

## Using with Heroku Inference

This MCP server can be registered with Heroku Inference to provide web data access to LLMs. Follow these steps:

1. Deploy the app to Heroku using the button above
2. Configure your API_TOKEN and other environment variables
3. Register the MCP server with your Heroku Managed Inference model using this command:

```bash
heroku ai:models:create MODEL_NAME -a YOUR_APP_NAME --as INFERENCE
```

Or attach it to an existing model:

```bash
heroku addons:attach MODEL_RESOURCE -a YOUR_APP_NAME --as INFERENCE
```

The MCP server uses the process name `mcp-brightdata` for registration with Heroku Inference.

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