import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/client/dio_client.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';


void logoutBottomSheet(BuildContext context,final VoidCallback onTap) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Directionality(
        textDirection: isArabic()?TextDirection.ltr:TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PText(title: 'logout'.tr(), size: PSize.text18, fontWeight: FontWeight.w700),
              const SizedBox(height: 10),
              PText(title: 'logout_question'.tr(), size: PSize.text14, fontColor: AppColors.grey200),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: PButton(
                      onPressed: () => Navigator.pop(context),
                      title: 'cancel'.tr(),
                      fillColor: AppColors.secondary,
                      hasBloc: false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PButton(
                      onPressed: onTap,
                      title:'logout'.tr(),
                      hasBloc: false,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}


void logoutBottomSheet2(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "DeleteAccount",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5), // Optional dim background
    transitionDuration: const Duration(milliseconds:300),
    pageBuilder: (mContext, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: SafeArea( // Ensures spacing above system nav
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PText(title:'تسجيل الخروج', size:PSize.text18, fontWeight:FontWeight.w700),
                  const SizedBox(height: 10),
                  PText(title:'هل انت متأكد من تسجيل الخروج ؟', size:PSize.text14, fontColor:AppColors.grey200),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: PButton(
                          onPressed:() {
                            Navigator.pop(mContext);
                          },
                          title: 'إلغاء',
                          fillColor: AppColors.secondary,
                          hasBloc: false,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: PButton(
                          onPressed: () {
                            Navigator.pop(mContext);
                            DioClient().deleteToken();
                          },
                          title: 'تسجيل الخروج',
                          hasBloc: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(anim),
        child: child,
      );
    },
  );
}