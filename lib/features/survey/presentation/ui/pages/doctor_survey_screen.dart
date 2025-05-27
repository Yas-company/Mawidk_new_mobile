import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/dynamic_question_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/steper_indicator.dart';

class DoctorSurveyScreen extends StatefulWidget {
  final SurveyBloc surveyBloc;
  const DoctorSurveyScreen({super.key,required this.surveyBloc});

  @override
  State<DoctorSurveyScreen> createState() => _PatientSurveyScreenState();
}

class _PatientSurveyScreenState extends State<DoctorSurveyScreen> {
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            right:0,
            child:PImage(source:AppIcons.human,height:300,width:380,
              color:Colors.red,fit: BoxFit.fitHeight,)
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.whiteBackground,
            appBar: AppBar(backgroundColor:Color(0xffF1F8FF),
              leadingWidth: 0,titleSpacing:0,automaticallyImplyLeading: false,
              leading:null,flexibleSpace:null,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child :Container(color:Color(0xffF1F8FF),
                    child: BlocBuilder<SurveyBloc, BaseState>(
                      bloc: widget.surveyBloc,
                      builder: (context, state) {
                        return StepIndicator(
                          currentStep: widget.surveyBloc.index,
                          allSteps: widget.surveyBloc.surveyList.length,
                        );
                      },
                    )
                ),
              ),
            ),
            body: Column(children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.surveyBloc.surveyList.length,
                  itemBuilder: (context, index) {
                    final page = widget.surveyBloc.surveyList[index];
                    return index==0?
                    Stack(children: [
                      Positioned(
                          left:-142,
                          top:140,child: PImage(source:AppIcons.human,fit:BoxFit.fitWidth,
                        height:MediaQuery.sizeOf(context).height*0.50,)),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 400, color:Color(0xffF1F8FF),
                              padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20,),
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
                                  right:20),
                              child:buildQuestionWidget(q, (callback) {
                                setState(callback);
                                widget.surveyBloc.add(ValidateSurveyEvent());
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
                              width: 400, color:Color(0xffF1F8FF),
                              padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20,),
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
                                  widget.surveyBloc.add(ValidateSurveyEvent());
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
              // BlocListener<SurveyBloc, BaseState>(
              //   bloc: widget.surveyBloc,
              //   listener: (context, state) {
              //     print('hererer>>'+state.toString());
              //     if(state is PageChangedState){
              //       print('index>>'+widget.surveyBloc.index.toString());
              //       _controller.animateToPage(
              //         widget.surveyBloc.index,
              //         duration: const Duration(milliseconds: 500),
              //         curve: Curves.easeInOut,
              //       );
              //     }
              //   },
              //   child: ,
              // ),
              Padding(
                padding: const EdgeInsets.only(left:14,right:14,bottom:10),
                // padding: const EdgeInsets.symmetric(horizontal:14,vertical:0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<SurveyBloc, BaseState>(
                      bloc:widget.surveyBloc,
                      builder: (context, currentPage) {
                        return widget.surveyBloc.index > 0? Container(
                          margin: EdgeInsets.only(left:10),
                          child: PButton(borderRadius:12,onPressed:() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            widget.surveyBloc.add(PrevPageEvent(controller:_controller));
                            setState(() {});
                          },title:'',fillColor:AppColors.secondary,
                            hasBloc:false,size:PSize.text16,
                            icon:PImage(source:AppSvgIcons.icBack,height:14,fit:BoxFit.scaleDown,),
                            fontWeight:FontWeight.w700,
                            // icon:Icon(Icons.arrow_back,color:AppColors.whiteColor,),
                            padding:EdgeInsets.zero,
                          ),
                        ) : const SizedBox.shrink() ;
                      },
                    ),

                    BlocBuilder<SurveyBloc, BaseState>(
                      bloc:widget.surveyBloc,
                      builder: (context, currentPage) {
                        final isLastPage = widget.surveyBloc.index == widget.surveyBloc.surveyList.length - 1;
                        return Expanded(
                          child: PButton(borderRadius:12,onPressed:
                          !(widget.surveyBloc.validateCurrentPage())?null:() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            widget.surveyBloc.add(NextPageEvent(controller:_controller));
                          },title: isLastPage ? 'حفظ' : 'التالي',
                              hasBloc:false,size:PSize.text16,
                              icon:isLastPage ?null:
                              PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,
                                color:!(widget.surveyBloc.validateCurrentPage())?AppColors.blackColor:AppColors.whiteColor,),
                              fontWeight:FontWeight.w700,
                              // Icon(Icons.arrow_forward,color:
                              // !(widget.surveyBloc.validateCurrentPage())?AppColors.blackColor:AppColors.whiteColor,),
                              textColor:!(widget.surveyBloc.validateCurrentPage())?AppColors.blackColor:AppColors.whiteColor,
                              borderColor:!(widget.surveyBloc.validateCurrentPage())?Colors.transparent:AppColors.primaryColor
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height:20,)
            ],
            ),
          ),
        ),
      ],
    );
  }
}














