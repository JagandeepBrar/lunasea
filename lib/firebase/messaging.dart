import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/core.dart';
import 'package:lunasea/system/platform.dart';

class LunaFirebaseMessaging {
  static const _VAPID_KEY =
      'BGCP2BO8JOTuvagaYl41btXiiC_XszsGCDduq6C-escc4xb2UMglX3RDojCY1YuGMAx2lXGVF-VYmTN3LQGvhYc';

  static bool get isSupported {
    final platform = LunaPlatform();
    if (LunaFirebase.isSupported && !platform.isWeb) return true;
    return false;
  }

  /// Returns an instance of [FirebaseMessaging].
  ///
  /// Throws an error if [LunaFirebase.initialize] has not been called.
  static FirebaseMessaging get instance => FirebaseMessaging.instance;

  /// Returns a [Stream] to handle any new messages that are received while the application is in the open and in foreground.
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  /// Returns a [Stream] to handle any notifications that are tapped while the application is in the background (not terminated).
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  /// Returns the Firebase Cloud Messaging device token for this device.
  Future<String?> get token async => instance.getToken(vapidKey: _VAPID_KEY);

  /// Request for permission to send a user notifications.
  ///
  /// Returns true if permissions are allowed at either a full or provisional level.
  /// Returns false if permissions are denied or not determined.
  Future<bool> requestNotificationPermissions() async {
    try {
      NotificationSettings settings = await instance.requestPermission();
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
        case AuthorizationStatus.provisional:
          return true;
        case AuthorizationStatus.denied:
        case AuthorizationStatus.notDetermined:
        default:
          return false;
      }
    } catch (error, stack) {
      LunaLogger()
          .error('Failed to request notification permission', error, stack);
      return false;
    }
  }

  /// Return the current notification authorization status.
  Future<AuthorizationStatus> getAuthorizationStatus() async {
    return instance
        .getNotificationSettings()
        .then((settings) => settings.authorizationStatus);
  }

  /// Returns true if permissions are allowed at either a full or provisional level.
  /// Returns false on any other status (denied, not determined, null, etc.).
  Future<bool> areNotificationsAllowed() async {
    return instance.getNotificationSettings().then((settings) {
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
        case AuthorizationStatus.provisional:
          return true;
        case AuthorizationStatus.denied:
        case AuthorizationStatus.notDetermined:
        default:
          return false;
      }
    });
  }

  /// Return a [StreamSubscription] that will show a notification banner on a newly received notification.
  ///
  /// This listens on [FirebaseMessaging.onMessage], where the application must be open and in the foreground.
  StreamSubscription<RemoteMessage> registerOnMessageListener() {
    return onMessage.listen((message) {
      if (LunaDatabaseValue.ENABLE_IN_APP_NOTIFICATIONS.data) return;

      LunaModule? module = LunaModule.DASHBOARD.fromKey(message.data['module']);
      showLunaSnackBar(
        title: message.notification?.title ?? 'Unknown Content',
        message: message.notification?.body ?? LunaUI.TEXT_EMDASH,
        type: LunaSnackbarType.INFO,
        position: FlashPosition.top,
        duration: const Duration(seconds: 6, milliseconds: 750),
        showButton: module != null,
        buttonOnPressed: () async => _handleWebhook(message),
      );
    });
  }

  /// Returns a [StreamSubscription] that will handle messages/notifications that are opened while LunaSea is running in the background.
  ///
  /// This listens on [FirebaseMessaging.onMessageOpenedApp], where the application must be open but in the background.
  StreamSubscription<RemoteMessage> registerOnMessageOpenedAppListener() =>
      onMessageOpenedApp.listen(_handleWebhook);

  /// Check to see if there was an initial [RemoteMessage] available to be accessed.
  ///
  /// If so, handles the notification webhook.
  Future<void> checkAndHandleInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    _handleWebhook(message);
  }

  /// Shared webhook handler.
  Future<void> _handleWebhook(RemoteMessage? message) async {
    if (message == null || message.data.isEmpty) return;
    // Extract module
    LunaModule? module = LunaModule.DASHBOARD.fromKey(message.data['module']);
    if (module == null) {
      LunaLogger().warning(
        'LunaFirebaseMessaging',
        '_handleWebhook',
        'Unknown module found inside of RemoteMessage: ${message.data['module'] ?? 'null'}',
      );
      return;
    }
    String profile = message.data['profile'] ?? '';
    if (profile.isEmpty) {
      LunaLogger().warning(
        'LunaFirebaseMessaging',
        '_handleWebhook',
        'Invalid profile received in webhook: ${message.data['profile'] ?? 'null'}',
      );
      return;
    }
    bool result = await LunaProfile().safelyChangeProfiles(
      profile,
      popToFirst: true,
    );
    if (result) {
      module.handleWebhook(message.data);
    } else {
      showLunaErrorSnackBar(
        title: 'Unknown Profile',
        message: '"$profile" does not exist in LunaSea',
      );
    }
  }
}
