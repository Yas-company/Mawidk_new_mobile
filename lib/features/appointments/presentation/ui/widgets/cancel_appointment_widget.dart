import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';

class CancelAppointmentWidget extends StatefulWidget {
  final Function(CancelAppointmentRequestModel? value) onCancel;
  const CancelAppointmentWidget({super.key, required this.onCancel});

  @override
  CancelAppointmentWidgetState createState() => CancelAppointmentWidgetState();
}

class CancelAppointmentWidgetState extends State<CancelAppointmentWidget> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isConfirmEnabled = false;

  @override
  void initState() {
    super.initState();
    _reasonController.addListener(_onReasonChanged);
  }

  void _onReasonChanged() {
    setState(() {
      _isConfirmEnabled = _reasonController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _reasonController.removeListener(_onReasonChanged);
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 3, color: Colors.white),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            PText(
              title: 'appointment_cancel'.tr(),
              fontWeight: FontWeight.w700,
              size: PSize.text18,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.grey200,
                ))
          ]),
          const SizedBox(height: 20),
          PText(
            title: 'cancel_question'.tr(),
            fontColor: AppColors.grayShade3,
          ),
          const SizedBox(height: 16),
          PTextField(
            controller: _reasonController, // <-- bind controller here
            isEmail: true,
            isOptional: true,
            textInputType: TextInputType.text,
            labelAbove: 'cancel_reason'.tr(),
            hintText: 'type_reason_here'.tr(),
            feedback: (value) {},
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor2200,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: PText(
                    title: '!',
                    fontColor: Colors.white,
                    size: PSize.text14,
                  ),
                ),
                const SizedBox(width: 10),
                PText(
                  title: 'sure_reject'.tr(),
                  size: PSize.text13,
                  fontColor: AppColors.grayShade3,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: PButton(
                  onPressed: _isConfirmEnabled
                      ? () {
                    widget.onCancel(CancelAppointmentRequestModel(
                        cancellationReason: 4,
                        cancelledBy: 'doctor',
                        otherReason: _reasonController.text.trim()));
                  } : null,
                  title: 'confirm'.tr(),
                  fillColor:_isConfirmEnabled? AppColors.danger : AppColors.grayColor200,
                  textColor:_isConfirmEnabled? AppColors.whiteBackground : AppColors.blackColor,
                  hasBloc: false,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PButton(
                  onPressed: () => Navigator.pop(context),
                  title: 'cancel'.tr(),
                  fillColor: AppColors.secondary,
                  hasBloc: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


void cancelAppointmentWidgetBottomSheet(final Function(CancelAppointmentRequestModel? value) onCancel) {
  showModalBottomSheet(
    context: navigatorKey.currentState!.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
      return AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: CancelAppointmentWidget(onCancel: onCancel),
          ),
        ),
      );
    },
  );
}
