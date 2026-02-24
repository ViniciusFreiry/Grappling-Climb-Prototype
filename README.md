# 🪝 Grappling Climb Prototype

A 2D physics-based climbing game built in GameMaker Studio 2 using GML.

This project explores non-conventional player movement through a grappling hook mechanic, requiring precision timing, swing control, and terrain interaction to reach the top of the level.

---

## 📌 Overview

In this game, the player does not move using traditional platformer controls.

Instead, movement is entirely based on a grappling hook system:

- The player shoots a hook toward valid anchor points.
- The character is pulled toward the hook.
- A swinging motion is generated.
- The player must release at the correct timing to gain momentum.

The goal is to reach the top of the game world.

Currently, the project contains 20 rooms forming a vertical progression structure.

---

## 🛠 Engine & Tech

- GameMaker Studio 2 (GMS2)
- GML (GameMaker Language)
- 2D physics-based motion (custom swing logic)

---

## ⚙️ Core Systems

### 🪝 Grappling Hook Movement System

- Hook projectile logic
- Anchor detection
- Pull force application
- Swing motion simulation
- Momentum preservation
- Manual release mechanic

The system avoids traditional horizontal walking mechanics, relying fully on physics-driven traversal.

---

### 🧱 Terrain Interaction System

The game includes multiple terrain types with unique behavior:

- **Normal Ground**  
  Immediate stop on contact.

- **Ice Surface**  
  Reduced friction causing sliding movement.

- **Slime Surface**  
  Bounce effect, increasing vertical and horizontal momentum.

- **Bridge Platform**  
  One-way collision: only solid when the player is above it.

Each terrain modifies player physics behavior dynamically.

---

### 🏔 Vertical Progression System

- 20 interconnected rooms
- Upward progression goal
- Falling requires reclimbing

This creates tension and precision-based gameplay.

---

## 🧠 System Architecture

### Movement Logic

- Grapple state management
- Swing state
- Release state
- Falling state
- Surface interaction override

Movement is state-driven to maintain clarity and avoid conflicting physics behavior.

---

### Collision Handling

- Conditional platform collision
- Surface-based friction control
- Momentum preservation across states

---

## 🔍 QA-Oriented Testing Notes

Tested scenarios include:

- Grapple attachment edge cases
- Multiple rapid hook shots
- Swing angle boundary conditions
- Release timing at extreme velocities
- Ice sliding consistency
- Slime bounce stacking behavior
- One-way platform collision validation
- Room transition stability

---

## 🚧 Current Limitations

- No checkpoint save system
- No difficulty scaling system
- No stamina or hook limitation
- No score system

---

## 🧪 Performance Considerations

- Lightweight physics calculations
- Minimal object instantiation
- Efficient room transitions
- State-driven movement logic

---

## 🚀 Possible Improvements

- Checkpoint save system
- Speedrun timer
- Environmental hazards

---

## 📂 Project Structure (Simplified)

objects/
 ├── o_player
 ├── o_hook
 ├── o_solid
 ├── o_solid_ice
 ├── o_solid_gum
 ├── o_solid_bridge

rooms/
 ├── rm_map

scripts/
 ├── player_processes

---

## 🎯 Learning Goals

This project explores:

- Physics-based traversal mechanics
- Momentum-driven gameplay
- State machine architecture
- Terrain-based behavior modification
- Vertical level design
- Precision timing mechanics

---

## 📜 License

This project is for educational and portfolio purposes.