import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'aes_key_generator.dart';
import "package:pointycastle/export.dart";

Uint8List getIV() {
  var s = "abcdefghijklmnop";
  return Uint8List.fromList(s.codeUnits);
}

Uint8List _aesCbcEncrypt(Uint8List key, Uint8List iv, Uint8List paddedPlaintext) {
  // Create a CBC block cipher with AES, and initialize with key and IV

  final cbc = CBCBlockCipher(AESFastEngine())..init(true, ParametersWithIV(KeyParameter(key), iv)); // true=encrypt

  // Encrypt the plaintext block-by-block

  final cipherText = Uint8List(paddedPlaintext.length); // allocate space

  var offset = 0;
  while (offset < paddedPlaintext.length) {
    offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
  }
  assert(offset == paddedPlaintext.length);

  return cipherText;
}

Uint8List _aesCbcDecrypt(Uint8List key, Uint8List iv, Uint8List cipherText) {
  // Create a CBC block cipher with AES, and initialize with key and IV

  final cbc = CBCBlockCipher(AESFastEngine())..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

  // Decrypt the cipherText block-by-block

  final paddedPlainText = Uint8List(cipherText.length); // allocate space

  var offset = 0;
  while (offset < cipherText.length) {
    offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
  }
  assert(offset == cipherText.length);
  return paddedPlainText;
}

Future<Uint8List> symmetricEncrypt(List<String> key, String plainText) async {
  Uint8List intKey = await wordsToKey(key);
  return _aesCbcEncrypt(intKey, getIV(), padText(plainText));
}

Future<Uint8List> symmetricDecrypt(List<String> key, String cipherText) async {
  Uint8List intKey = await wordsToKey(key);
  List<int> toReturn = _aesCbcDecrypt(intKey, getIV(), Uint8List.fromList(cipherText.codeUnits)).toList();
  while (toReturn.last == "#".codeUnitAt(0)) {
    toReturn.removeAt(toReturn.length - 1);
  }
  return Uint8List.fromList(toReturn);
}

Uint8List padText(String text) {
  List list = text.codeUnits.toList();
  if (list.length % 16 != 0) {
    int to = 16 - (list.length % 16);
    for (int i = 0; i < to; i++) {
      list.add("#".codeUnitAt(0));
    }
  }
  return Uint8List.fromList(list);
}
