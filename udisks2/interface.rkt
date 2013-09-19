#lang racket/base
;
; Definition of Udisks2 D-Bus interfaces.
;

(require racket/contract
         dbus)

(provide (all-defined-out))


(define-dbus-interface udisks2-manager<%>
                       "org.freedesktop.UDisks2.Manager"
  (MDRaidCreate "aossta{sv}"))


(define-dbus-interface udisks2-drive<%>
                       "org.freedesktop.UDisks2.Drive"
  (Eject "a{sv}")
  (SetConfiguration "a{sv}a{sv}")
  (PowerOff "a{sv}"))


(define-dbus-interface udisks2-drive-ata<%>
                       "org.freedesktop.UDisks2.Drive.Ata"
  (SmartUpdate "a{sv}")
  (SmartGetAttributes "a{sv}")
  (SmartSelftestStart "sa{sv}")
  (SmartSelftestAbort "a{sv}")
  (SmartSetEnabled "ba{sv}")
  (PmGetState "a{sv}")
  (PmStandby "a{sv}")
  (PmWakeup "a{sv}")
  (SecurityEraseUnit "a{sv}"))


(define-dbus-interface udisks2-mdraid<%>
                       "org.freedesktop.UDisks2.MDRaid"
  (Start "a{sv}")
  (Stop "a{sv}")
  (RemoveDevice "oa{sv}")
  (AddDevice "oa{sv}")
  (SetBitmapLocation "aya{sv}")
  (RequestSyncAction "sa{sv}"))


(define-dbus-interface udisks2-block<%>
                       "org.freedesktop.UDisks2.Block"
  (AddConfigurationItem "(sa{sv})a{sv}")
  (RemoveConfigurationItem "(a{sv})a{sv}")
  (UpdateConfigurationItem "(a{sv})a{sv}")
  (GetSecretConfiguration "a{sv}")
  (Format "sa{sv}")
  (OpenForBackup "a{sv}")
  (OpenForRestore "a{sv}")
  (OpenForBenchmark "a{sv}")
  (Rescan "a{sv}"))


(define-dbus-interface udisks2-partition<%>
                       "org.freedesktop.UDisks2.Partition"
  (SetType "sa{sv}")
  (SetName "sa{sv}")
  (SetFlags "ta{sv}")
  (Delete "a{sv}"))


(define-dbus-interface udisks2-partition-table<%>
                       "org.freedesktop.UDisks2.PartitionTable"
  (CreatePartition "ttssa{sv}"))


(define-dbus-interface udisks2-filesystem<%>
                       "org.freedesktop.UDisks2.Filesystem"
  (SetLabel "sa{sv}")
  (Mount "a{sv}")
  (Unmount "a{sv}"))


(define-dbus-interface udisks2-swapspace<%>
                       "org.freedesktop.UDisks2.Swapspace"
  (Start "a{sv}")
  (Stop "a{sv}"))


(define-dbus-interface udisks2-encrypted<%>
                       "org.freedesktop.UDisks2.Encrypted"
  (Unlock "sa{sv}")
  (Lock "a{sv}")
  (ChangePassphrase "ssa{sv}"))


(define-dbus-interface udisks2-loop<%>
                       "org.freedesktop.UDisks2.Loop"
  (Delete "a{sv}")
  (SetAutoclear "ba{sv}"))


(define-dbus-interface udisks2-job<%>
                       "org.freedesktop.UDisks2.Job"
  (Cancel "a{sv}"))


; vim:set ts=2 sw=2 et:
