
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_clean_4dev/data/http/http.dart';
import 'package:flutter_clean_4dev/data/usecases/usecases.dart';
import 'package:flutter_clean_4dev/domain/usescases/usescases.dart';
import 'package:flutter_clean_4dev/domain/helpers/helpers.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
  });

  test('should call HttpClient with correct values', () async {
    await sut.auth(params);
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

  test('should throw UnexpectedErro if HttpClient returns 400', () async {
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('url'),
            body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);
 
    final either = await sut.auth(params);
    if (either.isLeft){
      expect(either.left, throwsA(DomainError.unexpected));
    }
    
  });
}
