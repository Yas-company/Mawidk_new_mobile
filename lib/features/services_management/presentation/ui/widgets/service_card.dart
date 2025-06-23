import 'package:flutter/material.dart';
import 'package:mawidak/features/services_management/data/model/service_option_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceOptionModel service;
  final VoidCallback onToggle;

  const ServiceCard({super.key, required this.service, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(service.icon, color: Colors.blue, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(service.subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Switch(
            value: service.isActive,
            onChanged: (_) => onToggle(),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
