# A(I)steroids

A(I)steroids is an [Asteroids](<https://en.wikipedia.org/wiki/Asteroids_(video_game)>)
clone developed in the [Love2D](https://love2d.org/) framework. The classic
Asteroids game mechanics are used as a metaphor for the volatile and fragmented
nature of AI technology and markets.

Larger asteroids splitting into smaller ones mimics how AI technologies branch
into specialised applications. The player's struggle to navigate/defend through
chaos reflects our attempt to make sense of rapid AI delopments and the lack of
consistent or planned-ahead regulation.

Using stock prices to generate asteroids characteristics also creates an
interactive data visualition. Game mechanics are used to explore market
volatility through:

- asteroid size based on stock's last price
- asteroid colour reflects price change (last - open): green for gains, darker
  red for larger losses
- asteroid segments scale with trading volume
- asteroid line width matches daily price range (high - low)
- asteroid rotation speed tied to price change magnitude: clockwise for gains,
  counter-clockwise for losses
- asteroid speed correlates to daily stock volatility

## Structure

- `src/`: Source code
  - `data/`: Data files
  - `entities/`: Entity components, e.g. player, asteroid, bullet
  - `systems/`: Systems components, e.g. collision detection
  - `utils/`: Utility components, e.g. colours
  - `states/`: Game state components, e.g. game state, game over
- `assets/`: Assets
- `conf.lua`: Configuration
- `main.lua`: Entry point and game loop
- `README.md`: This file

## Running the game

To run the game, you need to have [Love2D](https://love2d.org/) installed, and a
copy of this repository. Then, navigate to the directory containing the cloned
repository and run the command:

```bash
love .
```

## TODO

- [ ] Add explosion on ship collision
- [ ] Add a title screen
- [ ] Add a game over screen
- [ ] Add a sound effect for the bullet
- [ ] Add a sound effect for the asteroid collision
- [ ] Add a sound effect for the ship explosion
- [ ] Add a sound effect for the asteroid explosion
- [ ] Add a sound effect for the asteroid hit
- [ ] Add a restart option
- [ ] Add a quit option
- [ ] Add other ships
