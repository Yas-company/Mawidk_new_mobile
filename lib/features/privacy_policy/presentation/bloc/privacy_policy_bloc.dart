import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/privacy_policy/domain/use_case/privacy_policy_use_case.dart';
import 'package:mawidak/features/privacy_policy/presentation/bloc/privacy_policy_event.dart';


class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, BaseState> {
  final PrivacyPolicyUseCase policyUseCase;

  PrivacyPolicyBloc({required this.policyUseCase}) : super(InitialState()) {
    on<ApplyPrivacyPolicyEvent>(onApplyPrivacyPolicyEvent);
  }

  Future<void> onApplyPrivacyPolicyEvent(ApplyPrivacyPolicyEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await policyUseCase.getPrivacyPolicy(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(LoadedState(r,isMap:false));
    },
    );
  }

}
