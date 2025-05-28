import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';
import 'package:mawidak/features/appointment/presentation/bloc/appointment_booking_bloc.dart';
import 'package:mawidak/features/appointment/presentation/bloc/appointment_booking_event.dart';
import 'package:mawidak/features/appointment/presentation/ui/widgets/successful_booking_bottom_sheet.dart';


enum PaymentMethod { applePay, directPay, installment , clinic}

class AppointmentPaymentScreen extends StatefulWidget {
  final AppointmentRequestModel model;
  const AppointmentPaymentScreen({super.key,required this.model});
  @override
  AppointmentPaymentScreenState createState() => AppointmentPaymentScreenState();
}

class AppointmentPaymentScreenState extends State<AppointmentPaymentScreen> {
  PaymentMethod? _selectedMethod;
  AppointmentBookingBloc appointmentBookingBloc = AppointmentBookingBloc(appointmentBookingUseCase:getIt());
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding( context: context, removeTop: true,
      child: BlocProvider(create: (context) => appointmentBookingBloc ,
        child: Scaffold(
          backgroundColor:AppColors.whiteBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:24),
              child: appBar(context: context,backBtn: true,text:'payment'.tr(),isCenter:true),
            ),
          ),
          body:BlocListener<AppointmentBookingBloc,BaseState>(listener:(context, state) {
            if(state is LoadingState){
              loadDialog();
            }else if(state is LoadedState){
              hideLoadingDialog();
              showSuccessfulBookingBottomSheet(context);
            }else if(state is ErrorState){
              hideLoadingDialog();
            }
          },child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText(title:'payment_way'.tr(),size:PSize.text14,),
                  const SizedBox(height:14,),
                  // Apple Pay
                  InkWell(hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                    SafeToast.show(message:'Soon',type:MessageType.warning);
                    return;
                      setState(() {
                        _selectedMethod = PaymentMethod.applePay;
                      });
                    },
                    child: Container(color:_selectedMethod == PaymentMethod.applePay ?
                    AppColors.primaryColor1100:Colors.transparent,
                      padding:EdgeInsets.symmetric(vertical:12,horizontal:10),
                      margin: const EdgeInsets.symmetric(vertical: 0.0,horizontal:0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20, height: 20,
                            child: Radio<PaymentMethod>(
                              value: PaymentMethod.applePay,
                              groupValue: _selectedMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedMethod = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PText(
                                  title: 'Apple Pay',
                                  fontColor: _selectedMethod == PaymentMethod.applePay
                                      ? AppColors.blackColor
                                      : AppColors.grey200,
                                  size: PSize.text16,
                                  fontWeight: FontWeight.w400,
                                ),
                                PImage(source: AppIcons.applePay, width: 50, height: 20,
                                  color: Colors.transparent,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Direct Pay (Visa, MasterCard, Mada)
                  InkWell(hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      SafeToast.show(message:'Soon',type:MessageType.warning);
                      return;
                      setState(() {
                        _selectedMethod = PaymentMethod.directPay;
                      });
                    },
                    child: Container(
                      color:_selectedMethod == PaymentMethod.directPay ?
                      AppColors.primaryColor1100:Colors.transparent,
                      padding:EdgeInsets.symmetric(vertical:12,horizontal:10),
                      margin: const EdgeInsets.symmetric(vertical: 0.0,horizontal:0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20, height: 20,
                            child: Radio<PaymentMethod>(
                              value: PaymentMethod.directPay,
                              groupValue: _selectedMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedMethod = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PText(
                                  title: 'الدفع المباشر',
                                  fontColor: _selectedMethod == PaymentMethod.directPay
                                      ? AppColors.blackColor
                                      : AppColors.grey200,
                                  size: PSize.text16,
                                  fontWeight: FontWeight.w400,
                                ),Spacer(),
                                PImage(source: AppIcons.mada,width:44,height:24,),
                                const SizedBox(width:8,),
                                PImage(source: AppIcons.masterCard,width:40,height:30),
                                const SizedBox(width:8,),
                                PImage(source: AppIcons.visa,width:48,height:25),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      SafeToast.show(message:'Soon',type:MessageType.warning);
                      return;
                      setState(() {
                        _selectedMethod = PaymentMethod.installment;
                      });
                    },
                    child: Container(color:_selectedMethod == PaymentMethod.installment ?
                    AppColors.primaryColor1100:Colors.transparent,
                      padding:EdgeInsets.symmetric(vertical:12,horizontal:10),
                      margin: const EdgeInsets.symmetric(vertical: 0.0,horizontal:0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20, height: 20,
                            child: Radio<PaymentMethod>(
                              value: PaymentMethod.installment,
                              groupValue: _selectedMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedMethod = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PText(
                                  title: 'الدفع بالتقسيط',
                                  fontColor: _selectedMethod == PaymentMethod.installment
                                      ? AppColors.blackColor
                                      : AppColors.grey200,
                                  size: PSize.text16,
                                  fontWeight: FontWeight.w400,
                                 ),
                                Spacer(),
                                PImage(source:AppIcons.tamara,width:58,height:25,),const SizedBox(width:10,),
                                PImage(source:AppIcons.tabby,width:50,height:25,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Installment (Tabby / Tamara)
                  InkWell(hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _selectedMethod = PaymentMethod.clinic;
                      });
                    },
                    child: Container(
                      color:_selectedMethod == PaymentMethod.clinic ?
                      AppColors.primaryColor1100:Colors.transparent,
                      padding:EdgeInsets.symmetric(vertical:12,horizontal:10),
                      margin: const EdgeInsets.symmetric(vertical: 0.0,horizontal:0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20, height: 20,
                            child: Radio<PaymentMethod>(
                              value: PaymentMethod.clinic,
                              groupValue: _selectedMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedMethod = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PText(
                                  title: 'الدفع في العيادة',
                                  fontColor: _selectedMethod == PaymentMethod.clinic
                                      ? AppColors.blackColor
                                      : AppColors.grey200,
                                  size: PSize.text16,
                                  fontWeight: FontWeight.w400,
                                ),
                                // PImage(source: AppIcons.livePayment, width: 50, height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(height: 20),

                  // Visibility based on selection
                  if (_selectedMethod == PaymentMethod.directPay)
                    buildDirectPaymentForm(),

                  if (_selectedMethod == PaymentMethod.installment)
                    buildInstallmentInfo(),

                  if (_selectedMethod == PaymentMethod.applePay)
                    buildApplePayInfo(),
                  if (_selectedMethod == PaymentMethod.clinic)
                    buildInClinicInfo(),
                ],
              ),
            ),
          ),),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical:16),
            child: PButton(title:'book_appointment'.tr(),onPressed:() {
              // showSuccessfulBookingBottomSheet(context);
              widget.model.clinicId = 1;
              widget.model.status = 1;
              widget.model.paymentMethod = 0;
              print('widget.model>>'+jsonEncode(widget.model));
              appointmentBookingBloc.add(ApplyAppointmentBookingEvent(model: widget.model));
            },hasBloc:false,isFitWidth:true,
                icon:PImage(source:
                isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,
                  height:14,fit:BoxFit.scaleDown,)),
          ),
        ),
      ),
    );
  }

  Widget buildDirectPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:4),
          child: Divider(color:AppColors.grey100,),
        ),
        const SizedBox(height:16,),
        PTextField(labelAbove:'اسم حامل البطاقة',hintText:'أدخل اسمك الكامل',feedback:(value) {

        },),
        const SizedBox(height:16,),
        PTextField(labelAbove:'رقم البطاقة',hintText:'أدخل الرقم المكون من 16 رقم',feedback:(value) {

        },),
        const SizedBox(height:16,),
        Row(
          children: [
            Expanded(
              child: PTextField(labelAbove:'تاريخ الانتهاء',hintText:'MM/YY',feedback:(value) {
              
              },),
            ),
            SizedBox(width: 16),
            Expanded(
              child:PTextField(labelAbove:'CCV',hintText:'***',feedback:(value) {

              },),
            ),


          ],
        ),
      ],
    );
  }

  Widget buildInstallmentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:4),
          child: Divider(color:AppColors.grey100,),
        ),
        const SizedBox(height:16,),
        PTextField(labelAbove:'اسم حامل البطاقة',hintText:'أدخل اسمك الكامل',feedback:(value) {

        },),
        const SizedBox(height:16,),
        PTextField(labelAbove:'رقم البطاقة',hintText:'أدخل الرقم المكون من 16 رقم',feedback:(value) {

        },),
        const SizedBox(height:16,),
        Row(
          children: [
            Expanded(
              child: PTextField(labelAbove:'تاريخ الانتهاء',hintText:'MM/YY',feedback:(value) {

              },),
            ),
            SizedBox(width: 16),
            Expanded(
              child:PTextField(labelAbove:'CCV',hintText:'***',feedback:(value) {

              },),
            ),


          ],
        ),
      ],
    );
  }

  Widget buildApplePayInfo() {
    return SizedBox.shrink();
  }


  Widget buildInClinicInfo() {
    return SizedBox.shrink();
  }

}





