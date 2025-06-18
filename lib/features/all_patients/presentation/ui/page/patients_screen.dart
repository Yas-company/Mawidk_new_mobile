import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';
import 'package:mawidak/features/all_patients/presentation/bloc/patients_bloc.dart';
import 'package:mawidak/features/all_patients/presentation/bloc/patients_event.dart';
import 'package:mawidak/features/all_patients/presentation/ui/widgets/patient_item_card_widget.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/search_widget.dart';


class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});
  @override
  State<PatientsScreen> createState() => PatientsScreenState();
}

class PatientsScreenState extends State<PatientsScreen> with TickerProviderStateMixin {
  PatientsBloc patientsBloc = PatientsBloc(patientsUseCase: getIt());

  List<bool> _visibleItems = [];

  Future<void> refreshData() async {
    final completer = Completer<void>();
    // Listen once for the loaded state
    final subscription = patientsBloc.stream.listen((state) {
      if (state is LoadedState) {
        final list = (state.data).model?.model ?? [];
        _runStaggeredAnimation(list.length);
        completer.complete();
      }
    });
    // Trigger refresh
    patientsBloc.add(GetDoctorPatients());
    // Wait for completion
    await completer.future;
    await subscription.cancel();
  }


  void _runStaggeredAnimation(int count) async {
    _visibleItems = List.generate(count, (_) => false);
    for (int i = 0; i < count; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _visibleItems[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => patientsBloc,
      child: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.whiteColor,
        onRefresh: refreshData,
        child: MediaQuery.removePadding(
          context: context, removeTop: true,
          child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: AppColors.whiteBackground,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Padding(
                padding:  EdgeInsets.only(top: 24,right:isArabic()?30:50),
                child: appBar(
                  context: context,
                  backBtn: false, isCenter: true,
                  text: 'patients_list_title'.tr(),
                ),
              ),
            ),
            body: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:16,right:16,top:10,bottom:10),
                  child: SearchWidget(hint:'patient_list'.tr(),hasFilter:false,onFieldSubmitted:(p0) {
                    context.push(AppRouter.searchResultsForDoctor,extra:p0);
                  },),
                ),

                PBlocBuilder<PatientsBloc, BaseState>(
                  bloc: patientsBloc,
                  init: () {
                    patientsBloc.add(GetDoctorPatients());
                  },
                  loadedWidget: (state) {
                    List<PatientData> dataList =
                        ((state as LoadedState).data).model?.model ?? [];

                    if (_visibleItems.length != dataList.length) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _runStaggeredAnimation(dataList.length);
                      });
                    }

                    if (dataList.isEmpty) {
                      return Expanded(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hourglass_empty,color: Colors.black,),
                          PText(title: 'no_patients_found'.tr(), size: PSize.text18),
                        ],
                      ));
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: dataList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = dataList[index];
                            final visible = _visibleItems.length > index && _visibleItems[index];

                            return AnimatedOpacity(
                              opacity: visible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedSlide(
                                duration: const Duration(milliseconds: 500),
                                offset: visible ? Offset.zero : const Offset(0, 0.2),
                                child: PatientItemCardWidget(
                                  onCardClick: () {
                                    // context.push(AppRouter.doctorProfileScreen, extra: {
                                    //   'id': item.doctor?.id ?? 0,
                                    //   'name': item.doctor?.name ?? '',
                                    //   'specialization': item.doctor?.specialization ?? '',
                                    // });
                                  },
                                  onTap: () {
                                  }, patientData: item,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                  loadingWidget: Expanded(child: Center(child: CustomLoader(size: 35))),
                  emptyWidget: (state) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.hourglass_empty,color: Colors.black,),
                            PText(title: 'no_patients_found'.tr(), size: PSize.text18),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

