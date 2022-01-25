### 6.0.0

### Features

- **Dashboard:** (Calendar) Display content poster and additional information
- **Dashboard:** (Calendar) Add option to show past days in schedule view
- **Dashboard:** (Calendar) Use different marker colours depending on how much content is missing
- **Lidarr:** (Add Artist) Long-press result tile to view Discogs page
- **Lidarr:** (Add Artist) Show artist poster in result list
- **Lidarr:** (Add Artist) Allow user to select monitoring options
- **Lidarr:** (Add Artist) Removed toggle to use album folders
- **Lidarr:** (Catalogue) Show artist poster in catalogue list
- **Lidarr:** (Missing) Display album covers
- **Notifications:** (Priority) Support time-sensitive notifications
- **Settings:** (Account) Ability to delete your LunaSea account and all cloud data
- **Settings:** (Configuration) Show dismissible blocks with information and links
- **Settings:** (Network) Ability to enable TLS certificate validation
- **Settings:** (Radarr) Ability to set default catalogue view
- **Settings:** (Sonarr) Removed toggle to enable v3 features
- **Settings:** (Sonarr) Ability to set default catalogue view
- **Settings:** (Sonarr) Ability to set default filtering method
- **Settings:** (Sonarr) Ability to set queue fetch size
- **Settings:** (System) Ability to clear image cache
- **Radarr:** (Catalogue) Grid view support
- **Radarr:** (Catalogue) Expand search bar on focus
- **Sonarr:** (Catalogue) Grid view support
- **Sonarr:** (Catalogue) Expand search bar on focus
- **Sonarr:** (Catalogue) Many additional sorting and filtering options
- **Sonarr:** (Episodes) Entirely revamped details view
- **Sonarr:** (Episodes) View media info for downloaded episodes
- **Sonarr:** (Episodes) View history for a single episode
- **Sonarr:** (Episodes) View active queued releases for a single episode
- **Sonarr:** (Season Details) View history for a single season
- **Sonarr:** (Series Details) View history for a single series
- **Sonarr:** (History) Now an infinite scrolling list
- **Sonarr:** (History) Tiles are now expandable tiles with much more detail
- **Sonarr:** (Home) "History" tab has been replaced with a "More" tab
- **Sonarr:** (Season List) Display season posters
- **Sonarr:** (Queue) Option to set queue page size
- **Sonarr:** (Releases) Ability to set default filtering method
- **Sonarr:** (Releases) Now shows preferred word score
- **System:** (Analytics) Completely removed Firebase Analytics
- **System:** (Analytics) Completely removed Firebase Crashlytics
- **System:** (Images) Cache fetched images to disk
- **UI/UX:** (Icons) Added/updated brand icons for Lidarr, Sonarr, and Overseerr
- **UI/UX:** (Tile Blocks) Allow overflowing title or body lines to be horizontally scrolled

### Tweaks

- **Dashboard:** (Modules) Always use module's brand colour for module list
- **UI/UX:** (Drawer) Use module's brand colour for highlighted colour
- **UI/UX:** (Drawer) Heavily reduced the size of the header area
- **UI/UX:** (Drawer) Use the primary colour as the background colour
- **UI/UX:** (Fonts) Normalized font sizes across the UI
- **UI/UX:** (Icons) Ensure all icons are of the "rounded" family
- **UI/UX:** (Icons) Replace custom icons (except branding icons) with Flutter defaults
- **UI/UX:** (Images) Set the default image opacity to 20% (custom set values are unaffected)
- **UI/UX:** (Tile Blocks) Heavily improved build and memory performance of tiles
- **UI/UX:** (Tile Blocks) Improved consistency in trailing icon/text size
- **UI/UX:** (Tile Blocks) Improved consistency of tile height, content spacing, and padding
- **UI/UX:** (Tile Blocks) Natively draw placeholder posters for movies, series, albums, etc.
- **UI/UX:** (Tile Blocks) Fade-in background image loads
- **UI/UX:** (Tooltips) Added styling to match LunaSea theme

### Bug Fixes

- **Dashboard:** (Calendar) Only show type switcher icon when on the calendar page
- **Lidarr:** (Artists) Safe-guard fetching of artist quality profiles
- **Radarr:** (Add Movie) Removed ability to set PreDB or TBA minimum availability
- **Radarr:** (Edit Movie) Removed ability to set PreDB or TBA minimum availability
- **Radarr:** (Files) Failed to load when files have no media information
- **Radarr:** (Releases) Negative custom word scores would be incorrectly displayed
- **Settings:** (Calendar) Starting type would have incorrect icons
- **Settings:** (Notifications) Overseerr would not be displayed
- **Sonarr:** (API) Now only utilizes v3 API routes
- **Sonarr:** (Catalogue) Missing filter would fail to load when using Sonarr v4
- **Sonarr:** (Edit Series) Vastly speed up response time on submitting updates
- **Sonarr:** (Missing) Air date would show in days for very old content
- **Sonarr:** (Queue) Check monitored download status on pull to refresh
- **Sonarr:** (Season List) Correctly calculate the available episode count
- **System:** Update packages
- **System:** Upgrade to Firebase SDK v8.9.0
- **System:** TLS v1.3 is now fully supported
- **Tautulli:** (Activity) Activity counter badge would not completely fade away
- **Tautulli:** (Check for Updates) Checking for updates could fail in some cases
- **UI/UX:** (Bottom Sheet) Tightly size all bottom sheets to the content
- **UI/UX:** (List View) Make padding around the end of infinite list loaders and icons more consistent
- **UI/UX:** (Popup Menu) Positioning could get unaligned or broken if opened in specific views
- **UI/UX:** (Router) Slide transitions between pages could not occur on some devices
- **UI/UX:** (Snackbar) Snackbar would not be shown in some cases
- **UI/UX:** (Theme) Removed deprecated theme values

### 5.1.0

### Features

- **Dashboard:** (Modules) Show Wake on LAN tile
- **Drawer:** Ability to customize the order of modules
- **External Modules:** Ability to add and view external modules
- **Performance:** Build LunaSea with pre-compiled SkSL shaders

### Tweaks

- **Dashboard:** (Calendar) Add divider between calendar and calendar entries
- **Dashboard:** (Modules) Synchronize module ordering with drawer ordering
- **Drawer:** Default to sorting modules alphabetically
- **Settings:** (Configuration) Alphabetically sort the modules

### Bug Fixes

- **Flutter:** Update packages
- **Flutter:** Upgrade to Firebase SDK v7.11.0
- **Locale:** Ensure that the date formatter uses the currently set locale
- **Radarr:** (Manual Import) Could not select movie when using Radarr v3.1.0+
- **Search:** Indexers would not load in some cases when the headers map was null/empty
- **Settings:** (Connection Test) Connection tests could fail unexpectedly
- **Settings:** (Dialogs) Ensure all bulleted lists in dialogs are left aligned
- **Sonarr:** (Edit) Grey screen could be shown when a user has no tags
- **Sonarr:** (Edit) Grey screen could be shown when a user has no language profiles
- **Tautulli:** (Graphs) Line chart tooltips had incorrect data
- **UI/UX:** Popup menus were not aligned correctly
- **UI/UX:** (Buttons) Border would incorrectly be applied to buttons with a background colour set
- **UI/UX:** (ListView) Vertical padding did not match horizontal padding

### 5.0.1

### Bug Fixes

- **iOS:** LunaSea would hard crash on startup on iOS 12 or lower devices

### 5.0.0

### Features

- **-arr:** (Content Details) Added a button to the AppBar to jump directly into the edit page
- **-arr:** (Releases) Match torrent seeder colours to the web GUI
- **Android:** Attach module headers to requests when viewing the web GUI
- **Android:** Set status and navigation bar colours to match LunaSea
- **Dashboard:** "Home" has been renamed to "Dashboard"
- **Logger:** Utilize a new, custom built on-device logging system
- **Logger:** Compact/delete old log entries once the log count passes 100
- **Logger:** Exported logs are now in JSON format
- **Logger:** Switch to Firebase Crashlytics from Sentry for crash and log monitoring
- **Logger:** Added Firebase Analytics for breadcrumb tracking in crashes
- **Notifications:** Support for webhook-based rich push notifications
- **NZBGet:** (Queue) Add category to the queue tile
- **Quick Actions:** Default "Settings" quick action added to end of the list (if there is room)
- **Radarr:** Completely rewritten from the ground-up
- **Radarr:** (Catalogue) If no movie is found in the search query, given an option to search to add the movie
- **Radarr:** (Discover) Ability to discover movies from your import lists & Radarr recommendations
- **Radarr:** (Filtering/Sorting) Many additional filtering and sorting options
- **Radarr:** (History) Now an infinite scrolling list
- **Radarr:** (Manual Import) Ability to manually import content from the filesystem
- **Radarr:** (Movie) Cast information, movie-specific history, more detailed file information, & more detailed overview page
- **Radarr:** (Queue) View, update, and manage items in the queue
- **Radarr:** (System Status) Page to view status, health, and disk spaces
- **Radarr:** (Tags) Manage, set, and delete tags
- **SABnzbd:** (Queue) Add category to the queue tile
- **Search:** (Results) Show clickable comment and download links in the expanded table
- **Search:** (Results) Now supports infinite scrolling for loading additional pages of results
- **Settings:** (Notifications) Added page to setup webhook-based push notifications
- **Settings:** (Radarr) Ability to toggle on or off Radarr suggestions in the discover page
- **Settings:** (Radarr) Ability to set sorting direction, category, and filtering method
- **Settings:** (Resources) Added link to Weblate localization page
- **Settings:** (Resources) Added link to hosted services status page
- **Settings:** (Search) Ability to toggle off showing comment and download links
- **Settings:** (System) Ability to disable Firebase Analytics and Firebase Crashlytics
- **Sonarr:** (Catalogue) If no series is found in the search query, given an option to search to add the series
- **Sonarr:** (Queue) Refreshing the queue will now also refresh the monitored downloads from the clients
- **Tautulli:** (Activity) Show custom season titles from Plex's new TV agent
- **Tautulli:** (Activity) Show session type and bandwidth type breakdown on activity page
- **Tautulli:** (Activity) Show subtitle stream decision
- **UI/UX:** (Experience) Ability to tap the AppBar to scroll to top
- **UI/UX:** (Experience) If the list is in a tabbed PageView, tapping the active tab will scroll the list to the top
- **UI/UX:** (Experience) If the keyboard is open, scrolling the list, swiping between pages, or opening the drawer will dismiss the keyboard
- **UI/UX:** (Experience) Added haptic feedback to all buttons, toggles, and dropdowns

### Tweaks

- **-arr:** (Releases) Improve the layout of the rejection reasons dialog
- **Dashboard:** (Calendar) Set bounds to calendar
- **Dashboard:** (Calendar) Removed month header from calendar
- **Dashboard:** (Calendar) Disable calendar days outside of the past and future date range
- **Dashboard:** (Calendar) Made the styling for calendar slightly more consistent
- **Logger:** Removed viewing the stack trace within the application (still viewable within the exported logs)
- **NZBGet:** (Queue) Submenu for queued NZBs are now accessible via a single tap on the tile
- **NZBGet:** (Queue) Reordering queue items now occurs by dragging via the handle
- **Radarr:** Now only supports v3.0.0 and higher of Radarr
- **Radarr:** Many visual changes, too many to list
- **Radarr:** The tab "History" has been replaced with "More"
- **Radarr:** (Edit) Monitor toggle has been moved to the edit prompt
- **SABnzbd:** (Queue) Submenu for queued NZBs are now accessible via a single tap on the tile
- **SABnzbd:** (Queue) Reordering queue items now occurs by dragging via the handle
- **Search:** (Results) Now returns 50 results per infinite scrolling page
- **Search:** (Results) Removed support for sorting and filtering results
- **Settings:** (Account) Removed the ability to pull user ID or device ID from help dialog
- **Settings:** (Configuration) Sort configuration options within modules for cleaner isolation and easier expansion for future configuration options
- **Settings:** (Profiles) Renaming a profile now checks for an existing profile with the same name within the prompt
- **Settings:** (Profiles) Adding a profile now checks for an existing profile with the same name within the prompt
- **Settings:** (Profiles) The delete profile prompt now hides the currently enabled profile, and shows a snackbar if only one profile exists
- **Settings:** (Wake on LAN) Allow clearing the broadcast and MAC addresses to empty values
- **Tautulli:** (Activity) Cleanup player information to more closely resemble web GUI
- **Tautulli:** (Activity) Show the full season title
- **UI/UX:** (Accessibility) Added more descriptive tooltips to all popup menu buttons
- **UI/UX:** (Bottom Sheet) Bottom modal sheets lists will now shrink wrap to match content height
- **UI/UX:** (Brands) Updated the logo to The Movie Database's new logo
- **UI/UX:** (Design) Active tab in navigation bar now has a border with the AMOLED theme
- **UI/UX:** (Design) Adjusted the style of splash/highlight inking
- **UI/UX:** (Design) Reduced the weight of bold text across the application
- **UI/UX:** (Design) Added padding to bottom of lists for devices that require a safe area
- **UI/UX:** (Design) Minor tweaks to the colour palette
- **UI/UX:** (Design) Unify the design and size of all action buttons
- **UI/UX:** (Design) Sticky primary action buttons to the bottom navigation bar area
- **UI/UX:** (Design) Removed all deprecated UI elements and usages
- **UI/UX:** (Design) Many additional, minor tweaks to the design
- **UI/UX:** (Drawer) Removed the option to use categories/folders in the drawer
- **UI/UX:** (Navigation) Jump instead of animate to page when tapping a navbar item
- **UI/UX:** (Profiles) Highlight active profile in profile switcher popup menus

### Bug Fixes

- **Android:** Remove legacy external storage permission
- **Dashboard:** (Calendar) Stored current date would not update on date change
- **Flutter:** Fully upgrade to Flutter v2
- **Flutter:** Update packages
- **iOS:** Share sheet would not appear on iPadOS devices
- **Networking:** Headers would not get attached in some networking configurations
- **NZBGet:** (Queue) Would not refresh in some cases when switching profiles
- **Quick Actions:** Improve package internal native channel
- **SABnzbd:** (Queue) Would not refresh in some cases when switching profiles
- **Settings:** (Configuration) Newly set headers would sometimes not be passed to the connection test
- **Sonarr:** (Add) Series type would not be set correctly when adding a new series
- **Sonarr:** (Edit) Series path prompt would show an incorrect title
- **Sonarr:** (Queue) Ensure the trailing icon on queue entries is centered vertically
- **Sonarr:** (Releases) Default sorting direction was using catalogue default value
- **Strings:** Safe-guard many substring operations
- **Tautulli:** (Activity) Play/paused/buffering icon was not properly left aligned to the text
- **Tautulli:** (Graphs) Description of some graphs were not correct (Thanks @ZuluWhiskey!)
- **Tautulli:** (IPs) Fix location showing as null for local addresses
- **Tautulli:** (Users) User images would not be fetched on newer versions of Tautulli
- **UI/UX:** (Bottom Sheet) Reduce swipe down to dismiss threshold to 10% of height
- **UI/UX:** (Design) Margin/size of sort/filter buttons were off by a few pixels
- **UI/UX:** (Design) InkWell splash now clips correctly to the rounded borders of popup menu buttons
- **UI/UX:** (Design) Vertical padding around title when the profile dropdown is visible was incorrect
- **UI/UX:** (Design) Some elements were using the system colours instead of the LunaSea colours
- **UI/UX:** (Images) Normalize size of all branded logos to have the same widths for consistency
- **UI/UX:** (Images) Prevent attempting to load background images that are passed an empty URL
- **UI/UX:** (Snackbar) Remove all uses of the deprecated snackbar
- **UI/UX:** (Snackbar) All error snackbar will now have a button to view the error
- **URLs:** Safe-guard launching specific invalid URLs

### 4.2.1

### Features

- **Accounts:** Ability to send a password reset email
- **Accounts:** Associate the LunaSea website domain for better autofill support

### Tweaks

- **Sonarr/Upcoming:** Change "Not Downloaded" to "Missing"

### Bug Fixes

- **Alerts/Changelog:** Changelog would be shown again when restoring a backup from a previous version
- **Sonarr/Add:** Fixed error log showing series ID as null

### 4.2.0

### Features

- **Accounts:** Added LunaSea accounts
- **Accounts:** Ability to backup, restore, and delete cloud configurations
- **Accounts:** Register device token to database for future notification support
- **Backups:** All backups now contain all customization and configuration options in LunaSea (New backups are required to utilize this)
- **Changelog:** Show changelog on launch if a new version is installed
- **Changelog:** Use a new bottom sheet UI for the changelog
- **Settings/Modules:** Add an information/help button with module descriptions and links
- **Sonarr/Releases:** Added loading state to download buttons to prevent triggering multiple downloads of the same release

### Tweaks

- **Radarr:** Always show the amount of days content will be available instead of limiting it to only content in the next 30 days
- **Settings:** Moved "Backup & Restore" and "Logs" to "System" section
- **Settings:** Merged "Customization" and "Modules" sections into "Configuration"
- **Settings/Sonarr:** Removed the need to enable Sonarr to test the connection
- **Settings/Tautulli:** Removed the need to enable Tautulli to test the connection

### Bug Fixes

- **Flutter:** Updated packages
- **In App Purchases:** Ensure all in app purchases are marked as consumed
- **Logging:** Updated Sentry to v4 framework to improve capturing fatal/crashing bugs
- **Settings/Logs:** Hide exception and stack trace buttons when an error is not available
- **Settings/Resources:** Updated URL endpoints
- **Sonarr/History:** Fixed cases where history fetched the oldest entries, not the newest
- **Sonarr/Upcoming:** If an episode has not aired, show it as "Unaired" instead of "Not Downloaded"
- **State:** Correctly clear state when clearing LunaSea's configuration
- **Tautulli/Activity:** Fixed consistency of hardware transcoding indicator compared to the web UI
- **UI/Divider:** Fixed consistency of divider width across regular and AMOLED dark theme

### 4.1.1

### Bug Fixes

- **Sonarr/v2:** Fix inability to interactively search for releases
- **Routing:** Fix black screen when popping back from nested calendar routes

### 4.1.0

### Features

- **Backup & Restore:** Backup files now use the .LunaSea extension (older .json backups are still supported)
- **Filesystem:** Any saves to the filesystem now uses the system share sheet
- **Images:** Ability to set (or entirely disable) the opacity of the background image for cards
- **Networking:** Strict TLS/SSL validation is now disabled globally
- **Routing:** Hold the AppBar back button to pop back to the home page of the module
- **Settings/Sonarr:** Toggle to enable Sonarr v3 features
- **Sonarr:** A ground-up re-implementation of Sonarr
- **Sonarr:** State is now held across module switches
- **Sonarr/Add:** (v3 only) Tapping an already-added series will take you to the series page
- **Sonarr/Add:** Automatically navigate to a newly added series
- **Sonarr/Add:** Ability to set tags and (v3 only) language profile when adding a new series
- **Sonarr/Catalogue:** Ability to view all, only monitored, or only unmonitored series
- **Sonarr/Catalogue:** Ability to set the default sorting type and direction (in the settings)
- **Sonarr/Edit:** Ability to update tags and (v3 only) language profile
- **Sonarr/Episodes:** If the episode is in the queue, show details of the download status
- **Sonarr/Overview:** View tags and (v3 only) language profile applied to the series
- **Sonarr/Queue:** Ability to view and manage your queue
- **Sonarr/Releases:** (v3 only) Ability to interactively search for season packs
- **Sonarr/Releases:** Ability to view all, only approved, or only rejected releases
- **Sonarr/Releases:** Ability to set the default sorting type and direction (in the settings)
- **Sonarr/Tags:** Ability to add, view, and delete tags
- **Tautulli/Activity:** Show the ETA for when the session will be completed
- **Tautulli/Activity:** Show if hardware transcoding is being used on the stream

### Tweaks

- **Radarr:** Use Radarr v3 icon across the UI
- **Settings/Dialogs:** Small tweaks and additional notes for entering hosts and passwords
- **Settings/Host Dialog:** Add validator on host to ensure user adds http:// or https://
- **Settings/Resources:** Hide link to documentation until I actually finish it
- **Sonarr:** Many changes to Sonarr's design
- **Sonarr/Series:** Toggling monitored state of series has now been moved to the edit prompt and edit screen

### Bug Fixes

- **Backup & Restore:** Fix grey screen when restoring a backup without a "default"-named profile (new backups are not required)
- **Build:** (Android) Update gradle
- **Build:** (iOS) Reintegrate cocoapods podfile
- **Filesystem:** (Android) Using the share sheet now fixes the issue of inaccessible logs, backups, and downloads on Android 10+ devices
- **Flutter:** Update packages
- **Images:** Images will now load for invalid/self-signed certificates
- **Networking:** Ensure that insecure (HTTP/80) connections are allowed at the platform-level
- **Tautulli/Activity:** Fix grey screen for music activity
- **TextField:** Fix TextField actions (cut, copy, paste, etc.) not showing
- **Timestamps:** Fix 12:xx AM being shown as 00:xx AM when using 12-hour time
- **UI/Checkbox:** Fix overly vibrant checkbox selected background
- Tons of additional minor bugs were fixed

### 4.0.0

### Features

- **Module:** Tautulli support
- **Calendar:** Ability to set how many days in the past and future to fetch calendar entries for
- **Drawer:** Categorical folders are now optional
- **Drawer:** If using folders, ability to set the initial expanded state
- **Locale:** Ability to use 24 hour timestamps
- **Quick Actions:** Ability to set up to four home screen quick actions
- **Search:** Ability to set custom headers for individual indexers
- **Settings:** Complete overhaul of the settings
- **Settings/Resources:** (iOS) Added link to join TestFlight

### Tweaks

- **Home/Calendar:** Separate calendar view type into its own preference
- **Home/Calendar:** Show no modules enabled message when there are no automation modules enabled, not just no modules overall
- **Home/Calendar:** Default past and future days is now 14 days for each
- **Images:** Images are no longer cached to the device storage to heavily improve performance & reduce crashing on older/lower-end devices
- **Images:** Fetch images at specific resolutions instead of full resolution to reduce network performance and decrease memory pressure
- **Search:** Improved detection of adult categories
- **Settings:** Settings now replaces the active module/route and shows the drawer on the base route
- **Settings/System:** Removed clear image cache tile
- **UI:** Added new loading animation design

### Bug Fixes

- **Flutter:** Updated packages & Flutter
- **General:** Many small bug fixes
- **LunaSea:** Many behind the scenes changes to reduce memory pressure
- **LunaSea:** Heavy improvements and fixes to the navigation routing
- **Settings/Logs:** Logs could be shown in reverse order
- **Text:** Fixed "squished" text on iOS 14 and higher devices

### 3.3.0

### Features

- **Home/Calendar:** New "schedule" view
- **Home/Modules:** Option to use module "brand colour" or the LunaSea list colours
- **Search:** Option to hide adult categories
- **-arr/Catalogue:** Ability to sort by date added
- **-arr/Search:** Show the indexer/tracker on the collapsed tile

### Bug Fixes

- **Sonarr:** Fixed multiple errors related to parsing fetched episode data
- **Everything:** Multiple smaller crash/error fixes

### 3.2.0

### Features

- **Drawer:** Add the LunaSea logo to the header
- **Logging:** Integrated Sentry, an open-source exception/crash log aggregation tool
- **Settings/System:** Added toggle (under system -> advanced) to disable Sentry logging

### Tweaks

- **System:** Implemented new image caching backend
- **APIs:** Improved exception logging
- **Logging:** Improved on-device logger to have more useful stack traces

### Bug Fixes

- **-arr/Details:** Fixed crash related to state management
- **radarr/Add:** Fixed crash when a searched movie does not have a minimum availability value available

### 3.1.0

### Features

- **Settings/Resources:** Added Discord invite link for official server
- **-arr:** Ability to search and enter interactive search from all upcoming and missing pages
- **-arr/Add:** Ability to jump directly into newly added content from toast notification
- **Radarr/Delete:** Ability to add to exclusion list when deleting content
- **Clients:** Hide and show queue pause/start FAB on scroll
- **Clients/History:** History tiles are now expandable in-line
- **SABnzbd/Statistics:** Show both temporary and final storage space
- **Calendar:** Ability to search/enter interactive search directly from calendar tiles

### Tweaks

- **Development:** Updated Flutter packages

### Bug Fixes

- **API/Host:** Correctly handle cases where host ends with a forward slash

### 3.0.0

### Features

- **Search:** Releases are now shown as an expandable tile
- **Search/Category Results:** Ability to sort and filter results
- **Search/Search Results:** Ability to sort search results
- **-rr/Catalogue:** Many additional sorting options
- **-rr/Releases:** Releases are now shown as an expandable tile
- **-rr/Releases:** Ability to sort, hide, and filter releases
- **Sonarr/Add:** Ability to set initial episode monitoring state
- **Sonarr/Episodes:** Episodes are now shown as an expandable tile
- **Radarr/Releases:** Shows custom format tags
- **Clients:** FAB icon animates between queue state
- **Images:** Ability to clear network image cache
- **UI/AMOLED Theme:** Optional setting to add subtle border

### Tweaks

- **Changelog:** Removed integrated changelog, redirects to documentation changelog
- **-rr:** Use the term "Interactive" instead of "Manual" for search
- **-rr/Links:** Normalize size of images
- **Sonarr/Upcoming:** Now shows dates in-line as a styled header
- **Sonarr/Season View:** Now shows season number in-line as a styled header
- **UI/Font:** Adjusted font size across entire application
- **UI/Dropdowns:** Change dropdowns to popup menus
- **UI:** Rounder radius around tiles, popups, etc.

### Bug Fixes

- **Home/Calendar:** Row height is now statically set to prevent huge calendar on larger displays
- **Sonarr/Seasons:** Fixed crash related to seasons with no statistics data for percentage of season completion
- **Sonarr/Episodes:** Episode numbers greater than 100 could cause a line-break
- **Sonarr/Episodes:** Fixed/safe-guarded layout crash on incomplete episode data received
- **Sonarr/Queue:** Safe-guarded Sonarr queue results when results are null
- **Snackbar:** Snackbar wouldn't adopt AMOLED styling when enabled
- **State:** Fixed crashes caused by setting the state of an unmounted widget

### 2.3.0

### Features

- **Module:** Wake on LAN support
- **Settings/Modules:** Ability to set custom headers to be attached to module requests
- **Settings/Changelog:** Changelog is now displayed as a route, not a dialog
- **UX:** Hitting the back button on apex/primary routes will now open the drawer instead of closing the application
- **UX:** Enable landscape mode for iPhones

### Tweaks

- **-rr/Details:** Removed sliver AppBar and fanart as it caused unwanted scrolling interference (A revamped overview page in the future will bring back the fanart images)
- **-rr/Details:** Switched from AppBar tabs to bottom navigation bar
- **-rr/Release:** Do not show warning message when triggering a release download from details page on rejected release
- **Dialogs:** Re-implemented all dialogs
- **Dialogs:** Keyboard type is now set for all inputs
- **Dialogs:** All inputs are now validated (to some extent) and can be submitted via the Keyboard

### Bug Fixes

- **SnackBar:** SnackBar could cause UI locking when doing swipe-back gestures

### 2.2.0

### Features

- **Donations:** Added donation IAPs
- **Profiles:** Added rapid-profile switcher
- **Settings:** Added license attributions
- **Settings:** Added feedback link
- **-rr/Add:** Search bar will now be autofocused
- **SABnzbd:** Added statistics for individual servers
- **NZBGet:** Option to use basic authentication instead of URL-encoded authentication

### Tweaks

- **UI:** Removed custom letter spacing
- **Settings:** Added subheaders

### Bug Fixes

- **Database:** Cleanly exit on clean application exit to prevent corruption

### 2.1.0

### Features

- **Branding:** New icon & splash screen
- **Links:** Ability to set which browser you open links in (iOS only)
- **Home/Calendar:** Ability to set starting day of week
- **Home/Calendar:** Ability to set starting calendar size
- **Home/Calendar:** Ability to enable and disable specific modules that show up in the calendar
- **Appearance/Theme:** Option to enable AMOLED black theme
- **Platform:** LunaSea is now build-able & available for Android

### Tweaks

- **Settings:** Redesign of settings page
- **General:** Use the term "Modules" instead of "Services"
- **-rr/Details:** Background image header/app bar is now collapsed by default
- **-rr/Details:** Left align title to match the rest of LunaSea

### Bug Fixes

- **Sonarr:** Toast for toggling season monitor state would show monitor status of the series, not the season
- **Settings/Backup:** Backing up your configuration would always fail
- **Search:** Would show an empty screen if you deleted all indexers while search is open

### 2.0.1

### Features

- **SABnzbd:** Ability to upload .rar & .gz archives
- **-rr/Add:** All configurable values are now stored in cold database, persisting between sessions
- **-rr/Add:** Root folders now also show available space for the folder
- **Search:** When sending an NZB to a client, there is now an action in the toast to jump directly to the respective client
- **Automation/Search:** When downloading a release manually, there is now an action in the toast to pop back to the main screen of the automation service
- **Settings:** Ability to disable SSL/TLS validation for all services
- **HTTP:** With the above, support for self-signed SSL certificates

### Tweaks

- **Descriptions:** Adjusted alignment and consistency when no summary is available
- **Search:** Removed redundant “Sending” toast since it very quickly gets covered by the follow-up toast
- **Automation:** Edit content prompt now shows full title of the content
- **Clients:** Opening the edit menu now shows the full title of the job
- **UI:** Tweaked design of content headers
- **Settings:** Added headers to automation and client pages to separate regular and advanced configuration options

### Bug Fixes

- **HTTP:** Safer handling of redirects
- **Routes:** Make route changes asynchronous to help minimize stutters
- **Radarr/Add:** Fixed wrong title for minimum availability card
- **Restore Configuration:** Error message had typos
- **UI:** Fixed uneven font sizing in some prompts
- **NZBGet/SABnzbd:** Failure on uploading an NZB would show no error message

### 2.0.0

### Features

- **iOS:** Built for iOS 13.4
- **Indexers/Search:** Full support for browsing and searching Newznab-based indexers!
- **Indexers/Search:** Support for NZBHydra2
- **Indexers/Search:** Download NZB files directly to your device
- **Indexers/Search:** Send NZB files directly from the indexer to your client of choice
- **-rr/Catalogue:** Catalogue search bar is now stickied
- **-rr/History:** Ability to enter content
- **-rr/Add:** More information (year, seasons, etc.) shown in result tiles
- **NZBGet:** Ability to search through fetched history
- **SABnzbd:** Ability to search through fetched history
- **Settings/Configuration:** Ability to clear configuration
- **Drawer:** Ability to switch profiles in navigation Drawer
- **Snackbar:** New snackbar style, design, and formatting
- **Everything:** All services now dynamically reload on profile changes

### Tweaks

- **Everything:** Re-implemented... everything
- **Everything:** Moved away from FABs (where possible) to buttons
- **Navigation:** Ability to swipe left and right between bottom navigation tabs (except Settings)
- **Navigation Bar:** Slightly redesigned
- **Home/Summary:** Redesigned summary page
- **Home/Summary:** Removed fetching of series count, movie count, and artist count
- **Home/Calendar:** Now only shows 1 dot for each day instead of 3
- **Home/Calendar:** Highlights today as well as selected day
- **Home/Calendar:** Now shows the day of the week on the calendar
- **Home/Calendar:** Now defaults to showing 1 week (swipe down to show two weeks or one month)
- **Settings:** No longer a need to save configuration settings, everything is saved automatically
- **Search Bar:** "X" to clear search bars
- **-rr/Catalogue:** Sorting now scrolls back to top
- **-rr/Catalogue:** Moved hide unmonitored button to stickied search bar
- **-rr/Add:** Selected profile, folders, etc. are stored in state until application is closed or profile is switched
- **-rr/Images:** Images now show placeholder, transition to real content on load
- **Sonarr/Episodes:** Multi-select episodes with single tap anywhere on tile, now highlighted for easier distinction
- **SABnzbd:** Limit queue to first 100 results
- **SABnzbd:** Lowered refresh rate to 2 seconds from 1 second
- **NZBGet:** Limit queue to first 100 results
- **NZBGet:** Lowered refresh rate to 2 seconds from 1 second
- **UI:** Reduced elevation of UI in general

### Bug Fixes

- **Sonarr/Search:** Searching for an entire season now executes a season search instead of individual episode searches
- **Logs:** Fixed bug where logs could not load in some cases and always show "Logs Not Found"
- **Radarr/Search:** Now correctly retains search state to prevent needless researching & API hits
- **Configuration:** Deleting or renaming "default" profile could cause a new "default" profile to be created on next launch

### 1.1.0

### Features

- **Home:** Calendar view for upcoming -rr content
- **Sonarr:** Ability to toggle single episode monitored status
- **Sonarr:** Ability to delete file
- **Radarr:** Split missing tab into missing and upcoming
- **-rr:** Long-press tile on non-catalogue pages to view catalogue entry
- **-rr:** Ability to delete files when deleting catalogue entries
- **Documentation:** Added a link to WIP documentation

### Bug Fixes

- **Prompts:** All prompts now use the correct colour ordering
- **NZBGet:** Adjusted authentication method to interfere less with custom auth setups

### Tweaks

- **Drawer:** Dropdown groups are open by default until more services are added
- **Settings:** Minor tile shuffling and rewording
- **Navigation:** New style for the navigation bars
- **Navigation:** Added custom icons to navigation bars
- **Releases:** Easier to differentiate the release's protocol

### 1.0.0

### Features

- **-rr:** When adding new content, checks if content is already in your library
- **-rr:** Ability to sort catalogue by size of alphabetical
- **Settings:** Ability to rename a profile
- **SAB/NZBGet:** Ability to pause the queue for some amount of time
- **NZBGet:** Ability to filter out successful history entries

### Bug Fixes

- **Radarr:** Fetching quality profiles could fail
- **SAB/NZBGet:** Percentage calculation could fail causing a grey screen
- **SAB/NZBGet:** Connection error now cancels timer until manual refresh (cleaner logs)

### Tweaks

- **Build:** Adjusted how build number is presented
- **Sonarr:** Now shows size on disk on catalogue page
- **Lidarr:** Now shows size on disk on catalogue page
- **Settings:** Successful connection test now also triggers save
- **Settings:** Save button is now more obvious/clear
- **Settings:** Adjusted and added more tips when adding hosts
