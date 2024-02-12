# Astra-ColorTK

[Astra Productions Color Toolkit](https://astraproductions.com/project/colortoolkit/) for [Pixera](https://pixera.one/)

*ColorTK is a toolset that provides industry standard color grading and adjustment tools for users of the Pixera media server platform.*

## Quick Start

**Looking for the Pixera Shader pack and fxPilot?**

Go to [Releases](https://github.com/flowb/Astra-ColorTK/releases) to download the latest version ---->


## Introduction

For a quick overview of the goals of the project please visit this site:
https://astraproductions.com/project/colortoolkit/



ColorTK has two principal components:

1. The **Shader** pack: a set of GLSL effects that are formatted for use in Pixera
2. **fxPilot**: a control interface that communicates with Shader instances running in Pixera



## Users

If you are looking to get started with ColorTK, the best way is to go to the releases tab, download the current version and follow the installation instructions.

If you run into any problems please create an **Issue** using the Issues tab at the top of this page.

NOTE: **fxPilot** currently requires [TouchDesigner](https://derivative.ca) to run. A standalone control app is in active development.



## Developers

ColorTK is developed using [Derivative TouchDesigner](https://derivative.ca).

The Shader development pipeline is set up so that color filtering and adjustment algorithms can be refined in GLSL function blocks. Build scripts are specified as fields in DATs. 

Control interfaces can be developed, tested and refined directly with the shaders in TD. 

Polling and control of Pixera is by way of the [Pixera API](https://pixera.one/en/downloads/).

The fxPilot.toe project contains the complete development setup, demo shaders, color profiles, widgets for control surfaces and analysis tools like scopes.

This project uses a variant of base_save [base_save](https://github.com/raganmd/touchdesigner-save-external). The releases have been "de-externalized" using provided scripts. 
