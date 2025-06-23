import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/patient_evaluation/presentation/bloc/patient_evaluation_bloc.dart';
import 'package:mawidak/features/patient_evaluation/presentation/bloc/patient_evaluation_event.dart';


class PatientEvaluationScreen extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String userName;
  final String specialization;

  const PatientEvaluationScreen({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.specialization,
  });

  @override
  State<PatientEvaluationScreen> createState() => PatientEvaluationScreenState();
}

class PatientEvaluationScreenState extends State<PatientEvaluationScreen> {
  PatientEvaluationBloc patientEvaluationBloc = PatientEvaluationBloc(patientEvaluationUseCase:getIt());
  @override
  Widget build(BuildContext context) {

    patientEvaluationBloc.model.id = widget.id;
    return BlocProvider(create: (context) => patientEvaluationBloc,
      child: MediaQuery.removePadding(
        context: context, removeTop: true,
        child: Scaffold(resizeToAvoidBottomInset: false,
            backgroundColor:AppColors.whiteBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.only(top:24),
                child: appBar(context: context,backBtn: true,text:'evaluation'.tr(),isCenter:true),
              ),
            ),
            body:SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top:14,bottom:24),
                  child: doctorHeader(),
                ),
                PText(title: 'how_evaluate'.tr(),fontWeight:FontWeight.w700,),
                Padding(
                  padding: const EdgeInsets.only(bottom:10,top:16,),
                  child: Divider(color:AppColors.grey100,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:0),
                  child: PText(title: 'public_evaluate'.tr(),fontColor:AppColors.grey200,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,bottom:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      int starValue = index + 1;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            patientEvaluationBloc.selectedEvaluation = starValue;
                            patientEvaluationBloc.model.rate = patientEvaluationBloc.selectedEvaluation;
                          });
                          patientEvaluationBloc.add(ApplyValidationEvent());
                        },
                        child: Icon(
                          Icons.star,
                          size: 36,
                          color: (patientEvaluationBloc.selectedEvaluation??0) >= starValue
                              ? Colors.orange
                              : AppColors.grey200,
                        ),
                      );
                    }),
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.only(bottom:4),
                  child: Divider(color:AppColors.grey100,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,right:20,top:14),
                  child: PTextField(hintText:'add_your_comment'.tr(),labelAbove:'el_comments'.tr(),feedback:(value) {
                    patientEvaluationBloc.model.comment = value;
                    patientEvaluationBloc.add(ApplyValidationEvent());
                  },maxLines: 3,),
                ),
                // Spacer(),
              const SizedBox(height:400,),
              ],),
            ),
        floatingActionButton:SizedBox(height:100,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: PButton<PatientEvaluationBloc,BaseState>(onPressed:() {
              patientEvaluationBloc.add(ApplyPatientEvaluationEvent(model:patientEvaluationBloc.model));
            },title:'add'.tr(),isFitWidth:true, isButtonAlwaysExist: false,
              isFirstButton: true,hasBloc: true,),
          ),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  Widget doctorHeader(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.imageUrl.isEmpty?CircleAvatar(radius:40,
          backgroundColor: AppColors.whiteColor,
          child:Icon(Icons.person),):
        CircleAvatar(
          radius: 40,backgroundColor:Colors.transparent,
          backgroundImage: NetworkImage(widget.imageUrl,),
        ),
        PText(title: widget.userName),
        PText(title: widget.specialization,size:PSize.text14,fontColor:AppColors.grey200),
      ],
    );
  }
}
