---
description: How to backup and restore your LunaSea configuration locally to your device
---

# Local Backup & Restore

{% hint style="warning" %}
Local backups are currently not supported in the macOS alpha build. Creating and restoring local backups will be supported before the stable release. LunaSea account-based cloud backups are fully supported.
{% endhint %}

Alongside cloud-based backups, LunaSea offers the ability to create local backups of your configuration which you can manually transfer between devices and restore from. This gives you the freedom to have complete control of your data, and never have your configuration saved in a cloud server. Local backups are fully encrypted on-device, there is currently no option to create a non-encrypted backup.

{% hint style="danger" %}
Because all encryption and decryption occurs on-device, it is fully end-to-end encrypted. Forgetting the encryption password will result in there being no way to retrieve the configuration.
{% endhint %}

## Creating a Backup

Creating a backup in LunaSea is simple and painless! Simply head to the Settings and enter the "System" menu. Simply hit "Backup to Device" to start the backup process.

The backup will use the system-level sharesheet to allow you to save the backup \(a `.lunasea` file\). Please ensure to keep the `.lunasea` extension when saving the file, as backups without a .lunasea extension will not be selectable.

## Restoring a Backup

Restoring a backup in LunaSea is as simple as creating the backup! Simply head to the Settings and enter the "System" menu. Simply hit "Restore from Device" to start the restore process.

The restoration process will request the password used to encrypt the original backup.

