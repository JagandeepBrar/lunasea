import 'package:encrypt/encrypt.dart';
import 'package:lunasea/core.dart';

class LunaEncryption {
    static const int _IV_LENGTH = 16;
    static const int _KEY_LENGTH = 32;
    static const String _PAD_VALUE = '0';
    static const String ENCRYPTION_FAILURE = '<<INVALID_ENCRYPTION>>';

    /// Encrypt a given string using a given encryption key, and return the encrypted string.
    /// 
    /// The key is duped, and either trimmed or padded (with _PAD_VALUE) to 32 characters.
    String encrypt(String encryptionKey, String data) {
        try {
            String morphedKey = (encryptionKey+encryptionKey).padRight(_KEY_LENGTH, _PAD_VALUE).substring(0, _KEY_LENGTH);
            Key key = Key.fromUtf8(morphedKey);
            IV iv = IV.fromLength(_IV_LENGTH);
            final _encrypter = Encrypter(AES(key));
            final _encrypted = _encrypter.encrypt(data, iv: iv).base64;
            return _encrypted;
        } catch (error, stack) {
            LunaLogger().error('Failed to decrypted "$data" with using key "$encryptionKey"', error, stack);
        }
        return ENCRYPTION_FAILURE;
    }

    /// Decrypt a given string using a given encryption key, and return the decrypted string.
    /// 
    /// The key is duped, and either trimmed or padded (with _PAD_VALUE) to 32 characters.
    String decrypt(String decryptionKey, String data) {
        try {
            String morphedKey = (decryptionKey+decryptionKey).padRight(_KEY_LENGTH, _PAD_VALUE).substring(0, _KEY_LENGTH);
            Key key = Key.fromUtf8(morphedKey);
            IV iv = IV.fromLength(_IV_LENGTH);
            final _encrypter = Encrypter(AES(key));
            return _encrypter.decrypt64(data, iv: iv);
        } catch (error) {
            /// Do not log as error (to Sentry), since a decrpytion error is very likely a user problem
            LunaLogger().warning('LunaEncryption', 'decrypt', 'Failed to decrypted "$data" with using key "$decryptionKey"');
        }
        return ENCRYPTION_FAILURE;
    }
}
