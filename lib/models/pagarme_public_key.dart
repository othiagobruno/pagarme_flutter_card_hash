/// This class holds key information needed to
/// encrypt the query string generated using the
/// card data.

import 'package:pagarme_flutter_card_hash/utils/json_utils.dart';

class PagarMePublicKey {
  String id;
  String dateCreated;
  String ip;
  String publicKey;

  PagarMePublicKey({
    required this.id,
    required this.dateCreated,
    required this.ip,
    required this.publicKey,
  });

  static fromJson(Map<String, dynamic> json) {
    return PagarMePublicKey(
      id: JsonUtils.valueOrThis('', 'id', json).toString(),
      dateCreated: JsonUtils.valueOrThis('', 'date_created', json).toString(),
      ip: JsonUtils.valueOrThis('', 'ip', json).toString(),
      publicKey: JsonUtils.valueOrThis('', 'public_key', json).toString(),
    );
  }
}
