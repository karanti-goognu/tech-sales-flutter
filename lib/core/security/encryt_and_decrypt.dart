import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tuple/tuple.dart';

String decryptString(String encryptedString, String encryptionKey) {
  var key = base64.decode(encryptionKey);

  var encryptedStringArray = encryptedString.split("~");
  var params = base64.decode(encryptedStringArray[1]);
  var cipherText = base64.decode(encryptedStringArray[0]);
  var iv = params.sublist(2); // strip the 4, 16 DER header

  var cipher = PaddedBlockCipherImpl(
    PKCS7Padding(),
    CBCBlockCipher(AESFastEngine()),
  );

  cipher.init(
    false /*decrypt*/,
    PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
      null,
    ),
  );

  var plainishText = cipher.process(cipherText);

//  print(utf8.decode(plainishText));

  return (utf8.decode(plainishText));
}

String  encryptString(String plainishText, String encryptionKey) {

  // var key = Uint8List(32); // the 256 bit key

  var plainText = plainishText;
  var random = Random.secure();
  var params = Uint8List(18)
    ..[0] = 4
    ..[1] = 16;
  for (int i = 2; i < 18; i++) {
    params[i] = random.nextInt(256);
  }

  var key = base64.decode(encryptionKey);
  //var params = base64.decode('BBDPsLr2/0m2fX7Ths3eYEre');
  var iv = params.sublist(2);

  var cipher = PaddedBlockCipherImpl(
    PKCS7Padding(),
    CBCBlockCipher(AESFastEngine()),
  )..init(
      true /*encrypt*/,
      PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
        null,
      ),
    );

  var plainBytes = (utf8.encode(plainText));
  var cipherText = cipher.process(plainBytes);
print(" Dhawan "+base64.encode(cipherText) + "~" + base64.encode(params));
  return (base64.encode(cipherText) + "~" + base64.encode(params));
}

String encryptAESCryptoJS(String plainText, String passphrase) {
  try {
    final salt = genRandomWithNonZero(8);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print(encrypted);
    Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes);
    print(encryptedBytesWithSalt);
    print(base64.encode(encryptedBytesWithSalt));
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    throw error;
  }
}

String decryptAESCryptoJS(String encrypted, String passphrase) {
  try {
    Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    Uint8List encryptedBytes =
        encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final salt = encryptedBytesWithSalt.sublist(8, 16);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
        encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    print(decrypted);
    return decrypted;
  } catch (error) {
    throw error;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.length > 0)
      preHash = Uint8List.fromList(currentHash + password + salt);
    else
      preHash = Uint8List.fromList(password + salt);

    currentHash = md5.convert(preHash).bytes;
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  var keyBtyes = concatenatedHashes.sublist(0, 32);
  var ivBtyes = concatenatedHashes.sublist(32, 48);
  return new Tuple2(keyBtyes, ivBtyes);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i = 0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax) + 1;
  }
  return uint8list;
}