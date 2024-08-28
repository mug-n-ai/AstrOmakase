---
layout: default
title: AstrOmakase
---


<div class="centered-container">
  <div class="centered-title">
    AstrOmakase
  </div>
  <img src="assets/img/icon.png" alt="AstrOmakase icon" width="200" class="centered-icon"/>
  <a href="https://github.com/LorenzoMugnai/AstrOmakase" class="github-button">
    <img src="{{ '/assets/img/github-logo.png' | relative_url }}" alt="GitHub logo" width="20" height="20"/>
    View on GitHub
  </a>
</div>

<div style="margin-bottom: 20px;"></div>


Welcome to **AstrOmakase**! This project is an optimized Ubuntu setup specifically designed for astronomers and astrophysicists. By building on the [Omakub project](https://github.com/basecamp/omakub), AstrOmakase offers a curated and comprehensive environment that includes all the essential tools needed for astronomical research.

## What is AstrOmakase?

AstrOmakase is more than just a collection of software; it's a thoughtfully crafted setup intended to streamline your research workflow. The name "AstrOmakase" combines "astronomy" with the Japanese word "omakase," which means "I'll leave it up to you." In the same way that an omakase dining experience involves the chef selecting and preparing a personalized meal, AstrOmakase provides a tailored software environment, so you can focus on your research without worrying about configuring each tool individually.

## Relationship with Omakub

AstrOmakase is built on the foundation of the Omakub project. It can function with or without a prior installation of Omakub, though installing Omakub first is recommended for the best experience. Omakub provides a base setup, and AstrOmakase enhances it by adding tools and configurations specifically relevant to the field of astronomy.

<div style="margin-bottom: 20px;"></div>

<div class="centered-container">
  <img src="assets/img/desktop.png" alt="AstrOmakase icon" width="900" class="centered-icon"/>
</div>

<div style="margin-bottom: 20px;"></div>

## The Menu

AstrOmakase comes packed with a range of tools that cater to both general and astronomy-specific needs. Here are some of the key tools included:

### General Tools

- **Anaconda**: A powerful distribution for Python and R programming languages, widely used for scientific computing. Anaconda includes popular data science libraries such as NumPy, SciPy, and Matplotlib.
- **Chrome browser**: A fast, secure, and easy-to-use web browser.
- **GIMP**: GNU Image Manipulation Program, a versatile graphics editor.
- **HDFCompass**: A tool for browsing and analyzing HDF5 data.
- **Kdiff3**: A diff and merge program for comparing files and directories.
- **OBS Studio**: A free and open-source software for video recording and live streaming.
- **OnlyOffice**: An office suite for document editing, project management, and CRM compatible with Microsoft Office.
- **Okular**: A document viewer for PDF, PostScript, DjVu, and other formats.
- **PDFsam**: A tool to split and merge PDF files.
- **Precommit**: A framework for managing and maintaining multi-language pre-commit hooks.
- **qBTorrent**: A BitTorrent client for downloading files.
- **VLC Media Player**: A versatile media player that can play most multimedia files and streaming protocols.
- **rSync**: A utility for efficiently transferring and synchronizing files.
- **rClone**: A command-line program to manage files on cloud storage.
- **Xournal++**: A PDF editor and note-taking application.
- **Zed**: A high-performance, multiplayer code editor.

### Console Tools

- **fastfetch**: A fast system information tool written in Rust.
- **fd**: A simple, fast, and user-friendly alternative to `find`.
- **htop** and **btop** two interactive process viewers for Unix systems.
- **lt**: A tool for listing files and directories in a tree-like format.
- **plocate**: A tool for quickly locating files on the filesystem.
- **screen**: A terminal multiplexer that allows multiple windows within a single terminal session.
- **zoxide**: A fast, flexible, and smart directory jumper.


### Astronomy Tools

- **SAOImage DS9**: For astronomical imaging and data visualization.
- **Stellarium**: Shows a realistic sky in 3D, just like what you see with the naked eye, binoculars, or a telescope.
- **Zotero**: Helps in organizing research papers and citations.

### Optional Tools

Additional optional tools include:

- **Brave Browser**: A privacy-focused web browser that blocks ads and trackers.
- **Discord**: A communication platform for chat and voice, useful for collaborative projects.
- **Dropbox**: Cloud storage service for easy file sharing and backup.
- **Franz**: A messaging app that combines multiple chat services into one application.
- **gdm-settings**: A tool for customizing GNOME Display Manager settings.
- **LaTeX Studio**: A comprehensive LaTeX editor for creating scientific documents.
- **NordVPN**: A secure VPN service for protecting your online privacy.
- **ScrCPy**: A screen mirroring application for Android devices.
- **Slack**: A collaboration hub that connects teams.
- **SuperPaper**: A multi-monitor wallpaper manager.
- **Speedtest**: A tool for testing internet speed.
- **Zoom**: A video conferencing tool for meetings and webinars.
- **Upscayl**: A tool for upscaling images using AI. 

These tools can be installed based on personal preference and specific needs.

## Installation

AstrOmakase simplifies the setup process, allowing you to focus on your research without the hassle of manual configuration.

### Step 1 (Optional): Install Omakub

For the best experience and specifically for code-oriented work, it is recommended to install Omakub first:

<div class="code-container">
  <pre><code>wget -qO- https://omakub.org/install | bash</code></pre>
  <i class="fas fa-copy copy-icon"></i>
</div>

### Step 2: Install AstrOmakase

Install AstrOmakase on your Ubuntu 24.04 system with the following command:

<div class="code-container">
  <pre><code> wget -qO- https://lorenzomugnai.github.io/AstrOmakase/installer.sh | bash</code></pre>
  <i class="fas fa-copy copy-icon"></i>
</div>


## Acknowledgments

Special thanks to the developers of the  [Omakub project](https://github.com/basecamp/omakub) for their inspiration and hard work. Their foundational setup has made it possible for AstrOmakase to exist and thrive.
