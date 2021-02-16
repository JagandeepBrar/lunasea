import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseMessaging {
    /// Returns an instance of [FirebaseMessaging].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseMessaging get instance => FirebaseMessaging.instance;

    /// Returns a [Stream] to handle any new messages that are received while the application is in the open and in foreground.
    Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

    /// Returns a [Stream] to handle any notifications that are tapped while the application is in the background (not terminated).
    Stream<RemoteMessage> get onMessageOpenedApp => FirebaseMessaging.onMessageOpenedApp;

    /// Request for permission to send a user notifications.
    /// 
    /// Returns true if permissions are allowed at either a full or provisional level.
    /// Returns false if permissions are denied or not determined.
    Future<bool> requestNotificationPermissions() async {
        NotificationSettings settings = await instance.requestPermission();
        switch(settings.authorizationStatus) {
            case AuthorizationStatus.authorized:
            case AuthorizationStatus.provisional: return true;
            case AuthorizationStatus.denied:
            case AuthorizationStatus.notDetermined:
            default: return false;
        }
    }

    /// Returns the Firebase Cloud Messaging device token for this device.
    Future<String> get token async => instance.getToken();

    /// Return a [StreamSubscription] that will show a notification banner on a newly received notification.
    /// 
    /// This listens on [FirebaseMessaging.onMessage], where the application must be open and in the foreground.
    StreamSubscription<RemoteMessage> showNotificationOnMessageListener() {
        return onMessage.listen((message) {
            if(message == null) return;
            showLunaSnackBar(
                title: message.notification?.title ?? 'Unknown Content',
                message: message.notification?.body ?? Constants.TEXT_EMDASH,
                type: LunaSnackbarType.INFO,
                position: FlashPosition.top,
                duration: Duration(seconds: 6, milliseconds: 750),
            );
        });
    }
}
