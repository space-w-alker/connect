import 'dart:math';
import 'dart:typed_data';
import 'save_key.dart';

Uint8List generateKey(){
  var random = Random.secure();
  var toReturn = <int>[];
  for (var i = 0; i < 16; i++) {
    toReturn.add(random.nextInt(255) + 1);
  }
  return Uint8List.fromList(toReturn);
}

Future<List<String>> keyToWords(Uint8List key) async{
  var intKey = byteArrayToBigInt(key);
  return await bigIntToWord(intKey);
}

Future<Uint8List> wordsToKey(List<String> words) async{
  BigInt intKey = await wordToBigInt(words);
  return bigIntToByteArray(intKey);
}

BigInt byteArrayToBigInt(Uint8List list){
  return BigInt.parse(list.toList().map((e) => e.toRadixString(2).padLeft(8,"0")).join(),radix: 2);
}

Uint8List bigIntToByteArray(BigInt integer){
  var listInt = <int>[];
  String binary = integer.toRadixString(2);
  if(binary.length % 8 != 0){
    binary = binary.padLeft(binary.length + (8-(binary.length % 8)),"0");
  }
  for(int i = 0; i<binary.length~/8; i++){
    listInt.add(int.parse(binary.substring(i*8,i*8+8),radix: 2));
  }
  return Uint8List.fromList(listInt);
}