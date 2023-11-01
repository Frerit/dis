import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/home/presenter/page/home_page.dart';
import 'package:progressprodis/app/init/presenter/bloc/auth_bloc.dart';
import 'package:progressprodis/global/user/user_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/progresspro-dis.appspot.com/o/asests%2F9375603_avatars_accounts_man_male_people_icon%20(1).png?alt=media&token=cb2c13b2-f88e-485b-ad56-36779c2b1d9f",
                      scale: 4,
                    ),
                    radius: 70,
                  ),
                ),
              ),
              Text(
                "${UserData.name} ${UserData.lastName}",
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  side: const BorderSide(
                    color: AppColors.success,
                    width: 2,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Ver Perfil",
                    style: TextStyle(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ),
              const TitleComponent(title: "Code"),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                  color: AppColors.silver.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onLongPress: () {
                        fToast.showToast(
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.quickSilver.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(25.0),
                                color: AppColors.primaryDarkColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: const Text(
                                "Codigo copiado!",
                                style: TextStyle(fontSize: 15),
                              )),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 2),
                        );
                      },
                      child: Text(UserData.professionId),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.open_in_new_outlined,
                        color: AppColors.quickSilver,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              const TitleComponent(title: "Sponsor"),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.91,
                child: FloatingActionButton.extended(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: const Text(' Cerrar session '),
                  backgroundColor: AppColors.error,
                  icon: const Icon(
                    Icons.logout_outlined,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Modular.get<AuthBloc>().add(const LogoutEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleComponent extends StatelessWidget {
  const TitleComponent({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 30, bottom: 5),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.silver,
            ),
          ),
        ),
      ],
    );
  }
}
