import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/button/p_floating_action_button.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/services/responsive/responsive_helper.dart';

class MainScaffold extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final PreferredSizeWidget? appBar;
  const MainScaffold({
    super.key,
    this.mobile,
    this.tablet,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: getBody(context),
      floatingActionButton: PFloatingActionButton(
        child: SizedBox(
            width: 60,
            height: 60,
            child: ButtonWidget(
              elevation: 4,fillColor:AppColors.primaryColor,
              padding: const EdgeInsets.all(0),
              borderRadius: 40,
              onPressed: () {
                // showDialog(
                //   context: context,barrierDismissible:false,
                //   barrierColor: Colors.black12,
                //   builder: (BuildContext context) {
                //     return PDialog(
                //       title: "Custom Dialog",
                //       description: "This is a reusable custom dialog.",
                //       icon: Icon(Icons.check_circle, size: 50, color: Colors.green),
                //       onConfirm: () {
                //         print("Confirmed!");
                //         Navigator.of(context).pop();
                //       },
                //       onCancel: () {
                //         print("Canceled!");
                //         Navigator.of(context).pop();
                //       },
                //       confirmText: "Yes",
                //       cancelText: "No",
                //       customContent: Column(
                //         children: [
                //           Text("Additional custom content here."),
                //           SizedBox(height: 16),
                //           Text("You can even add more widgets."),
                //         ],
                //       ),
                //     );
                //   },
                // );
                // navigatorKey.currentState!.context
                //     .pushNamed(AppRouter.inspector);
                // navigatorKey.currentState!.context.pushWidget(InspectorScreen(inspectorList: inspectList,),'');
                // nirikshak.showNirikshak(navigatorKey.currentState!.context);
              },
              title: 'Inspect',
              size: PSize.text12,
            )),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    if (ResponsiveHelper(context).isMobile()) {
      return mobile ?? const SizedBox.shrink();
    } else {
      return tablet ?? const SizedBox.shrink();
    }
  }
}
