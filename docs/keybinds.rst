.. _keybinds:

Pre-configured keybindings, shortcuts, and gestures for AstrOmakase
=======================================================================

Keybindings Overview
---------------------

Window Management
^^^^^^^^^^^^^^^^^^^^^^^^^

- **Close Window:** ``<Super>w``  
  Quickly close any active window without stretching for ``Alt+F4``.

- **Maximise Window:** ``<Super>Up``  
  Maximise the current window with a single shortcut.

- **Restore Window:** ``<Super>Down``  
  Restore the current window to its original size if maximised.

- **Toggle Fullscreen:** ``<Shift>F11``  
  Enter or exit fullscreen mode, retaining the title/navigation bar.

- **Minimise Window:** ``<Super>h``  
  Quickly minimise the active window.

Workspace Management
^^^^^^^^^^^^^^^^^^^^^^^^^

- Switch to Workspaces:Use ``<Super>1`` through ``<Super>6`` to jump directly to specific workspaces.

- Move Windows to Workspaces:Use ``<Super><Shift>1`` through ``<Super><Shift>6`` to send the active window to a specific workspace.

- Navigate Workspaces:Use ``<Control><Alt>Left`` or ``<Control><Alt>Right`` to switch to the previous or next workspace.

- Move Windows Between Workspaces:Use ``<Control><Shift><Alt>Left`` or ``<Control><Shift><Alt>Right`` to move the active window to the adjacent workspace.

Tiling Assistant Keybindings
----------------------------

Basic Tiling Shortcuts
^^^^^^^^^^^^^^^^^^^^^^

- **Tile Left Half:** ``<Super>Left``, ``<Super>KP_4``
- **Tile Right Half:** ``<Super>Right``, ``<Super>KP_6``
- **Tile Top Half:** ``<Super>KP_8``
- **Tile Bottom Half:** ``<Super>KP_2``
- **Tile Top-Left Quarter:** ``<Super>KP_7``
- **Tile Top-Right Quarter:** ``<Super>KP_9``
- **Tile Bottom-Left Quarter:** ``<Super>KP_1``
- **Tile Bottom-Right Quarter:** ``<Super>KP_3``
- **Maximise Window (Tiling Mode):** ``<Super>Up``, ``<Super>KP_5``

.. note::
   The ``KP`` prefix refers to the keypad (numeric pad) keys. If your keyboard lacks a numeric keypad, these keybindings may not work unless you remap them.

Advanced Tiling Shortcuts
^^^^^^^^^^^^^^^^^^^^^^^^^

Press ``<Super>t`` to activate Tiling Assistant’s interactive tiling mode. This mode allows you to divide the screen into non-homogeneous portions. By default, the screen is split into three columns, where the central column is as wide as the two lateral ones combined. Use combinations of ``Q``, ``W``, ``E``, ``A``, ``S``, ``D``, ``Z``, ``X``, ``C`` to place the window in complex layouts. Examples include:

- ``<Super>t`` + ``WW``: Centre-top area
- ``<Super>t`` + ``QW``: Top-left and centre area
- ``<Super>t`` + ``QA``: Left column

The keys used for tiling (default: ``Q``, ``W``, ``E``, ``A``, ``S``, ``D``, ``Z``, ``X``, ``C``) can be expanded or modified based on user preferences in Tiling Assistant’s settings.
This can ce accessed by pressing ``<Super>Shift>t``.

.. image:: _static/tiling.png


Using Ulauncher
----------------

Ulauncher is your go-to tool for quick application launching and actions. Press ``<Super>Space`` to bring it up and start typing:

- **Application Names:** Launch any installed application by typing its name.
- **File Search:** Access files by their names if indexed.
- **Custom Extensions:** Use Ulauncher’s plugins to add functionality like calculator operations, dictionary searches, or script executions.

.. image:: _static/ulauncher.png


Configuration files for Ulauncher are pre-set but can be modified in ``$HOME/.config/ulauncher/settings.json``.

Workspace Gestures
-------------------

The system uses six fixed workspaces. You can navigate and manage them using:

- **Keybindings:** ``<Super>1`` to ``<Super>6`` to switch between workspaces.
- **Move Windows:** ``<Super><Shift>1`` to ``<Super><Shift>6`` to move a window to a specific workspace.
- **Touchpad Gestures:** Swipe left or right with three fingers to navigate between adjacent workspaces. Swipe up with three fingers to open the Activities Overview (equivalent to the Home/Overview key).

