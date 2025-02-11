# LuigiTech


<p align=center><img src="./assets/img/luigi-hero.png" width=33%></p>

It's-a me, Luigi, and I'm-a tired of being second best! You know, always playing catch-up to my... ahem... brother... 👀

But then I discovered the LuigiTech, and it's-a been a game-changer!<br>
This highly customizable Lua script is the power-up I needed to take my Logitech gear to the next level. 
&nbsp; — <samp> "Isn't she a beaut?"</samp>

With LuigiTech, I can fine-tune my device's responsiveness and create custom macros that give me the edge I need to rescue the princess — *"and* ***finally*** *get the recognition* ***I deserve!***"

It's-a not just about winning; it's-a about being the best version of myself.
As I always say,<br>&nbsp; — <samp>"It's-a not just about the hardware, it's-a about the software too!"</samp><br>
LuigiTech lets me adjust settings and macro triggers on the fly, so I can stay one step ahead of the competition. And when I'm in the heat of battle, I can rely on my trusty LuigiTech to help me ***power-up*** my way to victory!

So, you're tired of being stuck in the shadows?<br>
Together, we can show the world what we're made of. After all,<br>&nbsp; <samp> — "I'm-a Luigi, number one!"</samp><br>And with LuigiTech, you can be number one too!


## Features

- Dynamic recoil compensation adjustment
- Configurable delay between compensations
- Automatic reload detection
- Real-time feedback through log messages
- Toggle controls using NumLock

## Configuration Constants

| Constant | Default | Range | Description |
|----------|---------|-------|-------------|
| DEFAULT_DELAY | 10 | 1-100 | Initial delay between compensations |
| DEFAULT_RECOIL | 1 | 0-10 | Initial recoil compensation value |
| DELAY_MODIFIER | 1 | - | Amount to adjust delay by |
| RECOIL_MODIFIER | 1 | - | Amount to adjust recoil by |

## Controls

### Basic Controls
- **Left Mouse (1) + Right Mouse (3)**: Activate recoil compensation
- **Mouse Wheel (2) + Mouse Forward (5)**: Increase recoil (when NumLock is ON)
- **Mouse Wheel (2) + Mouse Back (4)**: Decrease recoil (when NumLock is ON)

### Features
- **NumLock**: Must be ON to enable recoil adjustments
- **Automatic Reload**: Triggers after 400ms of continuous fire (when NumLock is ON)

## Feedback System

The script provides real-time feedback through log messages:
- Recoil compensation changes
- Fire duration statistics
- Reload notifications

## Technical Details

### Performance Monitoring
- Tracks execution time of recoil compensation
- Reports fire rate and duration statistics
- Clears log before each new firing session

### Safety Features
- Bounded recoil values (0-10)
- Bounded delay values (1-100)
- NumLock toggle for advanced features

## Requirements

- Logitech Gaming Software
- Compatible Logitech gaming mouse
- Lua runtime environment (provided by LGS)

## Usage

1. Load the script into Logitech Gaming Software
2. Enable NumLock for full functionality
3. Hold Right Mouse + Left Mouse to activate compensation
4. Use Mouse Wheel combinations to adjust recoil strength the provides customizable recoil compensation and automatic reload functionality.
