import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class DoctorWorkHoursPicker extends StatefulWidget {
  const DoctorWorkHoursPicker({super.key});

  @override
  State<DoctorWorkHoursPicker> createState() => DoctorWorkHoursPickerState();
}

class DoctorWorkHoursPickerState extends State<DoctorWorkHoursPicker> {
  TimeOfDay? _startTime = TimeOfDay.now();
  TimeOfDay? _endTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  Future<void> _selectTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime ?? TimeOfDay.now() : _endTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
          if (_endTime != null && _compareTimes(_endTime!, picked) < 0) {
            _endTime = null;
          }
        } else {
          _endTime = picked;
        }
      });
    }
  }

  int _compareTimes(TimeOfDay t1, TimeOfDay t2) {
    return (t1.hour * 60 + t1.minute) - (t2.hour * 60 + t2.minute);
  }

  Widget _timeButton(TimeOfDay? time, VoidCallback onTap, String? hint, {Color? color}) {
    String timeFormatted = time != null ? _formatTime(time) : (hint ?? '');

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: time != null ? AppColors.primaryColor200 : color,
        side: BorderSide(color: AppColors.primaryColor300, width: time != null ? 0 : 1),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      icon: Icon(Icons.access_time, color: Colors.black),
      label: Directionality(
        textDirection: TextDirection.ltr,
        child: PText(
          title: timeFormatted,
          fontWeight: FontWeight.w500,
          size: PSize.text14,
          fontColor: Colors.black,
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;

    final String ampm = hour >= 12 ? 'PM' : 'AM';
    final int displayHour = hour % 12;
    final formattedHour = displayHour == 0 ? 12 : displayHour;
    final formattedMinute = minute < 10 ? '0$minute' : '$minute';

    return '$formattedHour:$formattedMinute'+' $ampm ';
  }

  String _formatTimeAr(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;
    final String ampm = hour >= 12 ? 'م' : 'ص'; // Arabic AM/PM
    final int displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final String formattedMinute = minute.toString().padLeft(2, '0');
    String convertToArabicNumerals(String input) {
      const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
        return arabicDigits[int.parse(match.group(0)!)];
      });
    }
    final timeString = '$displayHour:$formattedMinute $ampm';
    return convertToArabicNumerals(timeString);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText(title: "ساعات العمل", size: PSize.text14),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(title: "من", size: PSize.text14),
                SizedBox(height: 8),
                _timeButton(_startTime, () => _selectTime(true), 'من'),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(title: "إلى", size: PSize.text14),
                SizedBox(height: 8),
                _timeButton(_endTime, () => _selectTime(false), 'إلى'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
