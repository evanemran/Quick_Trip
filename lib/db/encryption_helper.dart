import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  static final _key = Key.fromUtf8('12345678901234567890123456789012');

  static String encrypt(String plainText) {
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Store IV + cipherText
    final payload = {
      'iv': iv.base64,
      'data': encrypted.base64,
    };

    return base64Encode(utf8.encode(jsonEncode(payload)));
  }

  static String decrypt(String encryptedText) {
    final decoded = utf8.decode(base64Decode(encryptedText));
    final Map<String, dynamic> payload = jsonDecode(decoded);

    final iv = IV.fromBase64(payload['iv']);
    final cipherText = payload['data'];

    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    return encrypter.decrypt64(cipherText, iv: iv);
  }
}