# MultiButton

A minimal iPhone 17 app that adds a **Detect iPhone Orientation** action to
Apple Shortcuts. The action returns one of seven values:

- Top edge up
- Top edge down
- Left edge down
- Right edge down
- Screen facing up
- Screen facing down
- Could not determine

## Installation

1. Open `MultiButton.xcodeproj` in Xcode 26 or later.
2. Select your development team under Signing & Capabilities.
3. Connect your iPhone, select it as the run destination, and click Run.
4. Launch MultiButton once on the iPhone.

## Action Button setup

1. Create a new shortcut in the Shortcuts app.
2. Add MultiButton's **Detect iPhone Orientation** action.
3. Add `If` blocks for the orientation values and the system actions you want.
4. Open Settings > Action Button > Shortcut and select your new shortcut.

## Resource usage

The app has no networking, database, analytics, persistent background services,
or third-party dependencies. Core Motion starts for 160 ms only while the action
runs and stops immediately afterward. Release builds use `-Osize`, whole-module
optimization, dead-code stripping, and binary stripping.

The action prefers background execution and also supports dynamic foreground
execution for compatibility with different Shortcuts environments.
# multibutton_actionbutton
