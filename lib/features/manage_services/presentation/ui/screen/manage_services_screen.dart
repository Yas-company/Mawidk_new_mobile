import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/manage_services/presentation/ui/widgets/add_clinic_bottom_sheet.dart';
import 'package:mawidak/features/manage_services/presentation/ui/widgets/manage_service_card.dart';

class ManageServicesScreen extends StatefulWidget {
  const ManageServicesScreen({super.key});

  @override
  State<ManageServicesScreen> createState() => _ManageServicesScreenState();
}

class _ManageServicesScreenState extends State<ManageServicesScreen> {
  final List<Map<String, dynamic>> services = [
    {
      'title': 'in_clinic'.tr(),
      'description': 'in_clinic_desc'.tr(),
      'icon': AppSvgIcons.icFollow,
      'active': true,
    },
    {
      'title': 'online'.tr(),
      'description': 'providing_medical_consultations'.tr(),
      'icon': AppSvgIcons.icBookOnline,
      'active': true,
    },
    {
      'title': 'free_consultations'.tr(),
      'description': 'apply_free_consultations'.tr(),
      'icon': AppSvgIcons.icFollow,
      'active': false,
    },
    {
      'title': 'home_visit'.tr(),
      'description': 'home_visit_desc'.tr(),
      'icon': AppSvgIcons.icHomeVisit,
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context, removeTop: true,
      child: Scaffold(
        backgroundColor:AppColors.whiteBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(top:24),
            child: appBar(context: context,backBtn: true,text:'manage_services'.tr(),isCenter:true),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:20,),
              PText(title:'apply_services'.tr(),size:PSize.text18,),
              const SizedBox(height:4,),
              PText(title:'choose_service'.tr(),size:PSize.text14,fontWeight:FontWeight.w500,
              fontColor: AppColors.grey200,),
              Expanded(
                child: ListView.builder(
                  padding:EdgeInsets.only(top:14),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return InkWell(onTap:() {
                      showReviewAddClinicBottomSheet(context);
                    },child: ManageServiceCard(
                        title: service['title'],
                        description: service['description'],
                        icon: service['icon'],
                        isActive: service['active'],
                        onChanged: (value) {
                          setState(() {
                            services[index]['active'] = value;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child:PButton(isFitWidth:true,
                  onPressed:() {},
                  title: 'confirm'.tr(),
                  hasBloc: false,
                )
              ),
              const SizedBox(height:20,),
            ],
          ),
        ),
      ),
    );
  }
}
