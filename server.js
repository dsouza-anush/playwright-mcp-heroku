#!/usr/bin/env node
/**
 * Wrapper script for Playwright MCP that automatically detects and uses the appropriate transport mode
 * This helps ensure compatibility with Heroku Inference
 */

// Determine if this process is being run as an MCP tool (via STDIO) or a web server
// For Heroku, if the process name starts with "mcp-", it's being run as an MCP tool
const isMcpProcess = process.env.DYNO && process.env.DYNO.startsWith('mcp-');

// Import the CLI module and pass the appropriate args
if (isMcpProcess) {
  // When running as MCP process, don't specify a port to use STDIO mode
  console.error('Starting MCP server in STDIO mode');
  process.argv = [
    process.argv[0], 
    process.argv[1], 
    '--headless', 
    '--browser', 'chromium', 
    '--no-sandbox'
  ];
} else {
  // When running as web server, use HTTP mode with port and host
  console.error('Starting web server in HTTP mode');
  process.argv = [
    process.argv[0], 
    process.argv[1], 
    '--host', '0.0.0.0', 
    '--port', process.env.PORT || '3000', 
    '--headless', 
    '--browser', 'chromium', 
    '--no-sandbox'
  ];
}

// Import and run the actual CLI
import('./cli.js');