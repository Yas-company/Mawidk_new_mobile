import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/privacy_policy/data/model/privacy_policy_response_model.dart';
import 'package:mawidak/features/privacy_policy/presentation/bloc/privacy_policy_bloc.dart';
import 'package:mawidak/features/privacy_policy/presentation/bloc/privacy_policy_event.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  final int id;
  const PrivacyPolicyScreen({super.key,required this.id,});

  @override
  State<PrivacyPolicyScreen> createState() => PrivacyPolicyScreenState();
}
class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PrivacyPolicyBloc privacyPolicyBloc = PrivacyPolicyBloc(policyUseCase:getIt());
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,removeTop: true,
      child: BlocProvider(create:(context) => privacyPolicyBloc,
        child: Scaffold(
            backgroundColor:AppColors.whiteBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.only(top:24),
                child: appBar(context: context,backBtn: true,
                    text:widget.id==1?'privacy'.tr():'usage_conditions'.tr(),isCenter:true),
              ),
            ),
            body:PBlocBuilder(bloc: privacyPolicyBloc,
              loadingWidget: Center(child: CustomLoader(size: 35)),
              init:() {
                privacyPolicyBloc.add(ApplyPrivacyPolicyEvent(id: widget.id));
              },
              loadedWidget:(state) {
                PrivacyPolicyData item
                = ((state as LoadedState).data).model?.model?? PrivacyPolicyData();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40,vertical:14),
                  child: SingleChildScrollView(
                    child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            PText(title:item.content??''),
                          ],
                        ),
                      ],
                    )
                  ),
                );
              },)
        ),
      ),
    );
  }

}
