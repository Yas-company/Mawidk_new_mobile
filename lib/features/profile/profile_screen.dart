import 'package:flutter/material.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor:AppColors.whiteBackground,
        body: Center(child: Text('Profile')));
  }
}
