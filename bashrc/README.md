BASHRC FILES
============

Guidelines for Using
--------------------

In your ~/.bashrc file, `source` each of the relevant files

Guidelines for Adding
----------

1. If it applies to Git, put it in git
2. Else if it applies to all workstations, put it in workstations
3. Else if it only to the X window system, put it in keyboard-hacks
4. Else if it only applies to git bash, put it in on-windows
5. Else if it is custom to a single server only (and you don't need to remember it), put it directly in ~/.bashrc

Commit useful changes so you can use them elsewhere


Call setup
----------

    scripts/01-setup
