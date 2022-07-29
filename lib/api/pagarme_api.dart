/// This class sends an HTTP request to Pagar.me's API endpoint that is
/// responsible for generating the RSA key that is used to encrypt the
/// card data to be sent to your backend (and Pagar.me's API)

// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:pagarme_flutter_card_hash/constants/pagarme_constants.dart';
import 'package:pagarme_flutter_card_hash/exceptions/response_exception.dart';
import 'package:pagarme_flutter_card_hash/models/pagarme_public_key.dart';
import 'package:pagarme_flutter_card_hash/utils/http_tunnel.dart';

class PagarMeApi<T> {
  final HttpTunnel httpTunnel = new HttpTunnel();
  final _baseUrl = PagarMeConstants.cardHashUrl;
  String pagarMeApiKey;

  PagarMeApi({required this.pagarMeApiKey});

  Future<PagarMePublicKey> generateEncryptionKeyAndId() async {
    Response response =
        await httpTunnel.get('$_baseUrl?api_key=$pagarMeApiKey');

    if ((response == null) || (response.statusCode != 200)) {
      throw new ResponseException(
          cause:
              "Pagar.me's API didn't respond as expected or there's no internet connection.");
    }

    PagarMePublicKey pagarMePublicKey =
        PagarMePublicKey.fromJson(response.data);

    return pagarMePublicKey;
  }
}
