<h1 align=center>LunaSea</h1>
<p align=center>
    <i>Flutter-based Usenet Manager for iOS</i>
    <br>
    <b>Under constant development</b>
    <br>
    <img src=https://i.imgur.com/yPhYyLY.png>
</p>

## Changelog

### v0.2.0+1 (Beta)

##### New

- `[Clients]` Support for SABnzbd
- `[Changelog]` Implemented a changelog

##### Fixes

- `[Home]` Fixed quick links not expanding to fill display width
- `[Home]` Fixed services that had over 3 digits causing an overflow
- `[Lidarr]` Fixed some artists showing no albums
- `[Sonarr]` Fixed cases where some shows caused a crash
- `[Inputs]` Fixed input fields not allowing a blank string
- `[DateTime]` Fixed cases where datetime string couldn't be parsed
- `[System]` Fixed version checking consistency

##### Tweaks

- `[Settings]` Removed feature requests, folded it into bug reports
- `[UI]` Reduced snackbar duration
- `[UI]` Tweaked snackbar design
- `[Pro]` Added message about the state of LunaSea Pro


### v0.1.5+1 (Beta)
##### New

- `[UI]` Use iOS-styled scrollbar for lists
- `[Firebase]` Ability to delete Firebase backups

##### Fixes
- `[Lidarr]` Fixed Lidarr missing search
- `[Profiles]` Fixed cases where deleting a profile could delete other profiles

##### Tweaks

- `[UI]` Changed most buttons to floating action buttons (FABs)
- `[UI]` Titles are now left-aligned
- `[UI]` Updated colours

### v0.1.0+1 (Beta)

###### New

- `[Automation]` Support for Lidarr
- `[Automation]` Support for Radarr
- `[Automation]` Support for Sonarr
