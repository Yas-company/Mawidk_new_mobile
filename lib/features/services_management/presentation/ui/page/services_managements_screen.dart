import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/features/services_management/data/model/service_option_model.dart';
import 'package:mawidak/features/services_management/presentation/ui/widgets/service_card.dart';

class ServiceManagementPage extends StatefulWidget {
  const ServiceManagementPage({super.key});

  @override
  State<ServiceManagementPage> createState() => _ServiceManagementPageState();
}

class _ServiceManagementPageState extends State<ServiceManagementPage> {
  List<ServiceOptionModel> services = [
    ServiceOptionModel(title:'receive_in_clinic'.tr(), subtitle: 'استقبال المرضى في عيادتك الخاصة', icon: Icons.local_hospital),
    ServiceOptionModel(title: 'online'.tr(), subtitle: 'تقديم الاستشارات عبر مكالمات فيديو او صوت', icon: Icons.videocam),
    ServiceOptionModel(title:'free_consultations'.tr(), subtitle: 'تقديم استشارات مجانية', icon: Icons.volunteer_activism),
    ServiceOptionModel(title: 'home_visit'.tr(), subtitle: 'زيارة المرضى في منازلهم', icon: Icons.home),
  ];

  void toggleService(int index) {
    setState(() {
      services[index].isActive = !services[index].isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة الخدمات")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('ما هي الخدمات التي تقدمها؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceCard(
                  service: services[index],
                  onToggle: () => toggleService(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Confirm action
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('تأكيد'),
            ),
          ),
        ],
      ),
    );
  }
}
