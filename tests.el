;;; -*- lexical-binding: t -*-
;;; Test suite for robot-log.el

;; Copyright © 2022 Maxim Cournoyer <maxim.cournoyer@gmail.com>

;; robot-log is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; robot-log is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with robot-log.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:
(require 'robot-log)

(ert-deftest robot-log-next ()
  (should (equal '("SUITE" "Test")
                 (cdr (with-temp-buffer
                        (find-file "debug.log")
                        (save-excursion (robot-log-next 1)))))))

(ert-deftest robot-log-next-jump-2 ()
  (should (equal '("TEST" "Hello World")
                 (cdr (with-temp-buffer
                        (find-file "debug.log")
                        (save-excursion (robot-log-next 2)))))))

(ert-deftest robot-log-next-error ()
  (should (string-search "FAIL - Not != Really"
                         (with-temp-buffer
                           (find-file "debug.log")
                           (save-excursion
                             (robot-log-next-error 1)
                             (thing-at-point 'line))))))

(ert-deftest robot-log-merge-spans ()
  (should (equal '((1 . 50)
                   (60 . 65)
                   (66 . 100))
                 (robot-log-merge-spans '((1 . 10)
                                          (2 . 25)
                                          (24 . 50)
                                          (60 . 65)
                                          (66 . 75)
                                          (75 . 100))))))

(ert-deftest robot-log-next-unhandled-error ()
  (should (string-search "FAIL - Oops"
                         (with-temp-buffer
                           (find-file "debug.log")
                           (save-excursion
                             (robot-log-next-unhandled-error 1)
                             (thing-at-point 'line))))))
