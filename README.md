### AstrOmakase

<img src="content/icon.png" alt="content/icon.png" width="200"/>

<!-- ![Ubuntu OS](https://img.shields.io/badge/Ubuntu%20OS-24.04-green?style=flat&logo=ubuntu)
![Version](https://img.shields.io/badge/Version-0.1.0-blue?style=flat) -->

**AstrOmakase** is a research and astronomy-oriented version optimized for the [Omakub project](https://github.com/basecamp/omakub), designed for astronomers and astrophysicists. The project enhances the original Omakub setup with additional tools and configurations relevant to astronomy.

AstrOmakase is an installer that helps users download all the packages useful for astronomical research. It includes all the packages that, according to the maintainers, are useful for Ubuntu. We invite the community to participate and enhance this package.


Similar to Omakub, the name AstrOmakase is derived from "astronomy" and the Japanese word "omakase," which means "I'll leave it up to you." In Japanese cuisine, omakase is a style of dining where the chef selects and prepares the meal, offering a curated and customized experience. Similarly, AstrOmakase provides a tailored setup optimized for astronomy research, allowing users to focus on their work without worrying about configuring each tool individually.


### Relation with Omakub

AstrOmakase is based on Omakub and can function with or without a prior installation of Omakub. However, for the best experience, it is recommended to install Omakub before proceeding with the installation of AstrOmakase.

### The Menu

Here is a list of tools included in AstrOmakase that are added to the standard Omakub setup:

#### General Tools

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

#### Astronomy Tools

- **SAOImage DS9**: An astronomical imaging and data visualization application.
- **Stellarium**: A planetarium software that shows exactly what you see when you look up at the stars.
- **Zotero**: A reference management tool for organizing research papers and citations.

Additionally, compared to the standard Omakub setup, some tools that are not commonly used in the astronomy field, such as game emulators and media players, have been removed.

#### Optional Tools

- **Brave Browser**: A privacy-focused web browser that blocks ads and trackers.
- **Discord**: A communication platform for chat and voice, useful for collaborative projects.
- **Dropbox**: Cloud storage service for easy file sharing and backup.
- **Franz**: A messaging app that combines multiple chat services into one application.
- **LaTeX Studio**: A comprehensive LaTeX editor for creating scientific documents.
- **NordVPN**: A secure VPN service for protecting your online privacy.
- **ScrCPy**: A screen mirroring application for Android devices.
- **Slack**: A collaboration hub that connects teams.
- **SuperPaper**: A multi-monitor wallpaper manager.
- **Speedtest**: A tool for testing internet speed.
- **Zoom**: A video conferencing tool for meetings and webinars.
- **Upscayl**: A tool for upscaling images using AI.

### Installation

AstrOmakase simplifies the setup process, allowing you to focus on your research and development tasks without the hassle of configuring each tool manually.

**Note:** AstrOmakase can be installed with or without Omakub. However, for the best experience, it is recommended to install Omakub first.

#### Step 1 (optional): Install Omakub

For a better experience and specifically for code-oriented work, it is suggested to install **Omakub** first:

```bash
wget -qO- https://omakub.org/install | bash
```

#### Step 2: Install AstrOmakase

Run the script below to install AstrOmakase on your Ubuntu 24.04 system:

```bash
wget -qO- https://lorenzomugnai.github.io/AstrOmakase/installer.sh | bash
```

During the installation, if Omakub is not present, you installerwill be prompted whether to proceed anyway.

### Contributions
We welcome contributions! To contribute, follow these steps:

Fork the repository.
Create a new branch for your feature (`git checkout -b feature/feature-name`).
Commit your changes (`git commit -m 'Add feature'`).
Push the branch (`git push origin feature/feature-name`).
Open a Pull Request.
