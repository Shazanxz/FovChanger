# FOV Changer

A Lua script for SA-MP (San Andreas Multiplayer) that gives you full control over your Field of View (FOV) adjust it in real time through a sleek ImGui interface.

![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
---

## Features

- Adjust FOV freely between **30** and **120** using an interactive slider
- Enable or disable the custom FOV at any time — resets to the default (70.0) when disabled
- **Sniper-aware**: automatically restores the default FOV when holding a sniper rifle, then re-applies your custom value when you switch back
- Dark purple-themed UI built with ImGui

---

## Requirements

- [SAMPFUNCS](https://www.mixmods.com.br/2019/02/sampfuncs-v5-4-1-final/)
- [moonloader](https://www.mixmods.com.br/2020/10/moonloader/) (Lua scripting engine for GTA SA)
- Lua libraries: `imgui`, `inicfg`, `encoding` (included with moonloader)

---

## Installation

1. Download `fov.lua`.
2. Place it inside your moonloader scripts folder:
   ```
   GTA San Andreas/moonloader/
   ```
3. Launch GTA SA and SA-MP. The script loads automatically.

---

## Usage

| Action | Description |
|---|---|
| `/fov` | Opens / closes the FOV Changer window |
| **Enable** checkbox | Toggles the custom FOV on or off |
| **FOV slider** | Drag to set your desired FOV (30–120) |

All changes are saved automatically to `FOVSettings`.

---

<div align="center">

![Dev](https://img.shields.io/badge/Developed_by:-Shazanxz-ED1C24?style=for-the-badge&logoColor=white)

</div>
