import 'package:flutter_clean_4dev/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth({
    required AuthenticationParams params,
  });
}


class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({required this.email, required this.secret});

  Map toMap(){
    return {'email': email, 'password': secret};

  }
  
  
}