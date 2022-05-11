import 'package:encrypt/encrypt.dart';

import 'package:lunasea/system/logger.dart';
import 'package:lunasea/vendor.dart';

class LunaEncryption {
  const LunaEncryption._();

  Key _generateKey(String key) {
    const _length = 32;
    const _pad = '0';
    String _morphed = (key + key).padRight(_length, _pad).substring(0, _length);
    return Key.fromUtf8(_morphed);
  }

  IV _generateIV() {
    const _length = 16;
    return IV.fromLength(_length);
  }

  /// Encrypt the unencrypted string [data] using the given encryption [key]
  String encrypt(String key, String data) {
    try {
      final _encrypter = Encrypter(AES(_generateKey(key)));
      return _encrypter.encrypt(data, iv: _generateIV()).base64;
    } catch (error, stack) {
      LunaLogger().error('Failed to encrypt data', error, stack);
      rethrow;
    }
  }

  /// Decrypt the encrypted string [data] using the given encryption [key]
  String decrypt(String key, String data) {
    try {
      final _encrypter = Encrypter(AES(_generateKey(key)));
      return _encrypter.decrypt64(data, iv: _generateIV());
    } catch (error, stack) {
      LunaLogger().error('Failed to decrypt data', error, stack);
      rethrow;
    }
  }
}

final encryptionProvider = Provider((_) => const LunaEncryption._());
