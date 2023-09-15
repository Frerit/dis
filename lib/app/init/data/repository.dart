import 'package:get_storage/get_storage.dart';

class AuthRepository {
  final GetStorage _storage = GetStorage();

  Future<bool> isLookOnboarding() async {
    return _storage.read("onboarding") ?? false;
  }
}
