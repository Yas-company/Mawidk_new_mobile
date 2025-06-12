import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

void cancelAppointmentBottomSheet(final VoidCallback onTap) {
  showModalBottomSheet(
    context: navigatorKey.currentState!.context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PText(title:'cancel_appointment'.tr(), size: PSize.text18, fontWeight: FontWeight.w700),
              const SizedBox(height: 10),
              PText(title:'question_cancel_appointment'.tr(), size: PSize.text14, fontColor: AppColors.grey200),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: PButton(
                      onPressed: () => Navigator.pop(context),
                      title: 'back'.tr(),
                      fillColor: AppColors.secondary,
                      hasBloc: false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PButton(
                      onPressed:() {
                        Navigator.pop(context);
                        onTap();
                      },fillColor:AppColors.danger,
                      title: 'cancel_appointment'.tr(),
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