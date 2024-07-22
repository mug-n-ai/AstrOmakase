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
  <img src="assets/img/desktop.png" alt="AstrOmakase icon" width="700" class="centered-icon"/>
</div>

<div style="margin-bottom: 20px;"></div>

## The Menu

AstrOmakase comes packed with a range of tools that cater to both general and astronomy-specific needs. Here are some of the key tools included:

### General Tools

- **Anaconda**: Essential for scientific computing, Anaconda includes popular data science libraries such as NumPy, SciPy, and Matplotlib.
- **Chrome Browser**: Fast, secure, and user-friendly.
- **GIMP**: A versatile graphics editor.
- **HDFCompass**: Ideal for browsing and analyzing HDF5 data.
- **Kdiff3**: Useful for comparing files and directories.
- **LibreOffice**: Comprehensive office suite.
- **OBS Studio**: For video recording and live streaming.
- **Okular**: Document viewer supporting various formats.
- **PDFsam**: Tool for splitting and merging PDF files.
- **Precommit**: Framework for managing multi-language pre-commit hooks.
- **Transmission**: BitTorrent client.
- **VLC Media Player**: Versatile multimedia player.
- **rSync**: Efficient file transfer and synchronization utility.
- **rClone**: Manages files on cloud storage.

### Astronomy Tools

- **SAOImage DS9**: For astronomical imaging and data visualization.
- **Stellarium**: Shows a realistic sky in 3D, just like what you see with the naked eye, binoculars, or a telescope.
- **Zotero**: Helps in organizing research papers and citations.

### Optional Tools

Additional optional tools include Brave Browser, Discord, Dropbox, Franz, LaTeX Studio, NordVPN, ScrCPy, Slack, SuperPaper, Speedtest, Zoom, and Upscayl. These tools can be installed based on personal preference and specific needs.

## Installation

AstrOmakase simplifies the setup process, allowing you to focus on your research without the hassle of manual configuration.

### Step 1 (Optional): Install Omakub

For the best experience, it is recommended to install Omakub first:

<div class="code-container">
  <pre><code>wget -qO- https://omakub.org/install | bash</code></pre>
  <button class="copy-btn">Copy</button>
</div>

### Step 2: Install AstrOmakase

Install AstrOmakase on your Ubuntu 24.04 system with the following command:

<div class="code-container">
  <pre><code>wget -qO- https://raw.githubusercontent.com/LorenzoMugnai/AstrOmakase/master/boot.sh | bash</code></pre>
  <button class="copy-btn">Copy</button>
</div>

## Acknowledgments

Special thanks to the developers of the  [Omakub project](https://github.com/basecamp/omakub) for their inspiration and hard work. Their foundational setup has made it possible for AstrOmakase to exist and thrive.