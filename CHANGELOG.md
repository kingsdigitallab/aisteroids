## v0.4.0 (2025-03-20)

### Feat

- **main**: integrate background into main game loop
- **background**: add starry background

### Refactor

- **main**: update game stats display for improved layout and readability
- **fonts**: adjust font size calculation for better ratios
- **collision**: remove redundant comments
- **welcomestate**: adjust title position in welcome screen for better balance

## v0.3.0 (2025-03-18)

### Feat

- **main**: implement background music control and integrate audio utility
- **welcomestate**: integrate font management and expand instructions
- **player**: add thrusting sound
- **bullet**: play laser sound when a bullet is created
- **audio**: add audio assets and utility for sound management
- **fonts**: add new font assets and utility for font management

### Refactor

- **stock**: update how the segments and size values are calculated

## v0.2.1 (2025-03-15)

## v0.2.0 (2025-03-11)

## v0.1.0 (2025-03-11)

### Feat

- **game**: implement welcome screen with interactive state and music
- **music**: add background music track for game
- **music**: add CSV stock data to audio conversion script
- **states**: add welcome screen
- **colours**: add collision color palette
- **gamestate**: add ship collision time tracking
- **main**: improve player collision and shield mechanics

### Refactor

- **colours**: add alpha channel to UI color definitions
- **data**: remove CSV to JSON conversion utility script
- **data**: move CSV to Lua data conversion script to data directory
- **main**: improve game controls and level progression
- **player**: update module imports and draw function
