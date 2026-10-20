# Astra-ColorTK

[Astra Productions Color Toolkit](https://astraproductions.com/project/colortoolkit/) for [Pixera](https://pixera.one/)

_ColorTK is a toolset that provides industry standard color grading and adjustment tools for users of the Pixera media server platform._

## Quick Start

**Looking for the Pixera Shader pack and control app?**

Go to [Releases](https://github.com/flowb/Astra-ColorTK/releases) to download the latest version ---->

## Introduction

For a quick overview of the goals of the project please visit this site:
https://astraproductions.com/project/colortoolkit/

ColorTK has two principal components:

1. The **Shader** pack: a set of GLSL effects that are formatted for use in Pixera
2. **ColorTK Control App**: a control interface that communicates with Shader instances running in Pixera

## Getting Started

If you are looking to get started with ColorTK, the best way is to go to the releases tab, download the current version and follow the installation instructions.

If you run into any problems please create an **Issue** using the Issues tab at the top of this page.

## Installation

### Windows (installer)

Download `AstraColorTK_<version>_x64-setup.exe` from [Releases](https://github.com/flowb/Astra-ColorTK/releases) and run it. It installs the control app and copies the `Astra-ColorTK` shader folder into **every Pixera installation it finds** under:

```
C:\Program Files\AV Stumpfl\Pixera\<build>\data\effects\current\
```

It also keeps a reference copy of the shaders in the app's install folder under `Shaders\`. If no Pixera installation is found, the installer tells you and leaves only that reference copy to place by hand.

Restart Pixera after installing so it picks up the new effects.

The Windows build is **not code-signed**, so SmartScreen will warn you: choose *More info* -> *Run anyway*.

Note: uninstalling the app does **not** remove the shaders from your Pixera installations; delete those folders manually if you want them gone.

### macOS

Download `Astra.ColorTK_<version>_universal.dmg` from [Releases](https://github.com/flowb/Astra-ColorTK/releases), open it and drag **Astra ColorTK** into Applications. It runs on Apple Silicon and Intel Macs (macOS 11 or later) and is signed and notarized, so it opens without Gatekeeper warnings.

The DMG contains only the control app. Install the shader pack on the Pixera machine, either with the Windows installer or by hand as described below.

### Manual shader install (any platform)

Download `Astra-ColorTK-Shaders_<version>.zip` from [Releases](https://github.com/flowb/Astra-ColorTK/releases), unzip it, and copy the `Astra-ColorTK` folder into your Pixera effects directory:

```
C:\Program Files\AV Stumpfl\Pixera\<build>\data\effects\current\
```

Then launch the control application for your platform.

## Demo Videos

_These installation and usage demo videos were produced with the TouchDesigner based controller. The binary applications do not require TouchDesigner._

_The installation video predates the Windows installer and shows the manual copy method - see **Installation** above for the current process. The usage video still applies._

[Installation](https://www.youtube.com/watch?v=eJ9LfZCT35c)

[Usage](https://www.youtube.com/watch?v=u6CwPqfHqEQ)
