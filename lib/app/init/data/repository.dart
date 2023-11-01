import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:progressprodis/app/init/domain/models/email_exist_model.dart';
import 'package:progressprodis/app/init/domain/models/sign_in_model.dart';
import 'package:progressprodis/app/init/domain/models/sign_up_model.dart';
import 'package:progressprodis/global/user/user_data.dart';

class AuthRepository {
  AuthRepository({required this.supabase});

  final GetStorage _storage = GetStorage();
  final SupabaseClient supabase;

  Future<bool> isLookOnboarding() async {
    return _storage.read("onboarding") ?? false;
  }

  Future<bool> isSignedIn() async {
    final currentUser = supabase.auth.currentUser;
    return currentUser != null;
  }

  Future<Either<String, EmailExistModel>> thisEmailExist(String email) async {
    try {
      final client = await supabase
          .from(
            "client",
          )
          .select()
          .eq("email", email);

      final dis = await supabase
          .from(
            'distributor',
          )
          .select()
          .eq('email', email);

      final emailExist = EmailExistModel(
        isDistributor: dis.isNotEmpty,
        isCliente: client.isNotEmpty,
        email: email,
      );

      return Right(emailExist);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 11.0,
      );
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> validateAccess(
    String email,
    String password,
  ) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(response.user!.id);
    } on AuthException catch (e, stack) {
      return Left(e.message);
    }
  }

  Future<Either<String, String>> loginWhitPassword(
      SignUpModel signUpReq) async {
    try {
      final response = signUpReq.isNewDis
          ? await supabase.auth.signInWithPassword(
              email: signUpReq.email,
              password: signUpReq.password,
            )
          : await supabase.auth.signUp(
              email: signUpReq.email,
              password: signUpReq.password,
              data: signUpReq.toJson(),
            );

      if (response.user?.role == "authenticated") {
        final user = response.user!;
        List<dynamic> isRegister = await supabase
            .from(
              "distributor",
            )
            .select("*")
            .eq("id", user.id);

        final country = signUpReq.country.length > 20
            ? {"id": signUpReq.country}
            : await supabase
                .from("country")
                .select("*")
                .eq("name", signUpReq.country)
                .single()
                .catchError(
                (error) {
                  return const Left("_ No Country");
                },
              );

        if (isRegister.isNotEmpty) {
          await supabase.from("distributor").update({
            "id": user.id,
            "update_at": DateTime.timestamp().toIso8601String(),
            "hid": signUpReq.profesionID,
            "name": signUpReq.firstName,
            "lastname": signUpReq.lastName,
            "email": signUpReq.email,
            "profession": signUpReq.profesionType,
            "status": signUpReq.status,
            "country": country["id"],
            "profile_img":
                "https://hisgouqcvwdolwkcvgrc.supabase.co/storage/v1/object/public/email/profile_male",
            "enable": true,
          }).match({
            "id": user.id,
          });
        } else {
          await supabase.from("distributor").insert({
            "id": user.id,
            "update_at": DateTime.timestamp().toIso8601String(),
            "hid": signUpReq.profesionID,
            "name": signUpReq.firstName,
            "lastname": signUpReq.lastName,
            "email": signUpReq.email,
            "profession": signUpReq.profesionType,
            "status": signUpReq.status,
            "country": country["id"],
            "profile_img":
                "https://hisgouqcvwdolwkcvgrc.supabase.co/storage/v1/object/public/email/profile_male",
            "enable": true
          });
        }

        if (signUpReq.sponsor.isNotEmpty) {
          final List<dynamic> sponsor = await supabase
              .from("distributor")
              .select("id")
              .eq("hid", signUpReq.sponsor);

          await supabase.from("sponsor").insert({
            "sponsor": sponsor.isEmpty
                ? "10910086-c83f-42f5-a889-f0c400f5e8f5"
                : sponsor.first["id"],
            "distribuidor": user.id,
          });
        }

        UserData.saveFromLogin(SignInModel(
          name: signUpReq.firstName,
          lastName: signUpReq.lastName,
          country: country["id"],
          email: signUpReq.email,
          professionID: signUpReq.profesionID,
          professionType: signUpReq.profesionType,
          sponsor: signUpReq.sponsor,
          status: signUpReq.status,
        ));
        return const Right("OK");
      } else {
        return const Left("Retry");
      }
    } catch (e) {
      print(":AuthRepository:: getUserbyId : $e");
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 11.0,
      );
      return Left(e.toString());
    }
  }

  Future<Either<String, SignInModel>> getUserbyId(bool isNewDis) async {
    try {
      final uuid = supabase.auth.currentUser?.id ?? "";
      if (isNewDis) {
        final response = await supabase
            .from(
              "client",
            )
            .select()
            .eq("id", uuid)
            .single();
        if (response != null) {
          final user = SignInModel.fromClienteMap(response);
          return Right(user);
        }
      } else {
        final response = await supabase
            .from(
              "distributor",
            )
            .select()
            .eq("id", uuid)
            .single();
        if (response != null) {
          final user = SignInModel.fromDisMap(response);
          return Right(user);
        }
      }
      return const Left("Not Found");
    } on AuthException catch (e) {
      print(":AuthRepository:: loginWhitPassword : $e");
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 11.0,
      );
      return Left(e.message);
    }
  }

  logoutSession() async {
    await supabase.auth.signOut().then(
          (value) => Modular.to.pushNamedAndRemoveUntil(
            "/Home",
            ModalRoute.withName('/'),
          ),
        );
  }
}
