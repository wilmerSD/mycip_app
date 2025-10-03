import 'package:cip_payment_app/app/domain/entities/token.dart';
import 'package:cip_payment_app/app/infrastructure/models/culqi/culqi_token_response.dart';

class TokenMapper {
  static Token? tokenResponseToEntity(CulqiTokenResponse response) {
    if (response.isSuccess) {
      final success = response.success!;
      return Token(
        id: success.id,
        email: success.email,
        creationDate: success.creationDate,
        // otros campos que tengas
      );
    }

    if (response.isError) {
      final error = response.error!;
      // Puedes manejarlo de dos formas:
      // 1. Devolver null
      // 2. Lanzar excepción con el mensaje de error
      throw Exception(
        "Culqi error: ${error.userMessage ?? error.merchantMessage}",
      );
    }

    return null; // fallback
  }
}
