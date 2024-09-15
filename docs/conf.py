# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Astromakase'
copyright = '2024, Lorenzo Mugnai'
author = 'Lorenzo Mugnai'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    "sphinx.ext.githubpages",
    "sphinx_design",
    "sphinx_copybutton"
]


templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'pydata_sphinx_theme'
html_static_path = ['_static']

html_css_files = [
    './css/color_scheme.css',
]

# html_logo = "_static/icon.png"
html_favicon = "_static/favicon.ico"
html_title = "Astromakase"

html_context = {
    "default_mode": "light"
}

html_theme_options = {
    "icon_links": [
        {
            "name": "GitHub",
            "url": "https://github.com/LorenzoMugnai/AstrOmakase/tree/master",  # required
            "icon": "fab fa-github-square",
            "type": "fontawesome",
        }
    ]
}

html_copy_source = False
