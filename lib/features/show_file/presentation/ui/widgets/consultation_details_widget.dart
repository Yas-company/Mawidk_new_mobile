import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/consultation_data_response_model.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_bloc.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';

class ConsultationDetailsWidget extends StatefulWidget {
  final int id;
  const ConsultationDetailsWidget({super.key,required this.id,});

  @override
  State<ConsultationDetailsWidget> createState() => ConsultationDetailsWidgetState();
}
class ConsultationDetailsWidgetState extends State<ConsultationDetailsWidget> {
  ShowFileBloc showFileBloc = ShowFileBloc(showFileUseCase:getIt());
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,removeTop: true,
      child: BlocProvider(create:(context) => showFileBloc,
        child: Scaffold(
          backgroundColor:AppColors.whiteBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:24),
              child: appBar(context: context,backBtn: true,text:'تفاصيل الاستشارة'.tr(),isCenter:true),
            ),
          ),
          body:PBlocBuilder(bloc: showFileBloc,
            loadingWidget: Center(child: CustomLoader(size: 35)),
              init:() {
                showFileBloc.add(ApplyConsultationById(id: widget.id));
              },
              loadedWidget:(state) {
                ConsultationItemModel item
                = ((state as LoadedState).data).model?.model?? ConsultationItemModel();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(margin: EdgeInsets.only(top:10),
                          padding:EdgeInsets.only(left:14,right:14,bottom:10),
                          decoration:BoxDecoration(
                              color:AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height:4,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:10),
                                    child: PText(title:item.main_complaint??'',fontWeight:FontWeight.w700,),
                                  ),
                                  Container(margin: EdgeInsets.only(top:10),
                                      padding:EdgeInsets.symmetric(vertical:6,horizontal:10),
                                      decoration:BoxDecoration(
                                          color:Color(0xffD4EDDA),
                                          borderRadius:BorderRadius.circular(16)
                                      ),child:PText(title:'مكتملة',fontColor:Color(0xff61CF7B),
                                        fontWeight:FontWeight.w500,)),
                                ],
                              ),
                              const SizedBox(height:0,),
                              PText(title:(item.consultation_date??''),fontColor:AppColors.grey200,size:PSize.text13,),
                            ],
                          ),
                        ),
                    
                        Container(margin: EdgeInsets.only(top:20),
                          padding:EdgeInsets.symmetric(horizontal:14,vertical:10),
                          decoration:BoxDecoration(
                              color:AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PText(title:'الشكوى الرئيسية',fontWeight:FontWeight.w700,),
                              const SizedBox(height:10,),
                              PText(title:(item.main_complaint??''),fontColor:AppColors.grayShade3,size:PSize.text13,
                                fontWeight:FontWeight.w500,),
                            ],
                          ),
                        ),
                    
                        Container(margin: EdgeInsets.only(top:20),
                          padding:EdgeInsets.symmetric(horizontal:14,vertical:10),
                          decoration:BoxDecoration(
                              color:AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PText(title:'العلامات الحيوية',fontWeight:FontWeight.w700,),
                              const SizedBox(height:10,),
                              Row(children: [
                                Expanded(child: itemSign(title:'ضغط الدم',
                                    value:'${item.blood_pressure_systolic}/${item.blood_pressure_diastolic}' ,
                                    degree:'ملم زئبق')),
                                const SizedBox(width:14,),
                                Expanded(child: itemSign(title:'النبض', value:item.pulse_rate.toString(),
                                    degree:'نبضة / دقيقة')),
                              ],),
                              const SizedBox(height:14,),
                              Row(children: [
                                Expanded(child: itemSign(title:'درجة الحرارة', value:item.temperature.toString(),
                                    degree:'درجة مئوية')),
                                const SizedBox(width:14,),
                                Expanded(child: itemSign(title:'مستوى السكر', value:item.blood_sugar_level.toString(),
                                    degree:'ملغم / ديسيلتر')),
                              ],),
                            ],
                          ),
                        ),
                    
                        Container(margin: EdgeInsets.only(top:20),
                          padding:EdgeInsets.symmetric(horizontal:14,vertical:10),
                          decoration:BoxDecoration(
                              color:AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PText(title:'الفحص السريري',fontWeight:FontWeight.w700,),
                              const SizedBox(height:10,),
                              PText(title:(item.clinical_examination??''),fontColor:AppColors.grayShade3,size:PSize.text13,
                                fontWeight:FontWeight.w500,),
                            ],
                          ),
                        ),
                    
                    
                        Container(margin: EdgeInsets.only(top:20),
                          padding:EdgeInsets.symmetric(horizontal:14,vertical:10),
                          decoration:BoxDecoration(
                              color:AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PText(title:'موعد المتابعة القادم',fontWeight:FontWeight.w700,),
                              const SizedBox(height:10,),
                              Row(
                                children: [
                                  Container(padding:EdgeInsets.all(8),
                                    decoration:BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor1100
                                  ),child:PImage(source: AppSvgIcons.icCalendar,color:AppColors.primaryColor,
                                  width:20,height:20,),),
                                  const SizedBox(width:10,),
                                  PText(title:(item.next_follow_up_date??''),fontColor:AppColors.grayShade3,size:PSize.text13,
                                    fontWeight:FontWeight.w500,),
                                ],
                              ),
                            ],
                          ),
                        ),
                    
                    
                        Container(margin: EdgeInsets.only(top:20),
                          padding:EdgeInsets.symmetric(horizontal:14,vertical:10),
                          decoration:BoxDecoration(
                              color:AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PText(title:'ملاحظات الطبيب',fontWeight:FontWeight.w700,),
                              const SizedBox(height:10,),
                              PText(title:(item.notes??''),fontColor:AppColors.grayShade3,size:PSize.text13,
                                fontWeight:FontWeight.w500,),
                            ],
                          ),
                        ),

                        const SizedBox(height:20,),
                    
                        PButton(title:'العودة الى ملف المريض'.tr(),isFitWidth:true,onPressed:() {
                          Navigator.pop(context);
                        },hasBloc:false,fillColor: AppColors.whiteColor,textColor:AppColors.primaryColor,
                        borderColor:AppColors.primaryColor,),
                        const SizedBox(height:20,),
                      ],
                    ),
                  ),
                );
              },)
        ),
      ),
    );
  }

  Widget itemSign({required String title,required dynamic value ,required String degree}) {
    return Container(padding:EdgeInsets.only(top:8,bottom:8,left:8,right:8),decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: AppColors.primaryColor1100
    ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        PText(title:title.tr(),fontColor: AppColors.grayShade3,size: PSize.text13,),
        const SizedBox(height:3,),
        PText(title:value,size: PSize.text13,fontWeight:FontWeight.w700,),
      const SizedBox(height:3,),
        PText(title:title.tr(),fontColor: AppColors.primaryColor,size: PSize.text13,fontWeight:FontWeight.w500,),
      ],),
    );
  }
}
