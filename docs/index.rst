Welcome to Astromakase's documentation!
=======================================


.. grid:: 2

   .. grid-item::
      :columns: 3

      .. image:: _static/icon.png
         :width: 200
         :class: sd-m-auto

   .. grid-item-card:: Welcome to AstrOmakase!
      :columns: 9

      This project is an optimized Ubuntu setup specifically designed for astronomers and astrophysicists. 
      By building on the `Omakub project <https://github.com/basecamp/omakub>`_,  AstrOmakase offers a curated and comprehensive environment that includes all the essential tools needed for astronomical research.

What is AstrOmakase?
--------------------
AstrOmakase is more than just a collection of software; it's a thoughtfully crafted setup intended to streamline your research workflow. 
The name "AstrOmakase" combines "astronomy" with the Japanese word "omakase," which means "I'll leave it up to you." 
In the same way that an omakase dining experience involves the chef selecting and preparing a personalized meal, AstrOmakase provides a tailored software environment, so you can focus on your research without worrying about configuring each tool individually.

.. image:: _static/desktop.png
..   :width: 400
..   :alt: Alternative text

Installation
-------------

AstrOmakase simplifies the setup process, allowing you to focus on your research and development tasks without the hassle of configuring each tool manually.


Step 1 (optional): Install Omakub
++++++++++++++++++++++++++++++++++

.. note:: 
   AstrOmakase is inspired by the `Omakub project <https://github.com/basecamp/omakub>`_. 
   It has been developed to be installed on top of Omakub, but andit can function with or without a prior installation of Omakub. 
   However, for the best experience, it is recommended to install Omakub before proceeding with the installation of AstrOmakase.

   For more information, please visit the `Omakub website <https://omakub.org/>`_ and `documentation <https://manual.omakub.org/>`_.


For a better experience and specifically for code-oriented work, it is suggested to install **Omakub** first:


.. code-block:: bash

   wget -qO- https://omakub.org/install | bash

Step 2: Install AstrOmakase
++++++++++++++++++++++++++++++++++

Run the script below to install AstrOmakase on your Ubuntu 24.04 system:

.. code-block:: bash

   wget -qO- https://lorenzomugnai.github.io/AstrOmakase/installer.sh | bash

During the installation, if Omakub is not present, you installer will be prompted whether to proceed anyway.



The Menu
----------

Here is a list of tools included in AstrOmakase that are added to the standard Omakub setup. 
The tools are organized into categories for easy navigation and access.

.. .. toctree::
..    :hidden:
..    :maxdepth: 1

..    Desktop Tools <desktop>
..    Coding Tools <code>
..    Remote working Tools <remote>
..    Syncing and Backup <sync>
..    Astronomy Tools <astro>
..    Image and Video Editing <image>
..    Console Tools <console>



.. grid:: 2
   :gutter: 1 1 2 2 
   
   .. grid-item-card::  Desktop Tools
         :link: desktop
         :link-type: ref

         This manual covers the desktop tools such af the office suite and PDF handler.

   .. grid-item-card::  Coding Tools
         :link: coding
         :link-type: ref

         This manual covers the coding tools such as IDEs, text editors, and version control systems.
      

   .. grid-item-card::  Remote working Tools
         :link: remote
         :link-type: ref

         This section covers the tools for remote working such as video conferencing and VPN services.

   .. grid-item-card::  Syncing and Backup
         :link: sync
         :link-type: ref

         This section covers the tools for accessing, syncing and backing up your data with clouds or remote server.

   .. grid-item-card::  Astronomy Tools
         :link: astro
         :link-type: ref

         This section covers the tools for astronomical research such as DS9 and Zotero.

   .. grid-item-card::  Image and Video Editing
         :link: image
         :link-type: ref

         This section covers the tools for image and video editing such as GIMP and OBS Studio.

   .. grid-item-card::  Console Tools
         :link: console
         :link-type: ref

         This manual covers the tool for yor linux terminal. 


Here you can consult a-la-carte the tools included in AstrOmakase.

General Tools
++++++++++++++

- **Anaconda**: A powerful distribution for Python and R programming languages, widely used for scientific computing. Anaconda includes popular data science libraries such as NumPy, SciPy, and Matplotlib.
- **Chrome browser**: A fast, secure, and easy-to-use web browser.
- **Flameshot**: A powerful yet simple-to-use screenshot tool.
- **GitHub CLI**: gh is GitHub on the command line.
- **GIMP**: GNU Image Manipulation Program, a versatile graphics editor.
- **Gnome-sushi**: A quick previewer for files in GNOME.
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
- **Sushi**: A tool to preview file content from the file manager. 
- **VSCode**: A versatile and complete coding IDE.
- **Xournal++**: A PDF editor and note-taking application.
- **Zed**: A high-performance, multiplayer code editor.

Console Tools
++++++++++++++

- **fastfetch**: A fast system information tool written in Rust.
- **fd**: A simple, fast, and user-friendly alternative to `find`.
- **htop** and **btop** two interactive process viewers for Unix systems.
- **lt**: A tool for listing files and directories in a tree-like format.
- **plocate**: A tool for quickly locating files on the filesystem.
- **screen**: A terminal multiplexer that allows multiple windows within a single terminal session.
- **zoxide**: A fast, flexible, and smart directory jumper.

Astronomy Tools
+++++++++++++++++

- **SAOImage DS9**: An astronomical imaging and data visualization application.
- **Stellarium**: A planetarium software that shows exactly what you see when you look up at the stars.
- **Zotero**: A reference management tool for organizing research papers and citations.

Additionally, compared to the standard Omakub setup, some tools that are not commonly used in the astronomy field, such as game emulators and media players, have been removed.

Optional Tools
++++++++++++++

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

Included Fonts
++++++++++++++

The package also includes a collection of fonts that are commonly used:

- Garamond
- Handjet
- Helvetica
- Roboto
- Times New Roman
- tt chocolates



