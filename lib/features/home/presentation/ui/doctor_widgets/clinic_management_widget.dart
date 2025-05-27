import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class ClinicManagementCard extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final VoidCallback onTap;

  const ClinicManagementCard({
    super.key,
    required this.list,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PText(title: 'manage_services'.tr()),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 5),
            child: PText(title: 'services_type'.tr(), fontColor: AppColors.grey200, size: PSize.text14),
          ),
          // Uncomment and complete if needed
          // ListView.builder(...),
        ]),
      ),
    );
  }
}
