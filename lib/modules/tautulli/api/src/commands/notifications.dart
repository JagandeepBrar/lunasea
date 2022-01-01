part of tautulli_commands;

/// Facilitates, encapsulates, and manages individual calls related to notifications within Tautulli.
///
/// [TautulliCommandHandlerNotifications] internally handles routing the HTTP client to the API calls.
class TautulliCommandHandlerNotifications {
  final Dio _client;

  /// Create a notification command handler using an initialized [Dio] client.
  TautulliCommandHandlerNotifications(this._client);

  /// Handler for [add_newsletter_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#add_newsletter_config).
  ///
  /// Add a new notification agent.
  ///
  /// Required Parameters:
  /// - `agentId`: The ID of the agent
  Future<void> addNewsletterConfig({
    required int agentId,
  }) async =>
      _commandAddNewsletterConfig(_client, agentId: agentId);

  /// Handler for [add_notifier_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#add_notifier_config).
  ///
  /// Add a new notification agent.
  ///
  /// Required Parameters:
  /// - `agentId`: The ID of the agent
  Future<void> addNotifierConfig({
    required int agentId,
  }) async =>
      _commandAddNotifierConfig(_client, agentId: agentId);

  /// Handler for [delete_mobile_device](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_mobile_device).
  ///
  /// Remove a mobile device from the database.
  ///
  /// Required Parameters:
  /// - `mobileDeviceId`: The mobile device identifier to delete
  Future<void> deleteMobileDevice({
    required int mobileDeviceId,
  }) async =>
      _commandDeleteMobileDevice(_client, mobileDeviceId: mobileDeviceId);

  /// Handler for [delete_newsletter](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_newsletter).
  ///
  /// Remove a newsletter from the database.
  ///
  /// Required Parameters:
  /// - `newsletterId`: The newsletter identifier to delete
  Future<void> deleteNewsletter({
    required int newsletterId,
  }) async =>
      _commandDeleteNewsletter(_client, newsletterId: newsletterId);

  /// Handler for [delete_notifier](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_notifier).
  ///
  /// Remove a notifier from the database.
  ///
  /// Required Parameters:
  /// - `notifierId`: The notifier identifier to delete
  Future<void> deleteNotifier({
    required int notifierId,
  }) async =>
      _commandDeleteNotifier(_client, notifierId: notifierId);

  /// Handler for [get_newsletter_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_newsletter_config).
  ///
  /// Get the configuration for an existing newsletter.
  ///
  /// Required Parameters:
  /// - `newsletterId`: The newsletter ID to fetch the configuration for
  Future<TautulliNewsletterConfig> getNewsletterConfig({
    required int newsletterId,
  }) async =>
      _commandGetNewsletterConfig(_client, newsletterId: newsletterId);

  /// Handler for [get_newsletter_log](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_newsletter_log).
  ///
  /// Get the data on the Tautulli newsletter logs table.
  ///
  /// Optional Parameters:
  /// - `orderColumn`: The column order key for sorting the newsletter records
  /// - `orderDirection`: The direction to sort the newsletter records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliNewsletterLogs> getNewsletterLog({
    TautulliNewsletterLogOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetNewsletterLog(
        _client,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [get_newsletters](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_newsletters).
  ///
  /// Get a list of configured newsletters.
  Future<List<TautulliNewsletter>> getNewsletters() async =>
      _commandGetNewsletters(_client);

  /// Handler for [get_notification_log](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notification_log).
  ///
  /// Get the data on the Tautulli notification logs table.
  ///
  /// Optional Parameters:
  /// - `orderColumn`: The column order key for sorting the notification records
  /// - `orderDirection`: The direction to sort the notification records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliNotificationLogs> getNotificationLog({
    TautulliNotificationLogOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetNotificationLog(
        _client,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [get_notifier_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notifier_config).
  ///
  /// Get the configuration for an existing notification agent.
  ///
  /// Required Parameters:
  /// - `notifierId`: The notifier ID to fetch the configuration for
  Future<TautulliNotifierConfig> getNotifierConfig({
    required int notifierId,
  }) async =>
      _commandGetNotifierConfig(_client, notifierId: notifierId);

  /// Handler for [get_notifier_parameters](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notifier_parameters).
  ///
  /// Get the list of available notification parameters.
  Future<List<TautulliNotifierParameter>> getNotifierParameters() async =>
      _commandGetNotifierParameters(_client);

  /// Handler for [get_notifiers](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notifiers).
  ///
  /// Get a list of configured notifiers.
  ///
  /// Optional Parameters:
  /// - `notifyAction`: The notification action to filter out
  Future<List<TautulliNotifier>> getNotifiers({
    String? notifyAction,
  }) async =>
      _commandGetNotifiers(_client, notifyAction: notifyAction);

  /// Handler for [notify](https://github.com/Tautulli/Tautulli/blob/master/API.md#notify).
  ///
  /// Send a notification using Tautulli.
  ///
  /// Required Parameters:
  /// - `notifierId`: The notifier identifier
  /// - `subject`: The subject of the message
  /// - `body`: The body of the message
  ///
  /// Optional Parameters:
  /// - `headers`: The JSON headers for webhook notifications
  /// - `scriptArgs`: The arguments for script notifications
  Future<void> notify({
    required int notifierId,
    required String subject,
    required String body,
    String? headers,
    String? scriptArgs,
  }) async =>
      _commandNotify(_client,
          notifierId: notifierId,
          subject: subject,
          body: body,
          headers: headers,
          scriptArgs: scriptArgs);

  /// Handler for [notify_newsletter](https://github.com/Tautulli/Tautulli/blob/master/API.md#notify_newsletter).
  ///
  /// Send a newsletter using Tautulli.
  ///
  /// Required Parameters:
  /// - `newsletterId`: The newsletter identifier.
  ///
  /// Optional Parameters:
  /// - `subject`: The subject of the newsletter
  /// - `body`: The body of the newsletter
  /// - `message`: The message of the newsletter
  Future<void> notifyNewsletter({
    required int newsletterId,
    String? subject,
    String? body,
    String? message,
  }) async =>
      _commandNotifyNewsletter(_client,
          newsletterId: newsletterId,
          subject: subject,
          body: body,
          message: message);

  /// Handler for [notify_recently_added](https://github.com/Tautulli/Tautulli/blob/master/API.md#notify_recently_added).
  ///
  /// Send a recently added notification using Tautulli.
  ///
  /// Required Parameters:
  /// - `ratingKey`: Identifier/rating key for the content that was added
  ///
  /// Optional Parameters:
  /// - `notifierId`: The identifier of the notification agent. If not supplied, the notification will send on all enabled agents
  Future<void> notifyRecentlyAdded({
    required int ratingKey,
    int? notifierId,
  }) async =>
      _commandNotifyRecentlyAdded(_client,
          ratingKey: ratingKey, notifierId: notifierId);

  /// Handler for [register_device](https://github.com/Tautulli/Tautulli/blob/master/API.md#register_device).
  ///
  /// Registers the Tautulli Android app for notifications.
  ///
  /// Required Parameters:
  /// - `deviceName`: The device name of the Tautulli Android app
  /// - `deviceId`: The OneSignal device id of the Tautulli Android app
  ///
  /// Optional Parameters:
  /// - `friendlyName`: A friendly name to identify the mobile device
  Future<void> registerDevice({
    required String deviceName,
    required String deviceId,
    String? friendlyName,
  }) async =>
      _commandRegisterDevice(_client,
          deviceId: deviceId,
          deviceName: deviceName,
          friendlyName: friendlyName);

  /// Handler for [set_mobile_device_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#set_mobile_device_config).
  ///
  /// Configure an existing mobile device agent.
  ///
  /// Required Parameters:
  /// - `mobileDeviceId`: The mobile device config to update
  ///
  /// Optional Parameters:
  /// - `friendlyName`: An optional friendly name to identify the mobile device
  Future<void> setMobileDeviceConfig({
    required int mobileDeviceId,
    String? friendlyName,
  }) async =>
      _commandSetMobileDeviceConfig(_client,
          mobileDeviceId: mobileDeviceId, friendlyName: friendlyName);

  /// Handler for [set_newsletter_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#set_newsletter_config).
  ///
  /// Configure an existing newsletter agent.
  ///
  /// Required Parameters:
  /// - `agentId`: The newsletter type of the newsletter
  /// - `newsletterId`: The newsletter config to update
  /// - `newsletterOptions`: A map containing the configuration options for the newsletter
  Future<void> setNewsletterConfig({
    required int newsletterId,
    required int agentId,
    required Map<String, dynamic> newsletterOptions,
  }) async =>
      _commandSetNewsletterConfig(_client,
          newsletterId: newsletterId,
          agentId: agentId,
          newsletterOptions: newsletterOptions);

  /// Handler for [set_notifier_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#set_notifier_config).
  ///
  /// Configure an existing notification agent.
  ///
  /// Required Parameters:
  /// - `agentId`: The agent of the notifier
  /// - `notifierId`: The notifier config to update
  /// - `notifierOptions`: A map containing the configuration options for the notifier
  Future<void> setNotifierConfig({
    required int agentId,
    required int notifierId,
    required Map<String, dynamic> notifierOptions,
  }) async =>
      _commandSetNotifierConfig(_client,
          agentId: agentId,
          notifierId: notifierId,
          notifierOptions: notifierOptions);
}
