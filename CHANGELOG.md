# LunaSea Changelog

## GitHub

#### MEW
- `[Radarr/Details]` Show the monitor state of the movie in the overview table
- `[Radarr/Manual Import]` Ability to manually import content from the filesystem (quick)

#### TWEAKS
- `[Everything]` Unified the design of all expandable cards in their expanded state
- `[Radarr]` Sticky primary button actions to the bottom navigation bar area
- `[UI/UX]` Minor tweaks to the colour palette
- `[UI/UX]` Normalize the size of all buttons

#### FIXES
- `[Dialogs]` Checkbox tiles were padded too aggressively in the X-axis
- `[Networking]` Headers would not get attached in some networking configurations
- `[Radarr/Details]` The overview table would not update when editing a movie
- `[Search]` Indexers would not get restored with backups
- `[Tautulli/Activity]` Activity header included some incorrectly localized strings
- `[Webhooks]` Push the module's home route when receiving malformed data blocks from webhooks

---

## v5.0.0 (50000013)

#### NEW
- `[-Arr/Releases]` Match torrent seeder colours to the web GUI
- `[Firebase/Analytics]` Added analytics for breadcrumb tracking in crashes
- `[Logger]` Utilize a new, custom built on-device logging system
- `[Logger]` Compact/delete old log entries once the log count passes 100
- `[Logger]` Exported logs are now in JSON format
- `[Routing]` Protect all module routes by showing a "Not Enabled" screen when the module is not enabled
- `[Settings/System]` Added toggle to disable Firebase Analytics
- `[Tautulli/Activity]` Show custom season titles from Plex's new TV agent

#### TWEAKS
- `[Radarr/Files]` Add languages to file block
- `[Radarr/Files]` Small changes to table titles
- `[System/Logs]` Reimplemented logger view
- `[System/Logs]` Removed viewing the stack trace within the application (still viewable within the exported logs)
- `[System/Logs]` Added the exception to the expanded table instead of a separate dialog popup
- `[Tautulli/Activity]` Minor UI tweaks including showing the full season title and italicizing the episode title
- `[UI/Navbar]` Jump instead of animate to page when tapping a navbar item

#### FIXES
- `[Firebase/Crashes]` Do not log DioError/networking exceptions
- `[Flutter]` Updated packages
- `[Flutter]` Upgrade all Comet.Tools packages to null-safety/NNBD
- `[Radarr/Releases]` Negative format scores were not being shown
- `[Share]` The sharesheet could break after the first time it was opened
- `[Strings]` Safe-guard many substring operations
- `[Tautulli/Activity]` Play/paused/buffering icon was not properly left aligned to the text
- `[Tautulli/Users]` User images would not be fetched on newer versions of Tautulli
- `[UI/UX]` Modal scroll controller was not being attached to the ListView in a bottom modal sheet
- `[UI/UX]` Do not log errors when network images fail to load
- `[UI/UX]` Prevent attempting to load background images that are passed an empty URL
- `[URLs]` Safe-guard launching specific invalid URLs

---

## v5.0.0 (50000012)

#### NEW
- `[Radarr/Files]` Add video and audio codec to the media file card
- `[Search]` Now supports infinite scrolling for loading additional pages of results
- `[Search]` Much faster parsing of XML responses
- `[Search]` Fully adapted for localization

#### TWEAKS
- `[Search]` Now returns 50 results per infinite scrolling page
- `[Search]` Removed support for sorting the catalogue and instead show the results in the order the indexer returns the data
- `[Search]` Removed support for filtering releases by a search query
- `[Search]` Minor tweaks to the icons on the indexer, category, and subcategory tiles

#### FIXES
- `[Search]` Search would only return 10 results
- `[Search]` Age of the release could show as "Unknown Age" in some cases

---

## v5.0.0 (50000011)

#### NEW
- `[Radarr/Add]` Tags set when adding a movie are now stored in the database
- `[Radarr/Overview]` Add a link to the movie's Trakt page
- `[Settings]` Added a link to the Weblate localization page
- `[Settings]` Added language switcher (currently only English, but preparing for WIP localization support)
- `[Sonarr/Add]` Tags set when adding a series are now stored in the database
- `[Sonarr/Overview]` Add a link to the series' Trakt page

#### TWEAKS
- `[Branding/TMDB]` Updated the logo to The Movie Database's new logo
- `[Logging/Tracking]` Switched from Sentry to Firebase Crashlytics
- `[Radarr/Overview]` Move the links underneath the description to more closely match the layout of the web GUI
- `[Search]` Switched to a new package to parse XML responses
- `[Settings/Tracking]` Adjusted the dialog and warn users that a reboot of the application is required to set tracking state
- `[Sonarr/Overview]` Move the links underneath the description to more closely match the layout of the web GUI
- `[DateTime]` Show "Just Now" when time differences are less than 10 seconds

#### FIXES
- `[Branding]` Normalize size of all branded logos to have the same widths for consistency
- `[Flutter]` Fully move to Flutter v2
- `[Flutter]` Upgrade many packages to NNBD
- `[Radarr/Add]` Grey screen could potentially be shown if no initial search query is passed to the route
- `[Radarr/Add]` The navigation bar could jitter on first load in some cases
- `[Radarr/Catalogue]` The search query would not stay active between profile switches
- `[Radarr/Sorting]` Changing the releases sorting/filtering method could throw an error

---

## v5.0.0 (50000010)

#### NEW
- `[Webhooks]` Show series, movie, or artist cover photos in incoming system notifications
- `[Webhooks/Radarr]` Jump directly into the content by tapping the notification
- `[Webhooks/Sonarr]` Jump directly into the content by tapping the notification
- `[-arr/Details]` Added a button to the AppBar to jump directly into the edit page

#### TWEAKS
- `[Radarr/Files]` Moved the video block above the audio block

#### FIXES
- `[AppBar/Dropdown]` Vertical padding around title when the profile dropdown is visible was incorrect
- `[Radarr/Details]` If the movie was not found, it would show an infinite loader, now shows a "No Movies Found" message
- `[Radarr/Releases]` Changing the sorting or filter method would not scroll the list back to the top

---

## v5.0.0 (50000007)

#### NEW
- `[Radarr/Disk Usage]` Added a progress bar to better visualize disk usage
- `[Search]` Show comment and download links in the expanded table
- `[Settings/Search]` Ability to toggle off showing comment and download links
- `[UI/UX]` If a URL is in a table, tap it to open the URL or long press to copy the URL

#### TWEAKS
- `[-arr/Releases]` Improve the layout of the rejection reasons dialog
- `[Radarr/Health]` Merged health check into system status
- `[UI/UX]` Added more descriptive tooltips to all popup menu buttons
- `[UI/UX]` Adjusted the style of splash/highlight inking

#### FIXES
- `[Images]` Images could fail to load with specific headers
- `[Radarr/Disk Usage]` An invalid total or free space value would cause a grey screen
- `[Radarr/Releases]` Clear button for the search bar would not show up

---

## v5.0.0 (50000006)

### FIXES
- `[Radarr/History]` Tapping on AppBar to scroll back would not work
- `[Radarr/Add]` Content padding when the summary was only 1 line was incorrect
- `[Search]` No results would show up

---

## v5.0.0 (50000005)

#### NEW
- `[Radarr/Health]` View health check messages

#### FIXES
- `[Radarr/Movie]` Ensure that the movie list has started refreshing before exiting the movie details after deleting
- `[Radarr/History]` Specific custom formats could cause history and file information to fail to load

---

## v5.0.0 (50000004)

#### FIXES
- `[Drawer]` Grey screen could appear instead of your drawer

---

## v5.0.0 (50000002/50000003)

#### NEW
- `[Dashboard]` "Home" has been renamed to "Dashboard"
- `[Radarr/Catalogue]` If no movie is found in the search query, given an option to search to add the movie
- `[Radarr/Discover]` Add the ability to discover movies from your import lists & Radarr recommendations
- `[Radarr/Releases]` Ability to set sorting direction, category, and filtering method
- `[Settings/Radarr]` Ability to toggle on or off Radarr suggestions in the discover page

#### TWEAKS
- `[Drawer]` Removed the option to use categories/folders in the drawer
- `[Settings/Config]` Sort configuration options within modules for cleaner isolation and easier expansion for future configuration options
- `[Settings/Profiles]` Renaming a profile now checks for an existing profile with the same name within the prompt
- `[Settings/Profiles]` Adding a profile now checks for an existing profile with the same name within the prompt
- `[Settings/Profiles]` The delete profile prompt now hides the currently enabled profile, and shows a snackbar if only one profile exists
- `[Settings/Wake on LAN]` Allow clearing the broadcast and MAC addresses to empty values

#### FIXES
- `[Radarr]` Support for Radarr v3.1.0+ (nightly builds)
- `[Radarr/Add]` Instantly show a movie as addable again if removed right after adding it
- `[Radarr/Cast]` If a job or character name is empty, show a dash instead of an empty space
- `[Radarr/Catalogue]` Instantly remove the movie tile when removing a movie
- `[Radarr/Edit]` Padding around the "Update Movie" button was incorrect
- `[Toasts]` In some cases, the error was not being passed through to the error viewer
- `[UI/UX]` Upstream framework support for basic mouse/trackpad highlight and scrolling support
- `[UI/UX]` Tapping the AppBar to scroll back in a nested route would scroll back the parent route as well
- `[UI/UX]` Use the recommended safe area padding at the bottom of lists for fullscreen devices

---

## v5.0.0 (50000001)

#### NEW
- `[Radarr]` Completely rewritten from the ground-up
- `[Radarr]` View system status, disk usage, and manage tags
- `[Radarr]` Catalogue, upcoming, missing, tags, and quality profiles are now held in-state between module switches
- `[Radarr/Add]` Long-pressing a search result tile will open the movie's TMDB entry
- `[Radarr/History]` Now an infinite scrolling list
- `[Radarr/Movie]` Cast information, movie-specific history, more detailed file information, more detailed overview page
- `[Radarr/Filtering]` Improved sorting and filtering speed, performance, and consistency
- `[Radarr/Filtering]` Ability to set sorting and filtering defaults in settings
- `[Radarr/Filtering]` Many additional filtering options
- `[Haptics]` Added haptic feedback to all buttons, toggles, and dropdowns
- `[Quick Actions]` Default "Settings" quick action added to end of the list (if there is room)
- `[UI/UX]` (Radarr Only For Now) Ability to tap the AppBar to scroll to top
- `[UI/UX]` (Radarr Only For Now) If the list is in a tabbed PageView, tapping the active tab will scroll the list to the top
- `[UI/UX]` (Radarr Only For Now) If the keyboard is open, scrolling the list, swiping between pages, or opening the drawer will dismiss the keyboard
- `[Webhooks]` Notification webhooks will now show as an in-app heads up if LunaSea is open at the time of receiving the notification

#### TWEAKS
- `[Radarr]` Now only supports v3.0.0 and higher of Radarr
- `[Radarr]` Many visual changes, too many to list
- `[Radarr]` The tab "History" has been replaced with "More"
- `[Radarr/Edit]` Monitor toggle has been moved to the edit prompt
- `[Sonarr/Filtering]` Updated button to use standard filtering icon
- `[Tautulli/Activity]` Show session type and bandwidth type breakdown on activity page
- `[Tautulli/Activity]` Cleanup player information to more closely resemble web GUI
- `[Tautulli/Activity]` Show subtitle stream decision
- `[UI/UX]` Reduced the weight of bold text across the application
- `[UI/UX]` Added padding to bottom of lists for devices that require a safe area
- `[UI/UX]` Active tab in navigation bar now has a border with the AMOLED theme

#### FIXES
- `[Changelog]` Properly align/pad "Full Changelog" button at the end of the changelog
- `[Flutter]` Update packages
- `[Flutter]` Now using the beta channel
- `[Quick Actions]` Improve internal implementation of quick actions to be more stable and reliable
- `[Settings/Modules]` Newly set headers would sometimes not be passed to the connection test
- `[Sonarr/Edit]` Series path prompt would show an incorrect title
- `[Sonarr/Description]` Show "No summary is available" when there is no summary instead of an empty string
- `[Sonarr/Releases]` Default sorting direction was using catalogue default value
- `[Tautulli/Graphs]` Description of some graphs were not correct (Thanks @ZuluWhiskey!)
- `[Tautulli/IPs]` Fix location showing as null for local addresses
- `[UI/UX]` Border radius for the splash highlight wouldn't clip correctly on slim buttons
- `[UI/UX]` Margin/size of sort/filter buttons were off by a few pixels
- `[UI/UX]` InkWell splash now clips correctly to the rounded borders of popup menu buttons

---

## v4.2.1 (40201001)

#### NEW 
- `[Accounts]` Ability to send a password reset email
- `[Accounts]` Associate the LunaSea website domain for better autofill support

#### TWEAKS
- `[Sonarr/Upcoming]` Change "Not Downloaded" to "Missing"

#### FIXES
- `[Alerts/Changelog]` Changelog would be shown again when restoring a backup from a previous version
- `[Sonarr/Add]` Fixed error log showing series ID as null

## v4.2.0 (40200008)

#### NEW
- `[Accounts]` Added LunaSea accounts
- `[Accounts]` Ability to backup, restore, and delete cloud configurations
- `[Accounts]` Register device token to database for future notification support
- `[Backups]` All backups now contain all customization and configuration options in LunaSea (New backups are required to utilize this)
- `[Changelog]` Show changelog on launch if a new version is installed
- `[Changelog]` Use a new bottom sheet UI for the changelog
- `[Settings/Modules]` Add an information/help button with module descriptions and links
- `[Sonarr/Releases]` Added loading state to download buttons to prevent triggering multiple downloads of the same release

#### TWEAKS
- `[Radarr]` Always show the amount of days content will be available instead of limiting it to only content in the next 30 days
- `[Settings]` Moved "Backup & Restore" and "Logs" to "System" section
- `[Settings]` Merged "Customization" and "Modules" sections into "Configuration"
- `[Settings/Sonarr]` Removed the need to enable Sonarr to test the connection
- `[Settings/Tautulli]` Removed the need to enable Tautulli to test the connection

#### FIXES
- `[Flutter]` Updated packages
- `[In App Purchases]` Ensure all in app purchases are marked as consumed
- `[Logging]` Updated Sentry to v4 framework to improve capturing fatal/crashing bugs
- `[Settings/Logs]` Hide exception and stack trace buttons when an error is not available
- `[Settings/Resources]` Updated URL endpoints
- `[Sonarr/History]` Fixed cases where history fetched the oldest entries, not the newest
- `[Sonarr/Upcoming]` If an episode has not aired, show it as "Unaired" instead of "Not Downloaded"
- `[State]` Correctly clear state when clearing LunaSea's configuration
- `[Tautulli/Activity]` Fixed consistency of hardware transcoding indicator compared to the web UI
- `[UI/Divider]` Fixed consistency of divider width across regular and AMOLED dark theme

---

## v4.1.1 (40101001)

#### NEW
- None

#### TWEAKS
- None

#### FIXES
- `[Sonarr/v2]` Fix inability to interactively search for releases
- `[Routing]` Fix black screen when popping back from nested calendar routes

---

## v4.1.0 (40100007)

#### NEW
- `[Backup & Restore]` Backup files now use the .lunasea extension (older .json backups are still supported)
- `[Filesystem]` Any saves to the filesystem now uses the system share sheet
- `[Images]` Ability to set (or entirely disable) the opacity of the background image for cards
- `[Networking]` Strict TLS/SSL validation is now disabled globally
- `[Routing]` Hold the AppBar back button to pop back to the home page of the module
- `[Settings/Sonarr]` Toggle to enable Sonarr v3 features
- `[Sonarr]` A ground-up reimplementation of Sonarr
- `[Sonarr]` State is now held across module switches
- `[Sonarr/Add]` (v3 only) Tapping an already-added series will take you to the series page
- `[Sonarr/Add]` Automatically navigate to a newly added series
- `[Sonarr/Add]` Ability to set tags and (v3 only) language profile when adding a new series
- `[Sonarr/Catalogue]` Ability to view all, only monitored, or only unmonitored series
- `[Sonarr/Catalogue]` Ability to set the default sorting type and direction (in the settings)
- `[Sonarr/Edit]` Ability to update tags and (v3 only) language profile
- `[Sonarr/Episodes]` If the episode is in the queue, show details of the download status
- `[Sonarr/Overview]` View tags and (v3 only) language profile applied to the series
- `[Sonarr/Queue]` Ability to view and manage your queue
- `[Sonarr/Releases]` (v3 only) Ability to interactively search for season packs
- `[Sonarr/Releases]` Ability to view all, only approved, or only rejected releases
- `[Sonarr/Releases]` Ability to set the default sorting type and direction (in the settings)
- `[Sonarr/Tags]` Ability to add, view, and delete tags
- `[Tautulli/Activity]` Show the ETA for when the session will be completed
- `[Tautulli/Activity]` Show if hardware transcoding is being used on the stream

#### TWEAKS
- `[Radarr]` Use Radarr v3 icon across the UI
- `[Settings/Dialogs]` Small tweaks and additional notes for entering hosts and passwords
- `[Settings/Host Dialog]` Add validator on host to ensure user adds http:// or https://
- `[Settings/Resources]` Hide link to documentation until I actually finish it
- `[Sonarr]` Many changes to Sonarr's design
- `[Sonarr/Series]` Toggling monitored state of series has now been moved to the edit prompt and edit screen

#### FIXES
- `[Backup & Restore]` Fix grey screen when restoring a backup without a "default"-named profile (new backups are not required)
- `[Build]` (Android) Update gradle
- `[Build]` (iOS) Reintegrate cocoapods podfile
- `[Filesystem]` (Android) Using the share sheet now fixes the issue of inaccessible logs, backups, and downloads on Android 10+ devices
- `[Flutter]` Update packages
- `[Images]` Images will now load for invalid/self-signed certificates
- `[Networking]` Ensure that insecure (HTTP/80) connections are allowed at the platform-level
- `[Tautulli/Activity]` Fix grey screen for music activity
- `[TextField]` Fix TextField actions (cut, copy, paste, etc.) not showing
- `[Timestamps]` Fix 12:xx AM being shown as 00:xx AM when using 12-hour time
- `[UI/Checkbox]` Fix overly vibrant checkbox selected background
- Tons of additional minor bugs were fixed

---

## v4.0.0 (400102)

#### NEW
- `[Module]` Tautulli support
- `[Calendar]` Ability to set how many days in the past and future to fetch calendar entries for
- `[Drawer]` Categorical folders are now optional
- `[Drawer]` If using folders, ability to set the initial expanded state
- `[Locale]` Ability to use 24 hour timestamps
- `[Quick Actions]` Ability to set upto four homescreen quick actions
- `[Search]` Ability to set custom headers for individual indexers
- `[Settings]` Complete overhaul of the settings
- `[Settings/Resources]` (iOS) Added link to join TestFlight

#### TWEAKS
- `[Home/Calendar]` Separate calendar view type into its own preference
- `[Home/Calendar]` Show no modules enabled message when there are no automation modules enabled, not just no modules overall
- `[Home/Calendar]` Default past and future days is now 14 days for each
- `[Images]` Images are no longer cached to the device storage to heavily improve performance & reduce crashing on older/lower-end devices
- `[Images]` Fetch images at specific resolutions instead of full resolution to reduce network performance and decrease memory pressure
- `[Search]` Improved detection of adult categories
- `[Settings]` Settings now replaces the active module/route and shows the drawer on the base route
- `[Settings/System]` Removed clear image cache tile
- `[UI]` Added new loading animation design

#### FIXES
- `[Flutter]` Updated packages & Flutter
- `[General]` Many small bug fixes
- `[LunaSea]` Many behind the scenes changes to reduce memory pressure
- `[LunaSea]` Heavy improvements and fixes to the navigation routing
- `[Settings/Logs]` Logs could be shown in reverse order
- `[Text]` Fixed "squished" text on iOS 14 and higher devices

---

## v3.3.0 (330002)

#### NEW
- `[Home/Calendar]` New "schedule" view
- `[Home/Modules]` Option to use module "brand colour" or the LunaSea list colours
- `[Search]` Option to hide adult categories
- `[-arr/Catalogue]` Ability to sort by date added
- `[-arr/Search]` Show the indexer/tracker on the collapsed tile

#### TWEAKS
- None

#### FIXES
- `[Sonarr]` Fixed multiple errors related to parsing fetched episode data
- `[Everything]` Multiple smaller crash/error fixes

---

## v3.2.0 (320003)

#### NEW
- `[Drawer]` Add the LunaSea logo to the header
- `[Logging]` Integrated Sentry, an open-source exception/crash log aggregation tool
- `[Settings/System]` Added toggle (under system -> advanced) to disable Sentry logging

#### TWEAKS
- `[System]` Implemented new image caching backend
- `[APIs]` Improved exception logging
- `[Logging]` Improved on-device logger to have more useful stack traces

#### FIXES
- `[-arr/Details]` Fixed crash related to state management
- `[radarr/Add]` Fixed crash when a searched movie does not have a minimum availability value available

---

## v3.1.0 (310004)

#### NEW

- `[Settings/Resources]` Added Discord invite link for official server
- `[-arr]` Ability to search and enter interactive search from all upcoming and missing pages
- `[-arr/Add]` Ability to jump directly into newly added content from toast notification
- `[Radarr/Delete]` Ability to add to exclusion list when deleting content
- `[Clients]` Hide and show queue pause/start FAB on scroll
- `[Clients/History]` History tiles are now expandable in-line
- `[SABnzbd/Statistics]` Show both temporary and final storage space
- `[Calendar]` Ability to search/enter interactive search directly from calendar tiles

#### TWEAKS

- `[Development]` Updated Flutter packages

#### FIXES

- `[API/Host]` Correctly handle cases where host ends with a forward slash

---

## v3.0.0 (300100)

#### NEW

- `[Search]` Releases are now shown as an expandable tile
- `[Search/Category Results]` Ability to sort and filter results
- `[Search/Search Results]` Ability to sort search results
- `[-rr/Catalogue]` Many additional sorting options
- `[-rr/Releases]` Releases are now shown as an expandable tile
- `[-rr/Releases]` Ability to sort, hide, and filter releases
- `[Sonarr/Add]` Ability to set initial episode monitoring state
- `[Sonarr/Episodes]` Episodes are now shown as an expandable tile
- `[Radarr/Releases]` Shows custom format tags
- `[Clients]` FAB icon animates between queue state
- `[Images]` Ability to clear network image cache
- `[UI/AMOLED Theme]` Optional setting to add subtle border

#### TWEAKS

- `[Changelog]` Removed integrated changelog, redirects to documentation changelog
- `[-rr]` Use the term "Interactive" instead of "Manual" for search
- `[-rr/Links]` Normalize size of images
- `[Sonarr/Upcoming]` Now shows dates in-line as a styled header
- `[Sonarr/Season View]` Now shows season number in-line as a styled header
- `[UI/Font]` Adjusted font size across entire application
- `[UI/Dropdowns]` Change dropdowns to popup menus
- `[UI]` Rounder radius around tiles, popups, etc.

#### FIXES

- `[Home/Calendar]` Row height is now statically set to prevent huge calendar on larger displays
- `[Sonarr/Seasons]` Fixed crash related to seasons with no statistics data for percentage of season completion
- `[Sonarr/Episodes]` Episode numbers greater than 100 could cause a line-break
- `[Sonarr/Episodes]` Fixed/safe-guarded layout crash on incomplete episode data received
- `[Sonarr/Queue]` Safe-guarded Sonarr queue results when results are null
- `[Snackbar]` Snackbar wouldn't adopt AMOLED styling when enabled
- `[State]` Fixed crashes caused by setting the state of an unmounted widget

---

## v2.3.0 (230004)

#### NEW

- `[Module]` Wake on LAN support
- `[Settings/Modules]` Ability to set custom headers to be attached to module requests
- `[Settings/Changelog]` Changelog is now displayed as a route, not a dialog
- `[UX]` Hitting the back button on apex/primary routes will now open the drawer instead of closing the application
- `[UX]` Enable landscape mode for iPhones

#### TWEAKS

- `[-rr/Details]` Removed sliver AppBar and fanart as it caused unwanted scrolling interference (A revamped overview page in the future will bring back the fanart images)
- `[-rr/Details]` Switched from AppBar tabs to bottom navigation bar
- `[-rr/Release]` Do not show warning message when triggering a release download from details page on rejected release
- `[Dialogs]` Reimplemented all dialogs
- `[Dialogs]` Keyboard type is now set for all inputs
- `[Dialogs]` All inputs are now validated (to some extent) and can be submitted via the Keyboard

#### FIXES

- `[SnackBar]` SnackBar could cause UI locking when doing swipe-back gestures

---

## v2.2.0 (220003)

#### NEW

- `[Donations]` Added donation IAPs
- `[Profiles]` Added rapid-profile switcher
- `[Settings]` Added license attributions
- `[Settings]` Added feedback link
- `[-rr/Add]` Search bar will now be autofocused
- `[SABnzbd]` Added statistics for individual servers
- `[NZBGet]` Option to use basic authentication instead of URL-encoded authentication

#### TWEAKS

- `[UI]` Removed custom letter spacing
- `[Settings]` Added subheaders

#### FIXES

- `[Database]` Cleanly exit on clean application exit to prevent corruption

---

## v2.1.0 (66)

#### NEW

- `[Branding]` New icon & splash screen
- `[Links]` Ability to set which browser you open links in (iOS only)
- `[Home/Calendar]` Ability to set starting day of week
- `[Home/Calendar]` Ability to set starting calendar size
- `[Home/Calendar]` Ability to enable and disable specific modules that show up in the calendar
- `[Appearance/Theme]` Option to enable AMOLED black theme
- `[Platform]` LunaSea is now buildable & available for Android

#### TWEAKS

- `[Settings]` Redesign of settings page
- `[General]` Use the term "Modules" instead of "Services"
- `[-rr/Details]` Background image header/appbar is now collapsed by default
- `[-rr/Details]` Left align title to match the rest of LunaSea

#### FIXES

- `[Sonarr]` Toast for toggling season monitor state would show monitor status of the series, not the season
- `[Settings/Backup]` Backing up your configuration would always fail
- `[Search]` Would show an empty screen if you deleted all indexers while search is open

---

## v2.0.1 (55)

#### NEW

- `[SABnzbd]` Ability to upload .rar & .gz archives
- `[-rr/Add]` All configurable values are now stored in cold database, persisting between sessions
- `[-rr/Add]` Root folders now also show available space for the folder
- `[Search]` When sending an NZB to a client, there is now an action in the toast to jump directly to the respective client
- `[Automation/Search]` When downloading a release manually, there is now an action in the toast to pop back to the main screen of the automation service
- `[Settings]` Ability to disable SSL/TLS validation for all services
- `[HTTP]` With the above, support for self-signed SSL certificates

#### TWEAKS
- `[Descriptions]` Adjusted alignment and consistency when no summary is available
- `[Search]` Removed redundant “Sending” toast since it very quickly gets covered by the follow-up toast
- `[Automation]` Edit content prompt now shows full title of the content
- `[Clients]` Opening the edit menu now shows the full title of the job
- `[UI]` Tweaked design of content headers
- `[Settings]` Added headers to automation and client pages to separate regular and advanced configuration options

#### FIXES

- `[HTTP]` Safer handling of redirects
- `[Routes]` Make route changes asynchronous to help minimize stutters
- `[Radarr/Add]` Fixed wrong title for minimum availability card
- `[Restore Configuration]` Error message had typos
- `[UI]` Fixed uneven font sizing in some prompts
- `[NZBGet/SABnzbd]` Failure on uploading an NZB would show no error message

---

## v2.0.0 (333)

#### NEW

- `[iOS]` Built for iOS 13.4
- `[Indexers/Search]` Full support for browsing and searching Newznab-based indexers!
- `[Indexers/Search]` Support for NZBHydra2
- `[Indexers/Search]` Download NZB files directly to your device
- `[Indexers/Search]` Send NZB files directly from the indexer to your client of choice
- `[-rr/Catalogue]` Catalogue search bar is now stickied
- `[-rr/History]` Ability to enter content
- `[-rr/Add]` More information (year, seasons, etc.) shown in result tiles
- `[NZBGet]` Ability to search through fetched history
- `[SABnzbd]` Ability to search through fetched history
- `[Settings/Configuration]` Ability to clear configuration
- `[Drawer]` Ability to switch profiles in navigation Drawer
- `[Snackbar]` New snackbar style, design, and formatting
- `[Everything]` All services now dynamically reload on profile changes

#### TWEAKS

- `[Everything]` Reimplemented... everything
- `[Everything]` Moved away from FABs (where possible) to buttons
- `[Navigation]` Ability to swipe left and right between bottom navigation tabs (except Settings)
- `[Navigation Bar]` Slightly redesigned
- `[Home/Summary]` Redesigned summary page
- `[Home/Summary]` Removed fetching of series count, movie count, and artist count
- `[Home/Calendar]` Now only shows 1 dot for each day instead of 3
- `[Home/Calendar]` Highlights today as well as selected day
- `[Home/Calendar]` Now shows the day of the week on the calendar
- `[Home/Calendar]` Now defaults to showing 1 week (swipe down to show two weeks or one month)
- `[Settings]` No longer a need to save configuration settings, everything is saved automatically
- `[Search Bar]` "X" to clear search bars
- `[-rr/Catalogue]` Sorting now scrolls back to top
- `[-rr/Catalogue]` Moved hide unmonitored button to stickied search bar
- `[-rr/Add]` Selected profile, folders, etc. are stored in state until application is closed or profile is switched
- `[-rr/Images]` Images now show placeholder, transition to real content on load
- `[Sonarr/Episodes]` Multi-select episodes with single tap anywhere on tile, now highlighted for easier distinction
- `[SABnzbd]` Limit queue to first 100 results
- `[SABnzbd]` Lowered refresh rate to 2 seconds from 1 second
- `[NZBGet]` Limit queue to first 100 results
- `[NZBGet]` Lowered refresh rate to 2 seconds from 1 second
- `[UI]` Reduced elevation of UI in general

#### FIXES

- `[Sonarr/Search]` Searching for an entire season now executes a season search instead of individual episode searches
- `[Logs]` Fixed bug where logs could not load in some cases and always show "Logs Not Found"
- `[Radarr/Search]` Now correctly retains search state to prevent needless researching & API hits
- `[Configuration]` Deleting or renaming "default" profile could cause a new "default" profile to be created on next launch

--- 

## v1.1.0 (44)

#### NEW

- `[Home]` Calendar view for upcoming -rr content
- `[Sonarr]` Ability to toggle single episode monitored status
- `[Sonarr]` Ability to delete file
- `[Radarr]` Split missing tab into missing and upcoming
- `[-rr]` Long-press tile on non-catalogue pages to view catalogue entry
- `[-rr]` Ability to delete files when deleting catalogue entries
- `[Documentation]` Added a link to WIP documentation

#### FIXES

- `[Prompts]` All prompts now use the correct colour ordering
- `[NZBGet]` Adjusted authentication method to interfere less with custom auth setups

#### TWEAKS

- `[Drawer]` Dropdown groups are open by default until more services are added
- `[Settings]` Minor tile shuffling and rewording
- `[Navigation]` New style for the navigation bars
- `[Navigation]` Added custom icons to navigation bars
- `[Releases]` Easier to differentiate the release's protocol

---

## v1.0.0 (33)

#### NEW

- `[-rr]` When adding new content, checks if content is already in your library
- `[-rr]` Ability to sort catalogue by size of alphabetical
- `[Settings]` Ability to rename a profile
- `[SAB/NZBGet]` Ability to pause the queue for some amount of time
- `[NZBGet]` Ability to filter out successful history entries

#### FIXES

- `[Radarr]` Fetching quality profiles could fail
- `[SAB/NZBGet]` Percentage calculation could fail causing a grey screen
- `[SAB/NZBGet]` Connection error now cancels timer until manual refresh (cleaner logs)

#### TWEAKS

- `[Build]` Adjusted how build number is presented
- `[Sonarr]` Now shows size on disk on catalogue page
- `[Lidarr]` Now shows size on disk on catalogue page
- `[Settings]` Successful connection test now also triggers save
- `[Settings]` Save button is now more obvious/clear
- `[Settings]` Adjusted and added more tips when adding hosts
