import 'package:get_storage/get_storage.dart';
import 'package:progressprodis/app/init/domain/models/sign_in_model.dart';

enum KeyUser { userName, orange, yellow, green, blue, indigo, violet }

class UserData {
  static final GetStorage _box = GetStorage();

  UserData._();

  static String name = _box.read("user_name");
  static String lastName = _box.read("user_lastName") ?? "";
  static String professionId = _box.read("user_profession_id") ?? "";

  static String profile = _box.read("user_profile") ??
      "https://hisgouqcvwdolwkcvgrc.supabase.co/storage/v1/object/public/email/profile_male";

  static setName(String value) {
    _box.write("user_name", value);
  }

  static String hash = _box.read("user_hash");

  static void setHash(String hash) {
    _box.write("user_hash", hash);
  }

  static void saveFromLogin(SignInModel user) {
    _box.write("user_name", user.name);
    _box.write("user_lastName", user.lastName);
    _box.write("user_email", user.email);
    _box.write("user_country", user.country);
    _box.write("user_profession", user.professionType);
    _box.write("user_profession_id", user.professionID);
    _box.write("user_status", user.status);
    _box.write("user_sponsor", user.sponsor);
    _box.write("user_isNewDis", user.isNewDis);
  }
}
