import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/patient_favourite/data/model/favourite_doctors_list_response_model.dart';
import 'package:mawidak/features/patient_favourite/presentation/bloc/favourite_bloc.dart';
import 'package:mawidak/features/patient_favourite/presentation/bloc/favourite_event.dart';
import 'package:mawidak/features/patient_favourite/presentation/ui/widgets/favourite_item_widget.dart';

FavouriteBloc favouriteBloc = FavouriteBloc(favouriteUseCase: getIt());

class PatientFavouriteScreen extends StatefulWidget {
  const PatientFavouriteScreen({super.key});


  @override
  State<PatientFavouriteScreen> createState() => PatientFavouriteScreenState();
}

class PatientFavouriteScreenState extends State<PatientFavouriteScreen> with TickerProviderStateMixin {

  List<bool> _visibleItems = [];

  Future<void> refreshData() async {
    final completer = Completer<void>();
    // Listen once for the loaded state
    final subscription = favouriteBloc.stream.listen((state) {
      if (state is LoadedState) {
        final list = (state.data).model?.model ?? [];
        _runStaggeredAnimation(list.length);
        completer.complete();
      }
    });
    // Trigger refresh
    favouriteBloc.add(ApplyFavouriteEvent());

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
      create: (context) => favouriteBloc,
      child: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.whiteColor,
        onRefresh: refreshData,
        child: Scaffold(
          backgroundColor: AppColors.whiteBackground,
          body: SafeArea(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 14),
                  child: PText(title: 'favourite'.tr()),
                ),
                PBlocBuilder<FavouriteBloc, BaseState>(
                  bloc: favouriteBloc,
                  init: () {
                    favouriteBloc.add(ApplyFavouriteEvent());
                  },
                  loadedWidget: (state) {
                    List<FavouriteDoctorListData> dataList =
                        ((state as LoadedState).data).model?.model ?? [];

                    if (_visibleItems.length != dataList.length) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _runStaggeredAnimation(dataList.length);
                      });
                    }

                    if (dataList.isEmpty) {
                      return Expanded(child: PText(title: 'no_doctors_found'.tr()));
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
                                child: FavouriteItemWidget(
                                  onCardClick: () {
                                    context.push(AppRouter.doctorProfileScreen, extra: {
                                      'id': item.doctor?.id ?? 0,
                                      'name': item.doctor?.name ?? '',
                                      'specialization': item.doctor?.specialization ?? '',
                                    });
                                  },
                                  onTap: () {
                                    context.push(AppRouter.appointmentBookingScreen, extra: {
                                      'id': item.doctor?.id ?? 0,
                                      'name': item.doctor?.name ?? '',
                                      'specialization': item.doctor?.specialization ?? '',
                                    });
                                  },
                                  imageUrl: item.doctor?.photo ?? '',
                                  doctorName: item.doctor?.name ?? '',
                                  rating: 4,
                                  location: '',
                                  specialization: item.doctor?.specialization ?? '',
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
                            Icon(Icons.hourglass_empty),
                            PText(title: 'no_doctors_found'.tr(), size: PSize.text18),
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

