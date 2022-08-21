import 'package:flutter_clean_4dev/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth({
    required String email,
    required String password,
  });
}
