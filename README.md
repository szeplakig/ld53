# Ludum Dare 53
# AstroFreight  


## Theme:

DELIVERY

## Concept:

A game where you must deliver supplies to a space station in a 2D space environment.

## Instructions:
```
Welcome to AstroFreight!

Controls:
- Move: Arrow keys/WASD
- Interact: Spacebar/F

Objective:
- Complete delivery assignments by transporting cargo from the central station to various space stations.
- Follow the on-screen arrow pointing towards the target space station.
- Be cautious with dangerous cargo! Avoid collisions with obstacles.
- After delivering the cargo, return to the central station to receive your payment and a new assignment.

Good luck, pilot!
```
## Design:

### Controls:
- Arrow keys/WASD: Move the player's ship
- Spacebar: Interact with the space station to deliver supplies

### Objective: 
- Deliver as many supplies as possible to the space station within the time limit (e.g., 60 seconds).
- Avoid colliding with obstacles like asteroids and space debris, which will cause a loss of time or even end the game.

### Gameplay:
- The player's ship starts at a central station located next to a Planet. The Planet is parallax scrolling in the background to create a sense of depth.
- Complete delivery assignments by transporting cargo from the central station to various space stations.
- Follow the on-screen arrow pointing towards the target space station.
- Some cargo is dangerous and cannot be bumped or collided with obstacles.
- Dangerous cargo can include explosive materials, radioactive substances, or volatile chemicals.
- If the player's ship carrying dangerous cargo bumps into an obstacle, the cargo is destroyed, the cargo is connected with tethers.
- Once the player reaches the space station, they must press the spacebar to deliver the supplies.
- After delivering the cargo, return to the central station to receive payment and a new assignment.
- The player must navigate through randomly generated obstacles to reach the space station.
- The player's score is based on the number of successful deliveries made.


# Art Assets Checklist

This checklist contains all the necessary art assets for the AstroFreight game, described in detail.

## Background

- [ ] **Space Background**: A dark blue or black canvas with small white dots scattered throughout to represent stars.

## Player Ship

- [ ] **Player Ship**: A small, simple triangle-shaped ship. Consider using a bright color, like green or yellow, to make it stand out against the background.

## Central Station

- [ ] **Central Station**: A larger and more detailed circle or hexagon shape, representing the central station where the player's ship starts. The central station can have a unique color or pattern to differentiate it from other space stations.

## Target Space Stations

- [ ] **Target Space Stations**: Smaller circles with slightly thicker outlines to represent the destination for delivering cargo. They can be colored in contrasting hues, like blue or red, to stand out from the central station.

## Obstacles

- [ ] **Asteroids**: Square or rectangular shapes with varying sizes, representing space debris and asteroids. Use shades of gray or brown to convey their rocky nature.
- [ ] **Other Space Debris**: Optionally, include additional types of obstacles, such as broken satellites or space junk, using simple geometric shapes and a limited color palette.

## Cargo

- [ ] **Cargo**: Simple geometric shapes, like rectangles or hexagons, to represent cargo. Use different colors or patterns to indicate dangerous cargo types.

- [ ] **Tether**: A thin line or chain connecting the player's ship to the cargo. The tether should have a distinct color to make it visible against the background and other game elements.

## Planet

- [ ] **Planet**: A simple circular or elliptical shape, placed in the background as a parallax element to create depth. The planet can have a unique color, texture, or pattern to make it visually interesting.

## User Interface

- [ ] **On-screen Arrow**: A small, bright-colored arrow pointing towards the target space station. Ensure the arrow is clearly visible and stands out against the background.

- [ ] **Game Timer**: A simple, easily readable font and color for displaying the remaining time on-screen.
- [ ] **Score Display**: A consistent font and color for displaying the player's score during gameplay.
- [ ] **Instructions Screen**: Clean and simple text design for the instructions screen, using a font that is easy to read and understand.

## Miscellaneous

- [ ] **Game Logo**: A minimalistic game logo featuring the game's title, "AstroFreight," possibly incorporating the player ship, central station, or planet in the design.
- [ ] **Game Over/Success Screen**: Simple text design for the "Game Over" or "Success" screen, indicating the player's final score and encouraging them to try again.

## Author:
- Gergely Széplaki (Remus)
- Software Developer
- 2023.04.29. - 2023.04.29.
