import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/doctor_or_patient/presentation/ui/widget/doctor_or_patient_widget.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';

class DoctorOrPatientScreen extends StatefulWidget {
  const DoctorOrPatientScreen({super.key});

  @override
  DoctorOrPatientScreenState createState() => DoctorOrPatientScreenState();
}

class DoctorOrPatientScreenState extends State<DoctorOrPatientScreen> {
  final List<Map<String, dynamic>> items = const [
    {'title': 'مركز طبي', 'image': AppIcons.healthCenter,'desc':'مستشفى او معمل تحاليل او مركز اشعه او مجمع عيادات'},
    {'title': 'عيادة', 'image': AppIcons.clinic,},
    {'title': 'مستشفى', 'image': AppIcons.hospital,},
    {'title': 'طبيب', 'image': AppIcons.doctor,},
    {'title': 'مريض', 'image': AppIcons.patient,},
  ];
  int type = 0;
  SurveyBloc surveyBloc = SurveyBloc(surveyUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => surveyBloc,
      child: Scaffold(
          backgroundColor:AppColors.whiteBackground,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(mainAxisSize:MainAxisSize.max,children: [
                Padding(
                  padding: const EdgeInsets.only(top:80),
                  child: PText(title:'طريقة التسجيل',fontColor:AppColors.primaryColor,
                    size:PSize.text28,fontWeight:FontWeight.w700,),
                ),
                PText(title:'من فضلك اختر طريقة التسجيل', size:PSize.text16,
                fontColor:AppColors.grayShade3),
                // OtpInputScreen(),
                const SizedBox(height:90,),
                // Center(
                //   child: Row(mainAxisSize:MainAxisSize.max,spacing:14,
                //       mainAxisAlignment: MainAxisAlignment.center,children: [
                //     DoctorOrPatientWidget(title:items[0]['title'],color:type==1?AppColors.primaryColor200:null,
                //       image:items[0]['image'],onChange:() async {
                //         type = 1;
                //         setState(() {});
                //         await SharedPreferenceService().setString(SharPrefConstants.userType,'patient');
                //         await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,false);
                //       },),
                //     // const SizedBox(width:20,),
                //     DoctorOrPatientWidget(title:items[1]['title'],color:type==2?AppColors.primaryColor200:null,
                //       image:items[1]['image'],onChange:() async {
                //         type = 2;
                //         setState(() {});
                //         await SharedPreferenceService().setString(SharPrefConstants.userType,'doctor');
                //         await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,true);
                //       },),
                //     // const SizedBox(width:20,),
                //     DoctorOrPatientWidget(title:items[2]['title'],color:type==3?AppColors.primaryColor200:null,
                //       image:items[2]['image'],onChange:() async {
                //         type = 3;
                //         setState(() {});
                //         await SharedPreferenceService().setString(SharPrefConstants.userType,'doctor');
                //         await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,true);
                //       },),
                //   ],),
                // ),
                const SizedBox(height:14,),
                // Center(
                //   child: Row(mainAxisSize:MainAxisSize.min,children: [
                //     DoctorOrPatientWidget(title:items[3]['title'],color:type==4?AppColors.primaryColor200:null,
                //       image:items[3]['image'],onChange:() async {
                //         type = 4;
                //         setState(() {});
                //         await SharedPreferenceService().setString(SharPrefConstants.userType,'doctor');
                //         await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,true);
                //       },),
                //     const SizedBox(width:20,),
                //     DoctorOrPatientWidget(title:items[4]['title'],color:type==5?AppColors.primaryColor200:null,
                //       image:items[4]['image'],onChange:() async {
                //         type = 5;
                //         setState(() {});
                //         await SharedPreferenceService().setString(SharPrefConstants.userType,'patient');
                //         await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,false);
                //       },),
                //   ],),
                // ),
                Center(
                  child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    mainAxisSize:MainAxisSize.max,children: [
                      Expanded(
                        child: DoctorOrPatientWidget(title:items[4]['title'],color:type==5?AppColors.primaryColor200:null,
                          image:items[4]['image'],onChange:() async {
                            type = 5;
                            print('type>>'+type.toString());
                            setState(() {});
                            await SharedPreferenceService().setString(SharPrefConstants.userType,'patient');
                            await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,false);
                          },),
                      ),
                    const SizedBox(width:14,),
                      Expanded(
                        child: DoctorOrPatientWidget(title:items[3]['title'],color:type==4?AppColors.primaryColor200:null,
                          image:items[3]['image'],onChange:() async {
                            type = 4;
                            print('type>>'+type.toString());
                            setState(() {});
                            await SharedPreferenceService().setString(SharPrefConstants.userType,'doctor');
                            await SharedPreferenceService().setBool(SharPrefConstants.isDoctor,true);
                          },),
                      ),
                  ],),
                ),
                const SizedBox(height:14,),
                SizedBox(width:MediaQuery.sizeOf(context).width,
                  child:Container(padding:EdgeInsets.only(bottom:10),decoration:BoxDecoration(
                      color:AppColors.whiteColor,
                      border:Border.all(color:Colors.transparent,width:1),
                      borderRadius:const BorderRadius.all(Radius.circular(8))
                  ),child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom:5),
                        child: PImage(source:items[2]['image'],height:70,width:70, fit:BoxFit.none,),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PText(title:items[0]['title'],fontColor:AppColors.blackColor,fontWeight:FontWeight.w600,),
                          const SizedBox(height:5,),
                          PText(title:items[0]['desc'],fontColor:AppColors.grey200,fontWeight:FontWeight.w500,
                          size:PSize.text12,)
                        ],
                      ),
                    ],
                  ),)
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top:14,bottom:10),
                  child: PButton(onPressed:type==0?null:() {
                    // goToSurveyScreen();
                    context.push(AppRouter.login);
                    // context.push(AppRouter.patientSurvey);
                    // context.push(AppRouter.doctorSurvey);
                  },title:'التالي',hasBloc:false,isFitWidth:true,size:PSize.text16,
                      // icon:Icon(Icons.arrow_forward,color:type==0?AppColors.blackColor:AppColors.whiteColor,),
                      icon:PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,),
                      fontWeight:FontWeight.w700,
                      textColor:type==0?AppColors.whiteColor:AppColors.whiteColor,
                      borderColor:type==0?Colors.transparent:AppColors.primaryColor,
                  ),
                ),
              ],),
            ),
          )
      ),
    );
  }


}



