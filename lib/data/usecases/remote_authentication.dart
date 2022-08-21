import 'package:either_dart/either.dart';

import '../http/http.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usescases/usescases.dart';


class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  
  RemoteAuthentication({required this.httpClient, required this.url});
  Future<Either<Exception,bool>> auth(AuthenticationParams params) async {
    final bodyJson = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      httpClient.request(url: url, method: 'post', body: bodyJson);
      return const Right(true);
    } on HttpError catch(error) {
      final erro = error==HttpError.unauthorized ? DomainError.invalidCrendentials : DomainError.unexpected;
      return Left(throw erro);
    }
    
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String secret;

  RemoteAuthenticationParams({required this.email, required this.secret});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, secret: params.secret);

  Map toJson() => {'email': email, 'password': secret};
}
