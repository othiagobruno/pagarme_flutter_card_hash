/// This class is responsible for both building the query string containing
/// the card info as well as encrypting it with the RSA details contained
/// within the pagarMePublicKey attribute.

import 'package:encrypt/encrypt.dart';
import 'package:pagarme_flutter_card_hash/models/pagarme_card.dart';
import 'package:pagarme_flutter_card_hash/models/pagarme_public_key.dart';
import 'package:pointycastle/asymmetric/api.dart';

class PagarMeEncrypt {
  PagarMePublicKey pagarMePublicKey;
  PagarMeCard pagarMeCard;

  PagarMeEncrypt({required this.pagarMePublicKey, required this.pagarMeCard});

  String generateCardHash() {
    String cardQueryString = _generateCardQueryString();
    String cardHash =
        "${this.pagarMePublicKey.id}_${_encryptCardQueryString(cardQueryString)}";

    return cardHash;
  }

  String _generateCardQueryString() {
    String cardHashAsString = "card_number=${this.pagarMeCard.getCardNumber()}" +
        "&card_holder_name=${this.pagarMeCard.getCardHolderName()}" +
        "&card_expiration_date=${this.pagarMeCard.getCardExpirationDate()}" +
        "&card_cvv=${this.pagarMeCard.getCardCvv()}";
    return Uri.encodeFull(cardHashAsString);
  }

  String _encryptCardQueryString(String cardQueryString) {
    final parser = RSAKeyParser();
    final RSAAsymmetricKey publicKey = parser.parse(pagarMePublicKey.publicKey);
    final encrypter = Encrypter(
      RSA(
        publicKey: RSAPublicKey(publicKey.modulus!, publicKey.exponent!),
      ),
    );
    final encrypted = encrypter.encrypt(cardQueryString);

    return encrypted.base64;
  }
}
