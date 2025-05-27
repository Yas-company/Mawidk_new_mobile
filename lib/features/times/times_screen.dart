import 'package:flutter/material.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class TimesScreen extends StatelessWidget {
  const TimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:AppColors.whiteBackground,
        body: Center(child: Text('Meetings')));
  }
}
