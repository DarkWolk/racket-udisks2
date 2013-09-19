#lang racket/base
;
; UDisks2 Client Library
;

(require racket/contract
         racket/class
         dbus/interface
         dbus)

(require "interface.rkt")

(provide udisks2-list-devices
         udisks2-list-drives
         udisks2-list-raids
         udisks2-list-jobs)


;; Path constants.
(define *endpoint*      "org.freedesktop.UDisks2")
(define *devices-path*  "/org/freedesktop/UDisks2/block_devices")
(define *drives-path*   "/org/freedesktop/UDisks2/drives")
(define *raids-path*    "/org/freedesktop/UDisks2/mdraid")
(define *jobs-path*     "/org/freedesktop/UDisks2/jobs")


;; Class for block device with all possible mixins,
;; except for Loop.
(define device%
  ((compose udisks2-block<%>
            udisks2-partition<%>
            udisks2-partition-table<%>
            udisks2-filesystem<%>
            dbus-properties<%>
            dbus-introspectable<%>)
   dbus-object%))


;; Class for drive with optional ATA mixin.
(define drive%
  ((compose udisks2-drive<%>
            udisks2-drive-ata<%>
            dbus-properties<%>
            dbus-introspectable<%>)
   dbus-object%))


;; Class for Linux MD RAID devices.
(define raid%
  ((compose udisks2-mdraid<%>
            dbus-properties<%>
            dbus-introspectable<%>)
   dbus-object%))


;; Class for background jobs.
(define job%
  ((compose udisks2-job<%>
            dbus-properties<%>
            dbus-introspectable<%>)
   dbus-object%))


;; Class for generic introspectable object.
(define introspectable-object%
  (dbus-introspectable<%> dbus-object%))


;; List child nodes of given path.
(define (list-children connection path)
  (map (lambda (name)
         (string-append path "/" name))
       (dbus-introspect-children
         (new introspectable-object% (path path)
                                     (endpoint *endpoint*)
                                     (connection connection)))))


;; Return list of all known block device instances.
(define/contract (udisks2-list-devices (connection (current-dbus-connection)))
                 (->* () (dbus-connection?) (listof object?))
  (for/list ((path (in-list (list-children connection *devices-path*))))
    (new device% (path path) (endpoint *endpoint*) (connection connection))))


;; Return list of all known drive instances.
(define/contract (udisks2-list-drives (connection (current-dbus-connection)))
                 (->* () (dbus-connection?) (listof object?))
  (for/list ((path (in-list (list-children connection *drives-path*))))
    (new drive% (path path) (endpoint *endpoint*) (connection connection))))


;; Return list of all known RAID instances.
(define/contract (udisks2-list-raids (connection (current-dbus-connection)))
                 (->* () (dbus-connection?) (listof object?))
  (for/list ((path (in-list (list-children connection *raids-path*))))
    (new raid% (path path) (endpoint *endpoint*) (connection connection))))


;; Return list of all known background job instances.
(define/contract (udisks2-list-jobs (connection (current-dbus-connection)))
                 (->* () (dbus-connection?) (listof object?))
  (for/list ((path (in-list (list-children connection *jobs-path*))))
    (new job% (path path) (endpoint *endpoint*) (connection connection))))



; vim:set ts=2 sw=2 et:
