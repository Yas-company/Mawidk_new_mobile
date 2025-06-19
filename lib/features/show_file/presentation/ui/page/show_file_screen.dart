import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/basic_information_widget.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/consultation_widget.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/diagnosis_widget.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/drug_widget.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/medical_history_widget.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/notes_widget.dart';
// Add imports for other tab widgets here

class ShowFileScreen extends StatefulWidget {
  final PatientData patientData;

  const ShowFileScreen({super.key, required this.patientData});

  @override
  ShowFileScreenState createState() => ShowFileScreenState();
}

class ShowFileScreenState extends State<ShowFileScreen> {
  final List<String> tabs = [
    'basic_information'.tr(),
    'medical_history'.tr(),
    'consultations'.tr(),
    'diagnoses'.tr(),
    'medicines'.tr(),
    'tests'.tr(),
    'notes_title'.tr(),
  ];

  int _selectedIndex = 0;
  late List<Widget?> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabViews = List.filled(tabs.length, null);
    _tabViews[0] = _buildTabWidget(0); // Load the first tab initially
  }

  Widget _buildCustomTab(int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          if (_tabViews[index] == null) {
            _tabViews[index] = _buildTabWidget(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(left: 0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.whiteBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.grayColor200 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            tabs[index],
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? AppColors.primaryColor : AppColors.grey200,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabWidget(int index) {
    switch (index) {
      case 0:
        return BasicInformationWidget(id: widget.patientData.id ?? 0);
      case 1:
        return MedicalHistoryWidget(id: widget.patientData.id ?? 0);
      case 2:
        return ConsultationWidget(id: widget.patientData.id ?? 0);
      case 3:
        return DiagnosisWidget(id: widget.patientData.id ?? 0);
      case 4:
        return DrugWidget(id: widget.patientData.id ?? 0);
      case 5:
        return Center(child: Text("Tests")); // Replace with actual widget
      case 6:
        return NotesWidget(id: widget.patientData.id ?? 0);
      default:
        return Center(child: Text("Not Implemented"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding:EdgeInsets.only(top:24),
            child: appBar(context: context,
              backBtn: true, isCenter: true,
              text: 'patient_file'.tr(),
            ),
          ),
        ),
        backgroundColor: AppColors.whiteBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Card(
                  color: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        (widget.patientData.photo ?? '').isEmpty
                            ? const CircleAvatar(
                          radius: 33,
                          backgroundColor: AppColors.whiteBackground,
                          child: Icon(Icons.person),
                        )
                            : PImage(
                          source: ApiEndpointsConstants.baseImageUrl +
                              (widget.patientData.photo ?? ''),
                          isCircle: true,
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PText(title: widget.patientData.name ?? ''),
                              const SizedBox(height: 11),
                              PText(
                                title: 'file_number'.tr() +
                                    (widget.patientData.lastAppointmentDate ??
                                        ''),
                                fontColor: AppColors.grey200,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) => _buildCustomTab(index),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: List.generate(
                    tabs.length,
                        (index) => _tabViews[index] ?? const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
