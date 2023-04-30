;;; spacemacs-leader-maps.el --- Control Emacs the Spacemacs way  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Daniel Nicolai

;; Author: Daniel Nicolai <dalanicolai@2a02-a45d-af56-1-666c-72af-583a-b92d.fixed6.kpn.net>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Spacemacs introduced a quite genius editing paradigm by using the
;; spacebar as leader key. This paradigm combines especially well with
;; the Vim modal editing paradigm, i.e. with the Emacs evil
;; package. Additionally, the which key package fits this paradigm
;; very well.

;;; Code:

;; initialize the main leader key
(defvar spc-leader-map (make-sparse-keymap))
(keymap-global-set "M-m" (cons "root" spc-leader-map))
(with-eval-after-load 'evil
  (dolist (s (list evil-normal-state-map
                   evil-motion-state-map))
    (keymap-set s "SPC" (cons "root" spc-leader-map)))

  (dolist (s (list evil-insert-state-map
                   evil-emacs-state-map))
    (keymap-set s "M-SPC" (cons "root" spc-leader-map))))

(defun spc-keymap-set-multi (map &rest bindings)
  (while bindings
    (pcase-let ((`(,key ,cmd) bindings))
      (keymap-set map key cmd))
    (setq bindings (cddr bindings))))

(spc-keymap-set-multi spc-leader-map
                      "SPC"	'execute-extended-command
                      "<tab>"	'evil-switch-to-windows-last-buffer
                      ";"       'comment-or-uncomment-region

                      "b"	'("buffer" . (keymap))
                      "b b"	'switch-to-buffer
                      "b d"	'kill-current-buffer
                      "b m"	'pop-to-messages
                      "b s"	'pop-to-scratch

                      "c"	'("compile" . (keymap))
                      "c c"	'recompile

                      "e"	'("edit" . (keymap))

                      "f"	'("files" . (keymap))
                      "f e"	'("emacs" . (keymap))
                      "f e d"	'find-init-file
                      "f e R"	'load-init-file
                      "f f"	'find-file
                      "f r"	'recentf
                      "f s"	'save-buffer

                      "g"	'("git" . (keymap))

                      "h"	'("help" . (keymap))
                      "h d"	'("describe" . (keymap))
                      "h d c"	'describe-char
                      "h d f"	'describe-function
                      "h d k"	'describe-key
                      "h d t"	'describe-text-properties
                      "h d v"	'describe-variable
                      "h d K"	'describe-keymap
                      "h j"	'info-display-manual
                      "j k"     'which-key-show-top-level

                      "j"	'("jump" . (keymap))
                      "j f"	'find-function
                      "j i"	'imenu ;might get overwritten by ivy/vertico/helm section
                      "j l"	'find-library

                      "l"	'("lisp" . (keymap))

                      "o"	'("org" . (keymap))

                      "s"	'("search" . (keymap))
                      "s l"	'locate

                      "t"	'("toggles" . (keymap))
                      "t l"	'display-line-numbers-mode

                      "u"	'universal-argument

                      "w"	'("windows" . (keymap))
                      "w /"	'split-window-right
                      "w d"	'delete-window
                      "w m"	'delete-other-windows
                      "w w"	'other-window

                      "q"	'("quit" . (keymap))
                      "q q"	'save-buffers-kill-emacs)

(provide 'spacemacs-leader-maps)
;;; spacemacs-leader-maps.el ends here
