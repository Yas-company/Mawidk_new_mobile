import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/bloc/static_survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/doctor_widgets/images_files_upload_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/dynamic_question_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/steper_indicator.dart';
import 'package:sizer/sizer.dart';

class StaticDoctorSurveyScreen extends StatefulWidget {
  const StaticDoctorSurveyScreen({super.key});

  @override
  State<StaticDoctorSurveyScreen> createState() => StaticDoctorSurveyScreenState();
}

class StaticDoctorSurveyScreenState extends State<StaticDoctorSurveyScreen> {
  List<ScreenModel> doctorStaticSurvey = [
    ScreenModel(
      id: 0,
      title: "معلوماتك الأساسية",
      subtitle: "هذه المعلومات مطلوبة للمتابعة",
      questions: [
        Question(padding:EdgeInsets.only(top:40),
          id: 1,isRequired:true,line:4,
          questionText: "نبذة عن الدكتور",
          type: "textarea",
        ),
        // Question(
        //   id: 1,isRequired:true,
        //   questionText: "النوع",
        //   type: "single_choice",
        //   options: [Option(id:1,optionText:"ذكر"), Option(id:2,optionText:"انثي")],
        // ),
        // Question(padding: EdgeInsets.only(top:0,bottom: 0),isRequired:true, id: 0,
        //   questionText: "المرتبة",
        //   type: "radio_button",
        //   options: [Option(id:1,optionText:'doctor2'.tr()),
        //     Option(id:2,optionText:"specialist2".tr()),Option(id:3,optionText:"consultant".tr())],
        // ),
        // Question(isRequired:true, id: 0,
        //   questionText: "المرتبة",
        //   type: "single_choice",
        //   options: [Option(id:1,optionText:"consultant".tr()),
        //     Option(id:2,optionText:"specialist".tr())],
        // ),
        Question(padding:EdgeInsets.zero,
          id: 1,isRequired:true,hint: 'اختر تخصصك',
          questionText: "اختر تخصصك",
          // type: "multi_select",
          // type: "multi_select_doctor",
          type: "drop_down",
          options:specializations
          // [Option(id:1,optionText:"باطنة"),
          //   Option(id:2,optionText:"طب عام"), Option(id:3,optionText:"قلب"),
          //   Option(id:4,optionText:"اطفال"), Option(id:5,optionText:"جراحة"),
          //   Option(id:6,optionText:"انف واذن"),],
        ),
      ],
    ),
    ScreenModel(
      id: 1,
      title: "المعلومات المهنية ",
      subtitle: "من فضلك اجب على الاسئلة التالية ",
      questions: [
        Question(id:0,padding: EdgeInsets.only(top:30,bottom: 0),isRequired:true,
          questionText: "المرتبة",
          type: "radio_button",
          options: [Option(id:1,optionText:'doctor2'.tr()),
            Option(id:2,optionText:"specialist2".tr()),Option(id:3,optionText:"consultant".tr())],
        ),
        // Question(
        //   id: 1,isRequired:true,
        //   questionText: "ما عدد سنوات الخبرة الطبية لديك ؟",
        //   type: "radio_button",
        //   options: [
        //     Option(id:1,optionText:"اقل من سنة"),
        //     Option(id:2,optionText:"-٣ سنوات"),
        //     Option(id:3,optionText:"من ٤-٦ سنوات"),
        //     Option(id:4,optionText:"اكثر من ٥ سنوات"),
        //     ],
        // ),
        Question(id: 1,isRequired:true,hint:'رقم الترخيص',
            questionText: "أدخل رقم الترخيص الطبي الخاص بك", type: "number"),
      ],
    ),
    ScreenModel(
      id: 2,
      title: "ارفع ملفاتك",
      subtitle: "قم برفع الصور أو الملفات الخاصة بك",
      questions: [], // No questions; content is handled by the widget
    ),
  ];
  late PageController _controller;
  StaticSurveyBloc surveyBloc = StaticSurveyBloc(surveyUseCase: getIt());
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    surveyBloc.surveyList = doctorStaticSurvey;
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
      context: context,barrierDismissible:false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 60),
                const SizedBox(height: 16),
                PText(title: 'يرجى إكمال الاستبيان',),
                const SizedBox(height: 12),
                Center(
                  child: PText(title: 'لا يمكنك الرجوع قبل إكمال جميع البيانات المطلوبة.',
                    fontColor:AppColors.grey200,alignText:TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                PButton(hasBloc:false,
                  title: 'حسنًا',isFitWidth:true,
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        );
      },);
      return false;
      },
      child: Scaffold(
        backgroundColor:AppColors.whiteBackground,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocProvider(
            create: (context) => surveyBloc,
            child: SizedBox(height:double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 31.h, width: double.infinity,
                    decoration: BoxDecoration(color:Color(0xFFF1F8FF)),
                    child: Stack(
                      children: [
                        Positioned(
                          top:7.h, right: 2,
                          child: CustomImageView(
                            imagePath: AppIcons.imgVector,color:Colors.white.withOpacity(0.6),
                            height: 22.8.h, width:33.5.w,fit: BoxFit.fitHeight,
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
                  Positioned(
                    top: 18.h, right: 0, left: 0, bottom: 0,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _controller,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: surveyBloc.surveyList.length,
                            itemBuilder: (context, index) {
                              final page = surveyBloc.surveyList[index];

                              if (index == surveyBloc.surveyList.length - 1) {
                                return ImagesFilesUploadWidget(
                                  files: surveyBloc.selectedFiles,
                                  onChange: (selectedFiles) {
                                    surveyBloc.selectedFiles = selectedFiles;
                                    surveyBloc.add(FillSelectedFilesEvent(files: selectedFiles));
                                    surveyBloc.add(ValidateSurveyEvent());
                                  },
                                );
                              }

                              return SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (index == 0)
                                      Row(
                                        children: [
                                          Icon(Icons.star, size: 12, color: Color(0xffD32F2F)),
                                          SizedBox(width: 4),
                                          PText(title: page.title ?? '', size: PSize.text20),
                                        ],
                                      )
                                    else
                                      PText(title: page.title ?? '', size: PSize.text20),
                                    PText(
                                      title: page.subtitle ?? '',
                                      size: PSize.text14,
                                      fontColor: AppColors.grey200,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(height: 20),
                                    if (page.questions != null && page.questions!.isNotEmpty)
                                      ...page.questions!.map((q) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical:10),
                                        child: buildQuestionWidget(q, (callback) {
                                          setState(callback);
                                          surveyBloc.add(ValidateSurveyEvent());
                                        }),
                                      )),
                                    SizedBox(height: 100), // space for buttons
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<StaticSurveyBloc, BaseState>(
                                bloc: surveyBloc,
                                builder: (context, currentPage) {
                                  return surveyBloc.index > 0
                                      ? Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: PButton(
                                      borderRadius: 12,
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        surveyBloc.add(PrevPageEvent(controller: _controller));
                                        setState(() {});
                                      },
                                      title: '',
                                      fillColor: AppColors.secondary,
                                      hasBloc: false,
                                      size: PSize.text16,
                                      icon: PImage(
                                        source: AppSvgIcons.icBack,
                                        height: 14,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  )
                                      : SizedBox.shrink();
                                },
                              ),
                              BlocBuilder<StaticSurveyBloc, BaseState>(
                                bloc: surveyBloc,
                                builder: (context, currentPage) {
                                  final isLastPage = surveyBloc.index == surveyBloc.surveyList.length - 1;
                                  final currentPageIndex = surveyBloc.index;
                                  final isFileEmpty = surveyBloc.selectedFiles.isEmpty;

                                  return Expanded(
                                    child: PButton(
                                      borderRadius: 12,
                                      onPressed: !(surveyBloc.validateCurrentPage()) || (currentPageIndex == 2 && isFileEmpty)
                                          ? null
                                          : () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        surveyBloc.add(NextPageEvent(controller: _controller));
                                      },
                                      title: isLastPage ? 'حفظ' : 'التالي',
                                      fontWeight: FontWeight.w700,
                                      hasBloc: false,
                                      size: PSize.text16,
                                      icon: isLastPage
                                          ? null
                                          : PImage(
                                        source: AppSvgIcons.icNext,
                                        height: 14,
                                        fit: BoxFit.scaleDown,
                                        color: !(surveyBloc.validateCurrentPage()) || (currentPageIndex == 2 && isFileEmpty)
                                            ? AppColors.blackColor
                                            : AppColors.whiteColor,
                                      ),
                                      textColor: !(surveyBloc.validateCurrentPage()) || (currentPageIndex == 2 && isFileEmpty)
                                          ? AppColors.blackColor
                                          : AppColors.whiteColor,
                                      borderColor: !(surveyBloc.validateCurrentPage()) || (currentPageIndex == 2 && isFileEmpty)
                                          ? Colors.transparent
                                          : AppColors.primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
















class CustomImageView extends StatelessWidget {
  CustomImageView({
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder,
  }) {
  }

  ///[imagePath] is required parameter for showing image
  late String? imagePath;

  final double? height;

  final double? width;

  final Color? color;

  final BoxFit? fit;

  final String? placeHolder;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? margin;

  final BorderRadius? radius;

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
        return Image.asset(
          imagePath!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
