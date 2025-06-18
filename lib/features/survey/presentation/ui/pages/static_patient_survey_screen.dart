import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/bloc/static_survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/pages/static_doctor_survey_screen.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/dynamic_question_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/drop_down_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/steper_indicator.dart';

class StaticPatientSurveyScreen extends StatefulWidget {
  const StaticPatientSurveyScreen({super.key});

  @override
  State<StaticPatientSurveyScreen> createState() => StaticPatientSurveyScreenState();
}

class StaticPatientSurveyScreenState extends State<StaticPatientSurveyScreen> {
  List<ScreenModel> patientStaticSurvey = [
    ScreenModel(
      id: 0,
      title: "معلومات عامة",
      subtitle: "من فضلك قم باستكمال البيانات",
      questions: [
        // Question(
        //   id: 1,
        //   questionText: "النوع",
        //   type: "single_choice_grid",isRequired:true,
        //   options: [Option(id:1,optionText:"ذكر"), Option(id:2,optionText:"انثي")],
        // ),
        Question(id: 2, questionText: "العمر", type: "number",isRequired:true,hint:'ادخل عمرك'),
        Question(id: 3, questionText: "الوزن", type: "number",isRequired:true,hint:'ادخل وزنك'),
        Question(id: 4, questionText: "الطول", type: "number",isRequired:true,hint:'ادخل طولك'),
      ],
    ),
    ScreenModel(
      id: 1,
      title: "كيف تصف حالتك الصحية العامة؟",
      subtitle: "اختر من الاختيارات التالية",
      questions: [
        Question(
          id: 0,
          questionText: "هل لديك تأمين؟",
          type: "text_with_check",isRequired:true,
        ),
        Question(
          id: 1,
          questionText: "",
          type: "radio_button",isRequired:true,
          options: [Option(id:1,optionText:"ممتازة"), Option(id:2,optionText:"جيدة"),
            Option(id:3,optionText:"متوسطة"), Option(id:4,optionText:"ضعيفة"),],
        ),
      ],
    ),
    // ScreenModel(
    //   id: 2,
    //   title: "الامراض المزمنة",
    //   subtitle: "هل تعاني من اي امراض مزمنة ؟",
    //   questions: [
    //     Question(showCheckBoc:true,
    //       id: 1,
    //       questionText: "اختر الامراض المزمنة",
    //       // type: "multi_select",isRequired:true,
    //       type: "drop_down",isRequired:false,
    //       options: allDiseases
    //       // [
    //       //   Option(id:1,optionText:"السكري"), Option(id:2,optionText:"الضغط"),
    //       //   Option(id:3,optionText:"الربو"), Option(id:4,optionText:"امراض القلب"),
    //       //   Option(id:5,optionText:"لا شئ مما سبق"),
    //       //   ],
    //     ),
    //   ],
    // ),
    ScreenModel(
      id: 2,
      title: "معلومات صحية اساسية",
      subtitle: "من فضلك قم باستكمال البيانات",
      questions: [
        Question(isRequired:true,hint:'اسم المرض',
          questionText:"هل تستخدم اي ادوية بشكل يومي ؟",
          id: 0,
          type: "tapped_text_field",
        ),
        Question(isRequired:true,
          questionText:"هل لديك حساسية من ادوية او اطعمة ؟",
          id: 1,hint:'نوع الحساسية',
          type: "tapped_text_field",
        ),
        Question(isRequired:true,hint:'نوع المرض',
          questionText:"هل عانيت من اي نوع من الامراض المعدية في الاشهر الستة الماضية ؟",
          id: 2,
          type: "tapped_text_field",
        ),
      ],
    ),
    ScreenModel(
      id: 3,
      title: "هل تمارس الرياضة بانتظام ؟",
      subtitle: "اختر من الاختيارات التالية",
      questions: [
        Question(isRequired:true,
          id: 1,
          questionText: "",
          type: "radio_button",
          options: [
            Option(id:1,optionText:"يوميا",),
            Option(id:2,optionText:"3 الى 5 مرات اسبوعيا"),
            Option(id:3,optionText:"مرة الى مرتين اسبوعيا"),
            Option(id:4,optionText:"لا امارس")],
        ),
      ],
    ),
    ScreenModel(
      id: 4,
      title: "نمط حياتك",
      subtitle: "من فضلك قم باستكمال البيانات",
      questions: [
        Question(isRequired:true,
          id: 0,
          questionText: "هل تدخن",
          type: "single_choice",
          options: [Option(id:1,optionText:"نعم"),
            Option(id:2,optionText:"لا"),Option(id:1,optionText:"كنت مدخن"),],
        ),
        Question(isRequired:true,
          id: 1,
          questionText: "هل تعاني من  مشاكل في النوم مثل الارق ؟",
          type: "single_choice",
          options: [Option(id:1,optionText:"نعم"), Option(id:2,optionText:"لا")],
        ),
      ],
    ),
    ScreenModel(
      id: 5,
      title: "التاريخ الطبي و العائلي",
      subtitle: "من فضلك قم باستكمال البيانات",
      questions: [
        Question(isRequired:true,hint:'اسم المرض',
          questionText:"هل تعاني من اي امراض مزمنة ؟",
          id: 0,
          type: "tapped_text_field",
        ),
        Question(isRequired:true,hint:'اسم المرض',
          questionText:"هل لديك تاريخ لامراض وراثية في عائلتك ؟",
          id: 1,
          type: "tapped_text_field",
        ),
        Question(isRequired:true,hint:'ادخل المشكلة',
          questionText:"هل عانيت من مشاكل صحية حادة في السنوات الاخيرة ؟",
          id: 2,
          type: "tapped_text_field",
        ),
        Question(isRequired:true,hint:'نوع الفحص',
          questionText:"هل اجريت فحوصات طبيه دورية خلال السنة الماضية ",
          id: 3,
          type: "tapped_text_field",
        ),
      ],
    ),
    // ScreenModel(
    //   id: 6,
    //   title: "تفضيلات عامة",
    //   subtitle: "من فضلك قم باستكمال البيانات",
    //   questions: [
    //     Question(isRequired:true,
    //       id: 0,
    //       questionText: "هل تفضل الاستشارة الطبية عن بعد ام بالحضور الى العيادة ؟",
    //       type: "single_choice",
    //       options: [Option(id:1,optionText:"عن بعد"),
    //         Option(id:2,optionText:"حضوريا"),
    //         Option(id:3,optionText:"لا فرق"),],
    //     ),
    //     Question(isRequired:true,
    //       id: 1,
    //       questionText: "هل تفضل استشارة طبيب من نفس منطقتك ام من اي منطقة اخرى ؟",
    //       type: "single_choice",
    //       options: [Option(id:1,optionText:"نفس المنطقة"),
    //         Option(id:2,optionText:"اي منطقة")],
    //     ),
    //     Question(isRequired:true,
    //       id: 2,
    //       questionText: "هل ترغب في تلقي اشعارات طبية من التطبيق ؟",
    //       type: "single_choice",
    //       options: [Option(id:1,optionText:"نعم"), Option(id:2,optionText:"لا")],
    //     ),
    //     Question(isRequired:true,
    //       id: 3,
    //       questionText: "هل ترغب في متابعه صحية دورية عبر التطبيق ؟",
    //       type: "single_choice",
    //       options: [Option(id:1,optionText:"نعم"), Option(id:2,optionText:"لا")],
    //     ),
    //   ],
    // ),
  ];
  late PageController _controller;
  StaticSurveyBloc surveyBloc = StaticSurveyBloc(surveyUseCase: getIt());
  @override
  void initState() {
    super.initState();
    if(!isDoctor()){staticSurveyBloc = surveyBloc;}
    _controller = PageController();
    surveyBloc.surveyList = patientStaticSurvey;
    surveyBloc.add(ValidateSurveyEvent()); // Validate first page
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      await showDialog(
        context:context,barrierDismissible:false,
        builder:(context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info, color: Colors.orange, size: 60),
                  const SizedBox(height: 16),
                  PText(title: 'يرجى إكمال الاستبيان',),
                  const SizedBox(height: 12),
                  Center(
                    child: PText(title: 'هل انت متاكد من عدم استكمال الاستبيان ؟',
                      fontColor:AppColors.grey200,alignText:TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(height:50,
                    child: Row(mainAxisSize:MainAxisSize.max,children: [
                        Expanded(
                          child: PButton(hasBloc:false,
                            title: 'نعم',isFitWidth:true,
                            onPressed:() async {
                              Navigator.of(context).pop();
                              await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,false);
                              await SharedPreferenceService().setBool(SharPrefConstants.isSKippedSurvey,true);
                              Get.context!.go(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
                            },
                          ),
                        ),const SizedBox(width:14,),
                      Expanded(
                        child: PButton(hasBloc:false,
                          title: 'لا',isFitWidth:true,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
      return false;
    },
      child: Scaffold(backgroundColor:AppColors.whiteBackground,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocProvider(
            create: (context) => surveyBloc,
            child: SizedBox(height:double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 250, width: double.infinity,
                    decoration: BoxDecoration(color:Color(0xFFF1F8FF)),
                    child: Stack(
                      children: [
                        Positioned(
                          top:50, right: 2,
                          child: CustomImageView(
                            imagePath: AppIcons.imgVector,color:Colors.white.withOpacity(0.6),
                            height: 174, width: 124,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(top:60,left:16,right:16,
                    child: BlocBuilder<StaticSurveyBloc, BaseState>(
                      bloc: surveyBloc,
                      builder: (context, state) {
                        return StepIndicator(
                          currentStep: surveyBloc.index,
                          allSteps: surveyBloc.surveyList.length,
                        );
                      },
                    ),
                  ),
                  Positioned(top: 120, right: 0, left: 0, bottom: 0,
                    child: Column(children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _controller,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: surveyBloc.surveyList.length,
                            itemBuilder: (context, index) {
                              final page = surveyBloc.surveyList[index];
                              return index==0?
                              Stack(children: [
                                Positioned(
                                    left:-142,
                                    top:165,child: PImage(source:AppIcons.human,fit:BoxFit.fitWidth,
                                  height:MediaQuery.sizeOf(context).height*0.50,)),
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 400,
                                        padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 40, bottom: 30,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            PText(title: page.title??'', size: PSize.text20,),
                                            PText(title: page.subtitle??'', size: PSize.text14,
                                              fontColor: AppColors.grey200, fontWeight: FontWeight.w400,),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                      if(page.questions!=Icons.not_listed_location&&
                                          page.questions!.isNotEmpty)...page.questions!.map((q) => Padding(
                                        padding:EdgeInsets.only(left:
                                        index==0?MediaQuery.sizeOf(context).width*0.45:20,
                                            right:20,top:10),
                                        child:buildQuestionWidget(q, (callback) {
                                          setState(callback);
                                          surveyBloc.add(ValidateSurveyEvent());
                                        }),
                                      )
                                      ),
                                    ],
                                  ),
                                )
                              ],)
                                  :Padding(
                                padding: const EdgeInsets.only(bottom:10),
                                child: SingleChildScrollView(
                                  child: Column(mainAxisSize:MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 400,
                                        padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 40, bottom: 30,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            PText(title: page.title??'', size: PSize.text20,),
                                            PText(title: page.subtitle??'', size: PSize.text14,
                                              fontColor: AppColors.grey200, fontWeight: FontWeight.w400,),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                      if(page.questions!=null&& page.questions!.isNotEmpty)
                                        ...page.questions!.map((q) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:20),
                                          child:buildQuestionWidget(q, (callback) {
                                            setState(callback);
                                            surveyBloc.add(ValidateSurveyEvent());
                                          }),
                                        )
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:14,right:14,bottom:10),
                          // padding: const EdgeInsets.symmetric(horizontal:14,vertical:0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<StaticSurveyBloc, BaseState>(
                                bloc:surveyBloc,
                                builder: (context, currentPage) {
                                  return surveyBloc.index > 0? Container(
                                    margin: EdgeInsets.only(left:10),
                                    child: PButton(borderRadius:12,onPressed:() {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      surveyBloc.add(PrevPageEvent(controller:_controller));
                                      setState(() {});
                                    },title:'',fillColor:AppColors.secondary,
                                      hasBloc:false,size:PSize.text16,
                                      icon:PImage(source:AppSvgIcons.icBack,height:14,fit:BoxFit.scaleDown,),
                                      padding:EdgeInsets.zero,
                                    ),
                                  ) : const SizedBox.shrink() ;
                                },
                              ),

                              BlocBuilder<StaticSurveyBloc, BaseState>(
                                bloc:surveyBloc,
                                builder: (context, currentPage) {
                                  final isLastPage = surveyBloc.index == surveyBloc.surveyList.length - 1;
                                  return Expanded(
                                    child: PButton(borderRadius:12,onPressed:
                                    !(surveyBloc.validateCurrentPage())?null:() {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      surveyBloc.add(NextPageEvent(controller:_controller));
                                    },title: isLastPage ? 'حفظ' : 'التالي',
                                        fontWeight:FontWeight.w700,
                                        hasBloc:false,size:PSize.text16,
                                        icon:isLastPage ?null:
                                        PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,
                                          color:!(surveyBloc.validateCurrentPage())?
                                          AppColors.blackColor:AppColors.whiteColor,),

                                        // Icon(Icons.arrow_forward,color:!(surveyBloc.validateCurrentPage())?
                                        // AppColors.blackColor:AppColors.whiteColor,),
                                        textColor:!(surveyBloc.validateCurrentPage())?AppColors.blackColor:AppColors.whiteColor,
                                        borderColor:!(surveyBloc.validateCurrentPage())?Colors.transparent:AppColors.primaryColor
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height:20,)
                      ],),
                  ),
                  // Positioned(
                  //     top:50,
                  //     right:10,
                  //     child:PImage(source:AppSvgIcons.heartWhite,width:190,height:170,
                  //       color:Colors.white.withOpacity(0.4),fit: BoxFit.fitHeight,)
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}














