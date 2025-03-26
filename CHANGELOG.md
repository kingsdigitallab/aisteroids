# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v0.9.1 (2025-03-26)

## v0.9.0 (2025-03-26)

### Feat

- **icons**: add asteroid icons in various formats (icns, ico, png)

## v0.8.0 (2025-03-23)

### Feat

- **main**: add level transition logic
- **gamestate**: add level transition screen

### Fix

- **audio**: ensure asteroid hit sound stops before replaying

### Refactor

- **main**: remove unused game state variables
- **background**: add random opacity to the background stars

## v0.7.0 (2025-03-23)

### Feat

- **main**: integrate debris handling in game logic
- **debris**: add debris entity for asteroid destruction

### Refactor

- **asteroid**: improve asteroid creation and drawing logic

## v0.6.0 (2025-03-22)

### Feat

- **gamestate**: implement game drawing logic to display score, level, ships, and game states
- **asteroid**: include stock value in asteroid creation and splitting logic
- **stock**: add value property to asteroid options

### Fix

- **main**: prevent player key presses when the game is paused, handle game over state
- **main**: prevent key presses when the game is paused

### Refactor

- **player**: change player ship polygon from 'line' to 'fill'
- **main**: move game state drawing logic to gamestate module for better organisation
- **welcomestate**: update commands instruction to include pause command
- **score**: update scoring system to reflect stock values and format score display

## v0.5.1 (2025-03-21)

### Fix

- **audio**: rename asteroid sound effect function to reflect collision event

## v0.5.0 (2025-03-21)

### Feat

- **main**: play sound effects for asteroid collision and ship explosion
- **audio**: add new sound effects for ship explosion and asteroid hit
- **main**: enhance level navigation and add pause
- **gamestate**: add pause functionality and previous level navigation
- **background**:  generate stars based on screen width

### Refactor

- **colours**: update player ship and shield colors with alpha values
- **asteroid**: adjust label positioning for better readability
- **player**: set player ship colour
- **main**: improve the game over message

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
