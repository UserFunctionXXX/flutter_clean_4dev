import '../http/http.dart';
import '../../domain/usescases/usescases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});
  Future<void> auth(AuthenticationParams params) async {
    final bodyJson = RemoteAuthenticationParams.fromDomain(params).toJson();
    httpClient.request(url: url, method: 'post', body: bodyJson);
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
