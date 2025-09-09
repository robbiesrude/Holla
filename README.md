# Holla Pager

Lua modules implementing the Holla pager UI for Roblox. All UI is created via code.

## Structure

- `src/Config.lua` – central configuration for webhooks, departments, and data store names.
- `src/App.lua` – main application controller.
- `src/pages/*.lua` – individual page constructors (Startup, Home, InGame, Notes, Settings, Help, NoLicense).
- `src/server/init.server.lua` – creates RemoteEvents/Functions for chat, notes, device requests, and license checks.
- `src/init.lua` – entry module returning a function to start the app for a player.

The scripts are designed to be inserted into Roblox Studio and required from a LocalScript.
