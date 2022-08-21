import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});
  Future<void> auth() async {
    httpClient.request(url: url);
  }
}

abstract class HttpClient {
  void request({required String url}) async {}
}

class HttpClientSpy extends Mock implements HttpClient{
  
}

void main() {
  test('should call HttpClient with correct URl', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    await sut.auth();
    verify(httpClient.request(url: url));
  });
}
