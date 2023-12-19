import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/app/activity/_children/general/detail/presenter/page/gen_detail_page.dart';

class ActivityModule extends Module {
  static const String base = "/general_detail";

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const GeneralDetailPage(),
    );
  }
}
