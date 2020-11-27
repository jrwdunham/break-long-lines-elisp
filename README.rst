================================================================================
  Break Long Lines
================================================================================

ELisp functionality for breaking long lines in Emacs/Spacemacs.


Installation
================================================================================

Clone this repo and add this to your config::

  (autoload 'break-long-line "/path/to/break-long-lines/break-long-lines" nil t)
  (global-set-key [(control ?k)] 'break-long-line)

The value ``"/path/to/break-long-lines/break-long-lines"`` above should be the
path to the ``break-long-lines.el`` file without the ``.el`` extension.


Usage
================================================================================

With the above key mapping, you can type ``C-k`` to break a line with more than
80 characters. Define a different mapping if you prefer.
