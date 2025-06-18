import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/bloc/upload_bloc.dart';
import 'package:mawidak/core/bloc/upload_event.dart';
import 'package:mawidak/core/bloc/upload_state.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/file_service_picker/file_service_picker.dart';
import 'package:mawidak/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/more/presentation/bloc/logout_bloc.dart';
import 'package:mawidak/features/more/presentation/bloc/logout_event.dart';
import 'package:mawidak/features/more/presentation/ui/widgets/delete_account_bottom_sheet.dart';
import 'package:mawidak/features/more/presentation/ui/widgets/language_bottom_sheet_widget.dart';
import 'package:mawidak/features/more/presentation/ui/widgets/logout_bottom_sheet.dart';
import 'package:mawidak/features/more/presentation/ui/widgets/more_item_widget.dart';
import 'package:mawidak/features/more/presentation/ui/widgets/profile_header.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key,});
  @override
  MoreScreenState createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    LogoutBloc logoutBloc = LogoutBloc(logoutUseCase:getIt());
    logoutBloc.imageUrl = SharedPreferenceService().getString(SharPrefConstants.image);
    UploadBloc uploadBloc = UploadBloc();
    File selectedFile;
    return BlocProvider(create: (_) => logoutBloc,
      child: SafeArea(
        child: Scaffold(backgroundColor:AppColors.whiteBackground,
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child:Column(
                children: [
                  const SizedBox(height:35,),

                  BlocProvider(create: (context) => uploadBloc,
                    child: BlocConsumer<UploadBloc,UploadState>(listener:(context, state) {
                      if (state is FilesPicked || state is FileRemoved) {
                        selectedFile = ((state as dynamic).pickedFiles ?? []).first;
                        logoutBloc.add(UpdatePhotoEvent(file:selectedFile));
                      }
                    },builder:(context, state) {
                      return BlocBuilder<LogoutBloc,BaseState>(builder:(context, state) {
                        return ProfileHeader(onTap: () {
                          _showPickerDialog(context);
                        },imageUrl:logoutBloc.imageUrl,
                          userName: SharedPreferenceService().getString(SharPrefConstants.userName),
                          phoneNumber:SharedPreferenceService().getString(SharPrefConstants.phone),
                        );
                      },);
                    },),
                  ),
                   SizedBox(height:isDoctor()?10:24,),
                  if(!isDoctor())InkWell(onTap:() {
                    context.push(AppRouter.completePatientProfile);
                  },child: Container(padding:EdgeInsets.symmetric(horizontal:20,vertical:12),decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primaryColor2200
                    ),child:Row(children: [
                      CirclePercentage(percentage: 0.7,backgroundStrokeWidth: 2.0,
                        progressStrokeWidth: 5.0,),
                      const SizedBox(width:14,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        PText(title:'complete_info'.tr(),size:PSize.text14,),
                        const SizedBox(height:4,),
                        PText(title:'please_complete_info'.tr(),size:PSize.text13,fontColor:AppColors.grey200,)
                      ],),
                      Spacer(),
                      PImage(source:isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,color:AppColors.blackColor,)
                    ],),),
                  ),
                  const SizedBox(height:24,),
                  MoreItemWidget(
                    title: 'edit_personal_info'.tr(),
                    rightIcon:AppSvgIcons.user,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                      context.push(AppRouter.editPersonalInfo,
                          extra:{
                        'phone':SharedPreferenceService().getString(SharPrefConstants.phone),
                        'name':SharedPreferenceService().getString(SharPrefConstants.userName),
                          }).then((value) {
                            setState(() {});
                          },);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(
                    title: 'change_password'.tr(),
                    rightIcon:AppSvgIcons.lock,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () async {
                      String phone = await SecureStorageService().read(key: SharPrefConstants.phone) ?? '';
                      context.push(AppRouter.changePassword,extra:phone);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(
                    padding: EdgeInsets.only(right:4,),
                    title: 'privacy'.tr(),
                    width:19,height:19,
                    rightIcon:AppSvgIcons.icPrivacy,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                      context.push(AppRouter.privacyPolicyScreen,extra: 1);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(
                    padding: EdgeInsets.only(right:4,),
                    width:19,height:19,
                    title: 'usage_conditions'.tr(),
                    rightIcon:AppSvgIcons.icPrivacy,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                      context.push(AppRouter.privacyPolicyScreen,extra: 2);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(padding: EdgeInsets.only(right:4,),
                    title: 'language'.tr(),
                    rightIcon:AppSvgIcons.icLanguage,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                      showLanguageBottomSheet(navigatorKey.currentState?.context??context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(padding: EdgeInsets.only(right:1,),
                    title: 'contact_us'.tr(),
                    width:24,height:24,
                    rightIcon:AppSvgIcons.mail,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                    context.push(AppRouter.contactUsScreen);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(padding: EdgeInsets.only(right:4,),
                    title: 'notifications'.tr(),isNotification:true,
                    rightIcon:AppSvgIcons.icNotificationMore,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                    setState(() {});
                    },
                  ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(padding: EdgeInsets.only(right:4,),
                    title: 'delete_account'.tr(),
                    // rightIconColor:AppColors.grayShade3,
                    leftIcon:AppSvgIcons.icArrow,
                    rightIcon:AppSvgIcons.icDelete,
                    onTap: () {
                      showDeleteAccountBottomSheet(navigatorKey.currentState?.context??context,() {
                        Navigator.pop(navigatorKey.currentState?.context??context);
                        logoutBloc.add(MakeDeleteAccount());
                      },);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:4),
                    child: Divider(color:AppColors.grey100,),
                  ),
                  MoreItemWidget(padding: EdgeInsets.only(right:4,),
                    title: 'logout'.tr(),width:20,
                    height:20,
                    // rightIconColor:AppColors.grayShade3,
                    leftIcon:AppSvgIcons.icArrow,
                    rightIcon:AppSvgIcons.icLogout,
                    onTap: () {
                      logoutBottomSheet(navigatorKey.currentState?.context??context,() {
                        Navigator.pop(navigatorKey.currentState?.context??context);
                        logoutBloc.add(MakeLogoutEvent());
                      },);
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical:4),
                  //   child: Divider(color:AppColors.grey100,),
                  // ),
                  const SizedBox(height: 0),
                ],
              )
          ),),
      ),
    );
  }

  void _showPickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<UploadBloc>(context),
          child: Container(
            height: 140,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                top: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
            child: Wrap(
              children: [
                  ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14),
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.photo_camera_back),
                    title: PText(title: 'اضافة صورة من ملف الصور'.tr()),
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context).add(
                        PickFiles(
                          pickerType:PickerType.singleImageGallery,
                          numberOfImages: 1,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                const Divider(),
                  ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14),
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: PText(title: 'افتح الكاميرا'.tr()),
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context).add(
                        PickFiles(
                          pickerType: PickerType.singleImageCamera,
                          numberOfImages: 1,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

}




// class CirclePercentage extends StatelessWidget {
//   final double percentage; // 0.0 to 1.0

//   const CirclePercentage({super.key, required this.percentage});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       foregroundPainter: CirclePainter(percentage),
//       child: SizedBox(
//         width:37, height: 37,
//         child: Center(
//           child: PText(title: '${(percentage * 100).toInt()}%',
//               size:PSize.text13,fontColor:AppColors.primaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CirclePainter extends CustomPainter {
//   final double percentage;
//
//   CirclePainter(this.percentage);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokeWidth = 4.0;
//     final rect = Offset.zero & size;
//     final center = rect.center;
//     final radius = min(size.width, size.height) / 2 - strokeWidth;
//
//     final backgroundPaint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;
//
//     final progressPaint = Paint()
//       ..color = AppColors.primaryColor
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     // Draw background circle
//     canvas.drawCircle(center, radius, backgroundPaint);
//
//     // Draw progress arc
//     final startAngle = -pi / 2;
//     final sweepAngle = 2 * pi * percentage;
//     canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
//         startAngle, sweepAngle, false, progressPaint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

class CirclePercentage extends StatelessWidget {
   double percentage; // value between 0.0 and 1.0
  final double backgroundStrokeWidth;
  final double progressStrokeWidth;

   CirclePercentage({
    super.key,
     this.percentage=0,
    this.backgroundStrokeWidth = 6.0,
    this.progressStrokeWidth = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    num value = num.parse(SharedPreferenceService().getString(SharPrefConstants.profileCompletionPercentage));
    // mhmdajoor5@gmail.com
    percentage = double.parse(value.toString()) / 100;
    return CustomPaint(
      foregroundPainter: CirclePainter(
        // percentage: percentage,
        percentage: percentage,
        backgroundStrokeWidth: backgroundStrokeWidth,
        progressStrokeWidth: progressStrokeWidth,
      ),
      child:SizedBox(
        width:37, height: 37,
        child: Center(
          child: PText(title: '${(percentage * 100).toInt()}%',
            size:PSize.text13,fontColor:AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double percentage;
  final double backgroundStrokeWidth;
  final double progressStrokeWidth;

  CirclePainter({
    required this.percentage,
    required this.backgroundStrokeWidth,
    required this.progressStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final minStroke = min(backgroundStrokeWidth, progressStrokeWidth);
    final radius = (min(size.width, size.height) - minStroke) / 2;

    final backgroundPaint = Paint()
      ..color = AppColors.whiteBackground
      ..strokeWidth = backgroundStrokeWidth
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = progressStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
