Welcome to AstrOmakase's Documentation!
=======================================

.. grid:: 2

   .. grid-item::
      :columns: 3

      .. image:: _static/icon.png
         :width: 200
         :class: sd-m-auto

   .. grid-item-card:: Welcome to AstrOmakase!
      :columns: 9

      **AstrOmakase** is an optimised Ubuntu 24.04 setup specifically designed for astronomers and astrophysicists. It builds on the foundation of the `Omakub project <https://github.com/basecamp/omakub>`_, offering a curated and comprehensive environment that includes all the essential tools needed for astronomical research and development.

What is AstrOmakase?
--------------------

AstrOmakase is more than just a collection of software. It is a thoughtfully crafted setup tailored to streamline your research workflow.

The name "AstrOmakase" combines "astronomy" with the Japanese word "omakase," which means "I'll leave it up to you." Just as in an omakase dining experience, where the chef selects and prepares a personalized meal, AstrOmakase provides a tailored software environment, allowing you to focus on your research without worrying about configuring each tool individually.

.. image:: _static/desktop.png
   :alt: Desktop view of AstrOmakase

Installation
------------

AstrOmakase simplifies the setup process, enabling you to focus on your research and development tasks without the hassle of manual configuration.

.. note::
   AstrOmakase is inspired by the `Omakub project <https://github.com/basecamp/omakub>`_. While it can function independently, it is recommended to install Omakub first for a better experience. For more details, visit the `Omakub website <https://omakub.org/>`_ and `documentation <https://manual.omakub.org/>`_.

   To install Omakub:

   .. code-block:: bash

      wget -qO- https://omakub.org/install | bash


Run the following script to install AstrOmakase on your Ubuntu 24.04 system:

.. code-block:: bash

   wget -qO- https://lorenzomugnai.github.io/AstrOmakase/installer.sh | bash

During the installation, if Omakub is not detected, you will be prompted with the option to install it.

.. important::
   If you choose to install Omakub, the installer will proceed with the Omakub installation.
   **After Omakub is installed**, you will need to log out and log back in to apply the necessary environment changes.
   Once you have logged back in, **rerun the AstrOmakase installation script to complete the setup** process.
   If you choose not to install Omakub:

.. note::
   If you choose to not install Omakub, the installation will continue without Omakub.
   Note that some features may be limited or unavailable without Omakub.

How to Update
--------------

AstrOmakase can be easily updated from the dedicated executable:

.. image:: _static/app.png
   :alt: AstrOmakase launcher

The app also shows the installed version. The user can launch the application from console running `astromakase`, or with the dedicated launcher.

The Menu
--------

Below is a list of tools included in AstrOmakase that are added to the standard Omakub setup. The tools are organised into categories for easy navigation and access.

.. .. toctree::
..    :hidden:
..    :maxdepth: 1

..    Desktop Tools <desktop>
..    Coding Tools <code>
..    Remote Working Tools <remote>
..    Syncing and Backup <sync>
..    Astronomy Tools <astro>
..    Image and Video Editing <image>
..    Console Tools <console>


.. grid:: 2
   :gutter: 1 1 2 2

   .. grid-item-card:: Desktop Tools
      :link: desktop
      :link-type: ref

      This section covers desktop tools such as the office suite, PDF handler, and more.

   .. grid-item-card:: Coding Tools
      :link: coding
      :link-type: ref

      This section covers coding tools such as IDEs, text editors, and version control systems.

   .. grid-item-card:: Remote Working Tools
      :link: remote
      :link-type: ref

      This section covers tools for remote working such as video conferencing and VPN services.

   .. grid-item-card:: Syncing and Backup
      :link: sync
      :link-type: ref

      This section covers tools for syncing and backing up data with clouds or remote servers.

   .. grid-item-card:: Astronomy Tools
      :link: astro
      :link-type: ref

      This section covers tools for astronomical research such as DS9 and Zotero.

   .. grid-item-card:: Image and Video Editing
      :link: image
      :link-type: ref

      This section covers tools for image and video editing such as GIMP and OBS Studio.

   .. grid-item-card:: Console Tools
      :link: console
      :link-type: ref

      This section covers terminal tools for your Linux environment.


General Tools
+++++++++++++

- **Anaconda**: A powerful distribution for Python and R programming, widely used for scientific computing. Includes libraries like **NumPy**, **SciPy**, and **Matplotlib**.
- **Chrome**: A fast, secure, and easy-to-use web browser.
- **Flameshot**: A simple yet powerful screenshot tool.
- **GitHub CLI**: Command-line interface for GitHub (`gh`).
- **GIMP**: GNU Image Manipulation Program, a versatile graphics editor.
- **Gnome-sushi**: A quick file previewer for GNOME.
- **HDFCompass**: A tool for browsing and analyzing HDF5 data.
- **Kdiff3**: A diff and merge program for comparing files and directories.
- **krita**: A professional free and open-source painting program.
- **OBS Studio**: Open-source software for video recording and live streaming.
- **OnlyOffice**: Office suite for document editing, project management, and CRM.
- **Okular**: A versatile document viewer.
- **PDFsam**: A tool for splitting and merging PDF files.
- **PreCommit**: A framework for managing pre-commit hooks across multiple languages.
- **qBittorrent**: A lightweight, open-source BitTorrent client.
- **VLC Media Player**: A media player supporting most multimedia files and streaming protocols.
- **rSync**: A utility for efficient file transfer and synchronization.
- **rClone**: A command-line program to manage files on cloud storage.
- **VSCode**: A complete and versatile code editor.
- **Xournal++**: A PDF annotation and note-taking tool.
- **Zed**: A high-performance multiplayer code editor.

Console Emulator
+++++++++++++++++

**Warp** terminal is pre-configured with the **Tokyo Night** theme to provide a modern and optimized command-line experience


Console Tools
+++++++++++++

- **fastfetch**: A fast system information tool written in Rust.
- **fd**: A simple, fast, and user-friendly alternative to `find`.
- **htop** and **btop**: Two interactive process viewers for Unix systems.
- **lt**: A tool for listing files and directories in a tree-like format.
- **nmap**: A network exploration tool and security scanner.
- **pavucontrol**: A volume control tool for the PulseAudio sound server.
- **plocate**: A tool for quickly locating files on the filesystem.
- **screen**: A terminal multiplexer for managing multiple windows in a single session.
- **zoxide**: A fast, flexible, and smart directory jumper.

Astronomy Tools
+++++++++++++++

- **SAOImage DS9**: An application for astronomical imaging and data visualisation.
- **Stellarium**: A planetarium software that simulates the night sky.
- **Zotero**: A reference management tool for organising research papers and citations.

Optional Tools
++++++++++++++

- **Brave**: A privacy-focused web browser that blocks ads and trackers.
- **Discord**: A communication platform for chat and voice, useful for collaborative projects.
- **Dropbox**: Cloud storage service for file sharing and backup.
- **Franz**: A messaging app that consolidates multiple chat services into one platform.
- **gdm-settings**: A tool for customising GNOME Display Manager settings.
- **LaTeX Studio**: A comprehensive LaTeX editor for scientific documents.
- **NordVPN**: A secure VPN service to protect online privacy.
- **remmina**: A remote desktop client for accessing remote systems.
- **Scrcpy**: A screen mirroring application for Android devices.
- **Slack**: A collaboration platform for teams.
- **SuperPaper**: A multi-monitor wallpaper manager.
- **Speedtest**: A tool to test internet speed.
- **Zoom**: A video conferencing tool for meetings and webinars.
- **Upscayl**: A tool for upscaling images using AI.



Contributing to AstrOmakase
===========================

We warmly welcome contributions to AstrOmakase! Whether you're fixing bugs, adding new features, or improving the documentation, your efforts help us build a better tool for the astronomy community. Here are the steps to follow if you'd like to contribute:

1. **Fork the repository**:
   Start by forking the AstrOmakase repository to your own GitHub account.

2. **Create a new branch**:
   Create a branch for your new feature or bug fix. This ensures that your changes remain isolated from the main branch.

   .. code-block:: bash

      git checkout -b feature/your-feature-name

3. **Make your changes**:
   Add or modify the code as necessary. Ensure that your changes are well-tested and documented.

4. **Commit your changes**:
   Once you're satisfied with your changes, commit them with a clear and descriptive message.

   .. code-block:: bash

      git commit -m 'Add feature: your feature name'

5. **Push your branch**:
   Push the branch to your forked repository.

   .. code-block:: bash

      git push origin feature/your-feature-name

6. **Open a Pull Request**:
   Finally, submit a `Pull Request <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests>_` to the main AstrOmakase repository. Please include a description of your changes, any relevant issues your code addresses, and any tests you've written.

We will review your Pull Request as soon as possible, and once approved, it will be merged into the main branch!

Thank you for your contribution to AstrOmakase—together we can build an even better tool for the astronomical research community!
