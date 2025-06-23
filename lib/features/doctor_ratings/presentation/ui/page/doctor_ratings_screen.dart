import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/doctor_ratings/presentation/bloc/doctor_ratings_bloc.dart';
import 'package:mawidak/features/doctor_ratings/presentation/bloc/doctor_ratings_event.dart';
import 'package:mawidak/features/doctor_ratings/presentation/ui/widgets/doctor_ratings_item.dart';

class DoctorRatingsScreen extends StatefulWidget {
  final int id;
  final bool isRating;
  final String name;
  final String image;
  final String specialization;

  const DoctorRatingsScreen({
    super.key,
    required this.id,
    required this.name,
    required this.specialization,
    required this.image,
    this.isRating = true,
  });

  @override
  State<DoctorRatingsScreen> createState() => _DoctorRatingsScreenState();
}

class _DoctorRatingsScreenState extends State<DoctorRatingsScreen> {
  final DoctorRatingsBloc doctorRatingsBloc = DoctorRatingsBloc(doctorRatingsUseCase: getIt());
  List<bool> _visibleItems = [];

  Future<void> refreshData() async {
    final completer = Completer<void>();
    final subscription = doctorRatingsBloc.stream.listen((state) {
      if (state is LoadedState) {
        final list = (state.data).model?.model ?? [];
        _runStaggeredAnimation(list.length);
        completer.complete();
      }
    });

    doctorRatingsBloc.add(ApplyDoctorRatingsEvent(id: widget.id, isRate: widget.isRating));
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
    return MediaQuery.removePadding(
      removeTop: true,context: context,
      child: BlocProvider(
        create: (_) => doctorRatingsBloc,
        child: Scaffold(
          backgroundColor: AppColors.whiteBackground,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: appBar(
                context: context,
                backBtn: true,
                text: widget.isRating ? 'all_evaluations'.tr() : 'all_comments'.tr(),
                isCenter: true,
              ),
            ),
          ),
          body: PBlocBuilder<DoctorRatingsBloc, BaseState>(
            bloc: doctorRatingsBloc,
            init: () {
              doctorRatingsBloc.add(ApplyDoctorRatingsEvent(id: widget.id, isRate: widget.isRating));
            },
            loadingWidget: const Center(child: CustomLoader(size: 35)),
            loadedWidget: (state) {
              final dataList = (state as LoadedState).data.model?.model ?? [];

              if (_visibleItems.length != dataList.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _runStaggeredAnimation(dataList.length);
                });
              }

              return RefreshIndicator(
                backgroundColor: AppColors.primaryColor,
                color: AppColors.whiteColor,
                onRefresh: refreshData,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PText(
                          title: widget.isRating ? 'evaluations'.tr() : 'comments'.tr(),
                          fontWeight: FontWeight.w700,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: PText(
                                fontWeight: FontWeight.w500,
                                size: PSize.text13,
                                title: '${dataList.length} ${widget.isRating ? 'evaluate'.tr() : 'comment'.tr()}',
                                fontColor: AppColors.grey200,
                              ),
                            ),
                            const Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child: Divider(height: 1, color: AppColors.grey200),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(dataList.length, (index) {
                      final visible = _visibleItems.length > index && _visibleItems[index];
                      return AnimatedOpacity(
                        opacity: visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: AnimatedSlide(
                          offset: visible ? Offset.zero : const Offset(0, 0.2),
                          duration: const Duration(milliseconds: 500),
                          child: DoctorRatingsItem(
                            doctorRating: dataList[index],
                            showRating: widget.isRating,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 200),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: PButton(
              isFitWidth: true,
              onPressed: () async {
                final response = await context.push(AppRouter.patientEvaluationScreen, extra: {
                  'image': widget.image,
                  'name': widget.name,
                  'id': widget.id,
                  'specialization': widget.specialization,
                });
                if ((response!=null)) {
                  doctorRatingsBloc.add(ApplyDoctorRatingsEvent(id: widget.id, isRate: widget.isRating));
                }
              },
              title: 'add_evaluate'.tr(),
              hasBloc: false,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}

