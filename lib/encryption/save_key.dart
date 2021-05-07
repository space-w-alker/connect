import 'dart:async' show Future, FutureOr;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

FutureOr<Map<dynamic, dynamic>> getBinToWord() async {
  String text = await rootBundle.loadString("assets/bin_to_word.json");
  return jsonDecode(text) as Map<dynamic, dynamic>;
}

FutureOr<Map<dynamic, dynamic>> getWordToBin() async {
  String text = await rootBundle.loadString("assets/word_to_bin.json");
  return jsonDecode(text) as Map<dynamic, dynamic>;
}

Future<List<String>> bigIntToWord(BigInt integer) async {
  Map<dynamic, dynamic> what = await getBinToWord();
  String binary = integer.toRadixString(2);
  if (binary.length % 18 != 0) {
    binary = binary.padLeft(binary.length + (18 - binary.length % 18), "0");
  }
  List<String> b = <String>[];
  for (int i = 0; i < binary.length ~/ 18; i++) {
    b.add(what[binary.substring(i * 18, i * 18 + 18)]);
  }
  return b;
}

Future<BigInt> wordToBigInt(List<String> wordList) async {
  Map<dynamic, dynamic> what = await getWordToBin();
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < wordList.length; i++) {
    buffer.write(what[wordList[i]]);
  }
  return BigInt.parse(buffer.toString(), radix: 2);
}
