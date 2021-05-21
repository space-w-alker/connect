import 'package:flutter_app/encryption/aes_key_generator.dart';
import 'package:flutter_app/encryption/rsa_pem.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:test/test.dart';

void main() {
  group("RsaKeyHelper", () {
    test("Generate, Encrypt and Decrypt private key", () async {
      final helper = RsaKeyHelper();
      RSAPrivateKey privateKey = generateKeyPair("").privateKey;
      List<String> symmKey = await keyToWords(generateKey());
      String encryptedPrivateKey = await helper.encryptPrivateKey(privateKey, symmKey);

      RSAPrivateKey decryptedPrivateKey = await helper.decryptPrivateKey(encryptedPrivateKey, symmKey);

      expect(privateKey.privateExponent, decryptedPrivateKey.privateExponent);
      expect(privateKey.p, decryptedPrivateKey.p);
      expect(privateKey.q, decryptedPrivateKey.q);
      expect(privateKey.modulus, decryptedPrivateKey.modulus);
    });
  });
}
