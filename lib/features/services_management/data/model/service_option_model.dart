import 'package:flutter/material.dart';

class ServiceOptionModel {
  final String title;
  final String subtitle;
  final IconData icon;
  bool isActive;

  ServiceOptionModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isActive = false,
  });
}
