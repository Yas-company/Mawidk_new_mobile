import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/Splash/presentation/ui/splash_screen.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';
import 'package:mawidak/features/all_patients/presentation/ui/page/patients_screen.dart';
import 'package:mawidak/features/all_specializations/presentation/ui/page/all_specializations_screen.dart';
import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';
import 'package:mawidak/features/appointment/presentation/ui/pages/appointment_booking_screen.dart';
import 'package:mawidak/features/appointment/presentation/ui/pages/appointment_payment_screen.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_bloc.dart';
import 'package:mawidak/features/appointments/presentation/ui/page/appointments_screen.dart';
import 'package:mawidak/features/appointments/presentation/ui/page/doctor_pending_appointments_screen.dart';
import 'package:mawidak/features/change_password/presentation/ui/page/change_password_screen.dart';
import 'package:mawidak/features/confirm_password/presentation/ui/pages/confirm_password_screen.dart';
import 'package:mawidak/features/contact_us/presentation/ui/page/contact_us_screen.dart';
import 'package:mawidak/features/doctor_or_patient/presentation/ui/pages/doctor_or_patient_screen.dart';
import 'package:mawidak/features/doctor_profile/presentation/ui/page/doctor_profile_screen.dart';
import 'package:mawidak/features/doctor_ratings/presentation/ui/page/doctor_ratings_screen.dart';
import 'package:mawidak/features/doctors_of_speciality/presentation/ui/page/doctors_of_speciality_screen.dart';
import 'package:mawidak/features/edit_personal_info/presentation/ui/page/edit_personal_info_screen.dart';
import 'package:mawidak/features/forget_password/presentation/ui/pages/forget_password_screen.dart';
import 'package:mawidak/features/home/presentation/ui/page/home_screen_doctor.dart';
import 'package:mawidak/features/home/presentation/ui/page/home_screen_patient.dart';
import 'package:mawidak/features/login/presentation/ui/pages/login_screen.dart';
import 'package:mawidak/features/more/presentation/ui/page/more_screen.dart';
import 'package:mawidak/features/notification/presentation/ui/page/notification_screen.dart';
import 'package:mawidak/features/onboarding/onboarding_screen.dart';
import 'package:mawidak/features/parent_screen/parent_screen.dart';
import 'package:mawidak/features/patient_appointments/presentation/ui/page/patient_appointments_screen.dart';
import 'package:mawidak/features/patient_favourite/presentation/ui/page/patient_favourite_screen.dart';
import 'package:mawidak/features/register/presentation/ui/pages/register_screen.dart';
import 'package:mawidak/features/search/presentation/ui/pages/search_screen.dart';
import 'package:mawidak/features/search_results/presentation/ui/pages/search_results_screen.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/ui/pages/search_for_doctors_screen.dart';
import 'package:mawidak/features/show_file/presentation/ui/page/show_file_screen.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/consultation_bottom_sheet.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_cubit.dart';
import 'package:mawidak/features/survey/presentation/ui/pages/doctor_survey_screen.dart';
import 'package:mawidak/features/survey/presentation/ui/pages/patient_survey_screen.dart';
import 'package:mawidak/features/survey/presentation/ui/pages/static_doctor_survey_screen.dart';
import 'package:mawidak/features/survey/presentation/ui/pages/static_patient_survey_screen.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/doctor_widgets/location_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/doctor_widgets/pickup_location_screen.dart';
import 'package:mawidak/features/verify_otp/presentation/ui/pages/verify_otp_screen.dart';

final ValueNotifier<bool> _refreshNotifier = ValueNotifier<bool>(false);

class RouterManager {
  static final GoRouter routerManager = GoRouter(
    initialLocation: AppRouter.splash,
    observers: [routeAwareObserver],
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    refreshListenable: _refreshNotifier,
    routes: [
      GoRoute(
        name: AppRouter.splash,
        path: AppRouter.splash,
        pageBuilder: (context, state) {
          return createRoute(widget: const SplashScreen());
        },
      ),
      GoRoute(
        name: AppRouter.login,
        path: AppRouter.login,
        pageBuilder: (context, state) {
          return createRoute(widget: const LoginScreen());
        },
      ),
      GoRoute(
        name: AppRouter.register,
        path: AppRouter.register,
        pageBuilder: (context, state) {
          return createRoute(widget: const RegisterScreen());
        },
      ),
      // GoRoute(
      //   name: AppRouter.survey,
      //   path: AppRouter.survey,
      //   pageBuilder: (context, state) {
      //     return createRoute(widget:  SurveyScreen());
      //   },
      // ),
      GoRoute(
        name: AppRouter.patientSurvey,
        path: AppRouter.patientSurvey,
        pageBuilder:(context, state) {
          // return createRoute(widget:  PatientSurveyScreen(surveyBloc:state.extra as SurveyBloc,));
          return createRoute(widget:StaticPatientSurveyScreen());
        },
        // builder: (context, state) {
        //   return createRoute(widget:  PatientSurveyScreen(surveyBloc:state.extra as SurveyBloc,));
        // },
      ),
      GoRoute(
        name: AppRouter.doctorSurvey,
        path: AppRouter.doctorSurvey,
        pageBuilder:(context, state) {
          // return createRoute(widget:  DoctorSurveyScreen(surveyBloc:state.extra as SurveyBloc,));
          return createRoute(widget:StaticDoctorSurveyScreen());
        },
        // builder: (context, state) {
        //   return BlocProvider(
        //     create: (_) => SurveyCubit(),
        //     child: const DoctorSurveyScreen(),
        //   );
        // },
      ),
      GoRoute(
        name: AppRouter.forgetPassword,
        path: AppRouter.forgetPassword,
        pageBuilder: (context, state) {
          return createRoute(widget:  ForgetPasswordScreen());
        },
      ),
      GoRoute(
        name: AppRouter.verifyOtp,
        path: AppRouter.verifyOtp,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  VerifyOtpScreen(
            // phone:state.extra as String,
            phone:params['phone'],
            isLogin:params['isLogin'],
          ));
        },
      ),
      GoRoute(
        name: AppRouter.doctorOrPatientScreen,
        path: AppRouter.doctorOrPatientScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:  DoctorOrPatientScreen());
        },
      ),
      GoRoute(
        name: AppRouter.confirmPassword,
        path: AppRouter.confirmPassword,
        pageBuilder: (context, state) {
          return createRoute(widget:  ConfirmPasswordScreen(phone:state.extra as String,));
        },
      ),
      GoRoute(
        name: AppRouter.pickupLocationScreen,
        path: AppRouter.pickupLocationScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:PickupLocationScreen());
        },
      ),
      GoRoute(
        name: AppRouter.locationScreen,
        path: AppRouter.locationScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:LocationWidgetScreen());
        },
      ),
      GoRoute(
        name: AppRouter.search,
        path: AppRouter.search,
        pageBuilder: (context, state) {
          return createRoute(widget:SearchScreen());
        },
      ),
      GoRoute(
        name: AppRouter.searchResults,
        path: AppRouter.searchResults,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  SearchResultsScreen(
            lookupBloc:params['lookupBloc'] , searchKey: params['searchKey'],
            isFilterClicked: params['isFilterClicked'],
            filterRequestModel: params['filterRequestModel'],
            specializationId:params['specializationId'],
          ));
          // return createRoute(widget:SearchResultsScreen(searchKey:state.extra as String));
        },
      ),

      GoRoute(
        name: AppRouter.consultationBottomSheet,
        path: AppRouter.consultationBottomSheet,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  ConsultationBottomSheet(
            onSubmit:params['onSubmit'],
            isEdit:params['isEdit'],
            // item:params['item'],
          ));
        },
      ),

      GoRoute(
        name: AppRouter.onBoarding,
        path: AppRouter.onBoarding,
        pageBuilder: (context, state) {
          return createRoute(widget:OnBoardingPage());
        },
      ),
      GoRoute(
        name: AppRouter.doctorProfileScreen,
        path: AppRouter.doctorProfileScreen,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  DoctorProfileScreen(
            id:params['id'], name:params['name'],
            specialization:params['specialization'],
          ));
          // return createRoute(widget:DoctorProfileScreen(id:state.extra as int));
        },
      ),
      GoRoute(
        name: AppRouter.doctorRatingsScreen,
        path: AppRouter.doctorRatingsScreen,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  DoctorRatingsScreen(
            id:params['id'], name:params['name'],
            isRating:params['isRating']??false,
          ));
          // return createRoute(widget:DoctorRatingsScreen(id:state.extra as int));
        },
      ),
      GoRoute(
        name: AppRouter.changePassword,
        path: AppRouter.changePassword,
        pageBuilder: (context, state) {
          return createRoute(widget:ChangePasswordScreen());
        },
      ),
      GoRoute(
        name: AppRouter.editPersonalInfo,
        path: AppRouter.editPersonalInfo,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:EditPersonalInfoScreen(
            phone:params['phone'],name:params['name'],
          ));
        },
      ),
      GoRoute(
        name: AppRouter.doctorsOfSpeciality,
        path: AppRouter.doctorsOfSpeciality,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  DoctorsOfSpecialityScreen(
            id:params['id'],specializationName:params['specializationName'],
          ));
        },
      ),
      GoRoute(
        name: AppRouter.notificationScreen,
        path: AppRouter.notificationScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:NotificationScreen());
        },
      ),
      GoRoute(
        name: AppRouter.appointmentBookingScreen,
        path: AppRouter.appointmentBookingScreen,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return createRoute(widget:  AppointmentBookingScreen(
            id:params['id'], name:params['name'],specialization:params['specialization'],
          ));
        },
      ),
      GoRoute(
        name: AppRouter.appointmentPaymentScreen,
        path: AppRouter.appointmentPaymentScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:AppointmentPaymentScreen(model:state.extra as AppointmentRequestModel,));
        },
      ),
      GoRoute(
        name: AppRouter.doctorPendingAppointments,
        path: AppRouter.doctorPendingAppointments,
        pageBuilder: (context, state) {
          return createRoute(widget:DoctorPendingAppointmentsScreen(
            // pendingList:state.extra as List<DoctorAppointmentsData>,
            doctorAppointmentsBloc:state.extra as DoctorAppointmentsBloc,
          ));
        },
      ),
      GoRoute(
        name: AppRouter.searchResultsForDoctor,
        path: AppRouter.searchResultsForDoctor,
        pageBuilder: (context, state) {
          return createRoute(widget:SearchForDoctorsScreen(searchKey:state.extra as String,));
        },
      ),
      GoRoute(
        name: AppRouter.allSpecializationsScreen,
        path: AppRouter.allSpecializationsScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:AllSpecializationsScreen());
        },
      ),
      GoRoute(
        name: AppRouter.showFileScreen,
        path: AppRouter.showFileScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:ShowFileScreen(patientData:state.extra as PatientData,));
        },
      ),
      GoRoute(
        name: AppRouter.contactUsScreen,
        path: AppRouter.contactUsScreen,
        pageBuilder: (context, state) {
          return createRoute(widget:ContactUsScreen());
        },
      ),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ParentScreen(navigationShell: navigationShell);
          },
          branches: [
            // if(isDoctor())
              StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.homeDoctor,
                path: AppRouter.homeDoctor,
                pageBuilder: (context, state) {
                  return createRoute(widget: const HomeScreenDoctor());
                },
              ),
            ]),
            // if(!isDoctor())
              StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.homePatient,
                path: AppRouter.homePatient,
                pageBuilder: (context, state) {
                  return createRoute(widget: const HomeScreenPatient());
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.appointments,
                path: AppRouter.appointments,
                pageBuilder: (context, state) {
                  return createRoute(widget: const AppointmentsScreen());
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.doctorPatients,
                path: AppRouter.doctorPatients,
                pageBuilder: (context, state) {
                  return createRoute(widget: const PatientsScreen());
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.patientFavouriteScreen,
                path: AppRouter.patientFavouriteScreen,
                pageBuilder: (context, state) {
                  return createRoute(widget: const PatientFavouriteScreen());
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.more,
                path: AppRouter.more,
                pageBuilder: (context, state) {
                  return createRoute(widget: const MoreScreen());
                },
              ),
            ]),

            StatefulShellBranch(routes: [
              GoRoute(
                name: AppRouter.patientAppointmentsScreen,
                path: AppRouter.patientAppointmentsScreen,
                pageBuilder: (context, state) {
                  return createRoute(widget: const PatientAppointmentsScreen());
                },
              ),
            ]),
          ])
    ],
  );

  GoRouter get router => routerManager;
}

class RouteAwareObserver extends NavigatorObserver {
  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is ModalRoute) {
      routeObserver.didPush(route, previousRoute as ModalRoute?);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is ModalRoute) {
      routeObserver.didPop(route, previousRoute as ModalRoute?);
    }
  }
}

final RouteAwareObserver routeAwareObserver = RouteAwareObserver();

void logCurrentRoute() {
  final currentRoute =
      RouterManager().router.routerDelegate.currentConfiguration.fullPath;
  debugPrint('Current route: $currentRoute');
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(3, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.ease),
          ),
        ),
        child: child,
      );
    },
  );
}

PageRouteBuilder createZoomPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  );
}
