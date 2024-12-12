### AstrOmakase

<img src="content/icon.png" alt="content/icon.png" width="200"/>

![Version](https://raw.githubusercontent.com/mug-n-ai/AstrOmakase/master/.github/badges/version.svg)
![Ubuntu OS](https://img.shields.io/badge/Ubuntu%20OS-24.04-green?style=flat&logo=ubuntu)
![license](https://img.shields.io/github/license/mug-n-ai/AstrOmakase)


**AstrOmakase** is a research and astronomy-oriented version optimized for the [Omakub project](https://github.com/basecamp/omakub), designed for astronomers and astrophysicists. The project enhances the original Omakub setup with additional tools and configurations relevant to astronomy.

AstrOmakase is an installer that helps users download all the packages useful for astronomical research. It includes all the packages that, according to the maintainers, are useful for Ubuntu. We invite the community to participate and enhance this package.


Similar to Omakub, the name AstrOmakase is derived from "astronomy" and the Japanese word "omakase," which means "I'll leave it up to you." In Japanese cuisine, omakase is a style of dining where the chef selects and prepares the meal, offering a curated and customized experience. Similarly, AstrOmakase provides a tailored setup optimized for astronomy research, allowing users to focus on their work without worrying about configuring each tool individually.

<img src="docs/_static/desktop.png" alt="desktop" width="600"/>


### Relation with Omakub

AstrOmakase is based on Omakub and can function with or without a prior installation of Omakub. However, for the best experience, it is recommended to install Omakub before proceeding with the installation of AstrOmakase.

### The Menu

Here is a list of tools included in AstrOmakase that are added to the standard Omakub setup:

#### General Tools

- **Anaconda**: A powerful distribution for Python and R programming languages, widely used for scientific computing. Anaconda installation includes popular data science libraries such as **NumPy**, **SciPy**, and **Matplotlib**.
- **Chrome browser**: A fast, secure, and easy-to-use web browser.
- **Flameshot**: A powerful yet simple-to-use screenshot tool.
- **GitHub CLI**: gh is GitHub on the command line.
- **GIMP**: GNU Image Manipulation Program, a versatile graphics editor.
- **Gnome-sushi**: A quick previewer for files in GNOME.
- **HDFCompass**: A tool for browsing and analyzing HDF5 data.
- **Kdiff3**: A diff and merge program for comparing files and directories.
- **krita**: A professional free and open-source painting program.
- **OBS Studio**: A free and open-source software for video recording and live streaming.
- **OnlyOffice**: An office suite for document editing, project management, and CRM compatible with Microsoft Office.
- **Okular**: A document viewer for PDF, PostScript, DjVu, and other formats.
- **PDFsam**: A tool to split and merge PDF files.
- **Precommit**: A framework for managing and maintaining multi-language pre-commit hooks.
- **qBTorrent**: A BitTorrent client for downloading files.
- **rSync**: A utility for efficiently transferring and synchronizing files.
- **rClone**: A command-line program to manage files on cloud storage.
- **Ulauncher**: A fast and lightweight application launcher for Linux, supporting extensions and fuzzy search.
- **VLC Media Player**: A versatile media player that can play most multimedia files and streaming protocols.
- **VSCode**: A versatile and complete coding IDE.
- **Xournal++**: A PDF editor and note-taking application.
- **Zed**: A high-performance, multiplayer code editor.

### Console Emulator

**Warp** terminal is pre-configured with the **Tokyo Night** theme to provide a modern and optimized command-line experience

### Console Tools

- **fastfetch**: A fast system information tool written in Rust.
- **fd**: A simple, fast, and user-friendly alternative to `find`.
- **htop** and **btop** two interactive process viewers for Unix systems.
- **lt (eza)**: A tool for listing files and directories in a tree-like format.
- **nmap**: A network exploration tool and security scanner.
- **pavucontrol**: A volume control tool for PulseAudio.
- **plocate**: A tool for quickly locating files on the filesystem.
- **screen**: A terminal multiplexer that allows multiple windows within a single terminal session.
- **zoxide**: A fast, flexible, and smart directory jumper.

#### Astronomy Tools

- **SAOImage DS9**: An astronomical imaging and data visualization application.
- **Stellarium**: A planetarium software that shows exactly what you see when you look up at the stars.
- **Zotero**: A reference management tool for organizing research papers and citations.

Additionally, compared to the standard Omakub setup, some tools that are not commonly used in the astronomy field have been removed.

#### Optional Tools

- **Brave Browser**: A privacy-focused web browser that blocks ads and trackers.
- **Discord**: A communication platform for chat and voice, useful for collaborative projects.
- **Dropbox**: Cloud storage service for easy file sharing and backup.
- **Franz**: A messaging app that combines multiple chat services into one application.
- **gdm-settings**: A tool for customizing GNOME Display Manager settings.
- **LaTeX Studio**: A comprehensive LaTeX editor for creating scientific documents.
- **NordVPN**: A secure VPN service for protecting your online privacy.
- **remmina**: A remote desktop client for accessing remote desktops.
- **ScrCPy**: A screen mirroring application for Android devices.
- **Slack**: A collaboration hub that connects teams.
- **SuperPaper**: A multi-monitor wallpaper manager.
- **Speedtest**: A tool for testing internet speed.
- **Zoom**: A video conferencing tool for meetings and webinars.
- **Upscayl**: A tool for upscaling images using AI.


### Installation

AstrOmakase simplifies the setup process, allowing you to focus on your research and development tasks without the hassle of configuring each tool manually.


> [!TIP]
> AstrOmakase can be installed with or without Omakub. However, for the best experience, it is recommended to install Omakub first.
> ```bash
> wget -qO- https://omakub.org/install | bash
> ```

Run the script below to install AstrOmakase on your Ubuntu 24.04 system:

```bash
wget -qO- https://mug-n-ai.github.io/AstrOmakase/installer.sh | bash
```

During the installation, if Omakub is not detected, you will be prompted with the option to install it.

>[!IMPORTANT]
>If you choose to install Omakub, the installer will proceed with the Omakub installation.
>**After Omakub is installed**, you will need to log out and log back in to apply the necessary environment changes.
>Once you have logged back in, **rerun the AstrOmakase installation script to complete the setup process**.
>If you choose not to install Omakub:

>[!NOTE]
>If you choose to not install Omakub, the installation will continue without Omakub.
>Note that some features may be limited or unavailable without Omakub.


### Updates

AstrOmakase can be easily updated from the dedicated executable:

<img src="docs/_static/app.png" alt="app" width="600"/>


The app also shows the installed version. The user can launch the application from console running `astromakase`, or with the dedicated launcher.


### Contributions
We welcome contributions! To contribute, follow these steps:

Fork the repository.
Create a new branch for your feature (`git checkout -b feature/feature-name`).
Commit your changes (`git commit -m 'Add feature'`).
Push the branch (`git push origin feature/feature-name`).
Open a [Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).
