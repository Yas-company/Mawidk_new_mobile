import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/bloc/upload_bloc.dart';
import 'package:mawidak/core/bloc/upload_event.dart';
import 'package:mawidak/core/bloc/upload_state.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
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
                  const SizedBox(height:24,),
                  MoreItemWidget(
                    title: 'edit_personal_info'.tr(),
                    rightIcon:AppSvgIcons.user,
                    leftIcon:AppSvgIcons.icArrow,
                    onTap: () {
                      context.push(AppRouter.editPersonalInfo,
                          extra:SharedPreferenceService().getString(SharPrefConstants.phone));
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