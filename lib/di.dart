import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mawidak/core/base_network/client/dio_client.dart';
import 'package:mawidak/core/base_network/network_lost/network_info.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/core/services/log/app_log.dart';
import 'package:mawidak/features/appointment/data/repository/appoitment_booking_repository_impl.dart';
import 'package:mawidak/features/appointment/domain/repository/appoitment_booking_repository.dart';
import 'package:mawidak/features/appointment/domain/use_case/appoitment_booking_use_case.dart';
import 'package:mawidak/features/change_password/data/repository/change_password_repository_impl.dart';
import 'package:mawidak/features/change_password/domain/repository/change_password_repository.dart';
import 'package:mawidak/features/change_password/domain/use_case/change_password_use_case.dart';
import 'package:mawidak/features/confirm_password/data/repository/confirm_password_repository_impl.dart';
import 'package:mawidak/features/confirm_password/domain/repository/confirm_password_repo.dart';
import 'package:mawidak/features/confirm_password/domain/use_case/confirm_password_use_case.dart';
import 'package:mawidak/features/contact_us/data/repository/contact_us_repository_impl.dart';
import 'package:mawidak/features/contact_us/domain/repository/contact_us_repository.dart';
import 'package:mawidak/features/contact_us/domain/use_case/contact_us_use_case.dart';
import 'package:mawidak/features/doctor_profile/data/repository/doctor_profile_repository_impl.dart';
import 'package:mawidak/features/doctor_profile/domain/repository/doctor_profile_repository.dart';
import 'package:mawidak/features/doctor_profile/domain/use_case/doctor_profile_use_case.dart';
import 'package:mawidak/features/doctor_ratings/data/repository/doctor_ratings_repository_impl.dart';
import 'package:mawidak/features/doctor_ratings/domain/repository/doctor_ratings_repository.dart';
import 'package:mawidak/features/doctor_ratings/domain/use_case/doctor_ratings_use_case.dart';
import 'package:mawidak/features/doctors_of_speciality/data/repository/doctors_of_speciality_repository_impl.dart';
import 'package:mawidak/features/doctors_of_speciality/domain/repository/doctors_of_speciality_repository.dart';
import 'package:mawidak/features/doctors_of_speciality/domain/use_case/doctors_of_speciality_use_case.dart';
import 'package:mawidak/features/edit_personal_info/data/repository/edit_personal_info_repository_impl.dart';
import 'package:mawidak/features/edit_personal_info/domain/repository/edit_personal_info_repository.dart';
import 'package:mawidak/features/edit_personal_info/domain/use_case/edit_personal_info_use_case.dart';
import 'package:mawidak/features/forget_password/data/repository/forget_password_repository_impl.dart';
import 'package:mawidak/features/forget_password/domain/repository/forget_password_repo.dart';
import 'package:mawidak/features/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:mawidak/features/home/data/repository/home_patient_repository_impl.dart';
import 'package:mawidak/features/home/domain/repository/home_patient_repository.dart';
import 'package:mawidak/features/home/domain/use_case/home_patient_use_case.dart';
import 'package:mawidak/features/login/data/repository/login_repository_impl.dart';
import 'package:mawidak/features/login/domain/repository/login_repo.dart';
import 'package:mawidak/features/login/domain/use_case/login_use_case.dart';
import 'package:mawidak/features/lookups/lookup_repository.dart';
import 'package:mawidak/features/lookups/lookup_repository_impl.dart';
import 'package:mawidak/features/lookups/lookup_use_case.dart';
import 'package:mawidak/features/more/domain/logout_repository.dart';
import 'package:mawidak/features/more/data/logout_repository_impl.dart';
import 'package:mawidak/features/more/domain/logout_use_case.dart';
import 'package:mawidak/features/notification/data/repository/notification_repository_impl.dart';
import 'package:mawidak/features/notification/domain/repository/notification_repository.dart';
import 'package:mawidak/features/notification/domain/use_case/notification_use_case.dart';
import 'package:mawidak/features/patient_favourite/data/domain/repository/favourite_repository.dart';
import 'package:mawidak/features/patient_favourite/data/domain/use_case/favourite_use_case.dart';
import 'package:mawidak/features/patient_favourite/data/repository/favourite_repository_iml.dart';
import 'package:mawidak/features/register/data/repository/register_repository_impl.dart';
import 'package:mawidak/features/register/domain/repository/register_repo.dart';
import 'package:mawidak/features/register/domain/use_case/register_use_case.dart';
import 'package:mawidak/features/search/data/repository/search_respository_impl.dart';
import 'package:mawidak/features/search/domain/domain/use_case/search_use_case.dart';
import 'package:mawidak/features/search/domain/repository/search_respository.dart';
import 'package:mawidak/features/survey/data/repository/survey_repository_impl.dart';
import 'package:mawidak/features/survey/domain/repository/survey_repo.dart';
import 'package:mawidak/features/survey/domain/use_case/survey_use_case.dart';
import 'package:mawidak/features/verify_otp/data/repository/verify_otp_repository_impl.dart';
import 'package:mawidak/features/verify_otp/domain/repository/verify_otp_repo.dart';
import 'package:mawidak/features/verify_otp/domain/use_case/verify_otp_use_case.dart';


final GetIt getIt = GetIt.instance;
// final SharedPreferencesService prefsService = getIt<SharedPreferencesService>();

class AppDependencies {
  Future<void> clearSecureStorageOnFreshInstall() async {
    // Check if app was already launched before
    bool isFirstLaunch = SharedPreferenceService()
        .getBool(SharPrefConstants.isFirstTimeToOpenAppKey, defaultValue: true);

    AppLog.printValueAndTitle('isFirstOpen', isFirstLaunch);
    if (isFirstLaunch) {
      // Fresh install detected, clear secure storage
      await SecureStorageService().clear();

      // Mark that app has launched before
      await SharedPreferenceService()
          .setBool(SharPrefConstants.isFirstTimeToOpenAppKey, false);
    }
  }

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await SharedPreferenceService().init();
    await clearSecureStorageOnFreshInstall();
    // Core
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

    getIt.registerSingleton(DioClient());
    // Future.delayed(Duration(seconds: 3,), () {
    //     FlutterNativeSplash.remove();
    //   },
    // );
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(
      registerRepository: getIt(),));
    getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
      loginRepository: getIt(),));
    getIt.registerLazySingleton<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(
      forgetPasswordRepository: getIt(),));
    getIt.registerLazySingleton<ConfirmPasswordUseCase>(() => ConfirmPasswordUseCase(
      confirmPasswordRepository: getIt(),));

    getIt.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(
      verifyOtpRepository: getIt(),));

    getIt.registerLazySingleton<SurveyUseCase>(() => SurveyUseCase(
      surveyRepository: getIt(),));

    getIt.registerLazySingleton<HomePatientUseCase>(() => HomePatientUseCase(
      homePatientRepository: getIt(),));

    getIt.registerLazySingleton<SearchUseCase>(() => SearchUseCase(
      searchRepository: getIt(),));

    getIt.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(
      logoutRepository: getIt(),));

    getIt.registerLazySingleton<LookupUseCase>(() => LookupUseCase(
      lookupRepository: getIt(),));

    getIt.registerLazySingleton<DoctorRatingsUseCase>(() => DoctorRatingsUseCase(
      doctorRatingsRepository: getIt(),));
    getIt.registerLazySingleton<DoctorProfileUseCase>(() => DoctorProfileUseCase(
      doctorProfileRepository: getIt(),));

    getIt.registerLazySingleton<ChangePasswordUseCase>(() => ChangePasswordUseCase(
      changePasswordRepository: getIt(),));
    getIt.registerLazySingleton<EditPersonalInfoUseCase>(() => EditPersonalInfoUseCase(
      editPersonalInfoRepository: getIt(),));

getIt.registerLazySingleton<NotificationUseCase>(() => NotificationUseCase(
      notificationRepository: getIt(),));

    getIt.registerLazySingleton<AppointmentBookingUseCase>(() => AppointmentBookingUseCase(
      appointmentBookingRepository: getIt(),));

    getIt.registerLazySingleton<ContactUsUseCase>(() => ContactUsUseCase(
      contactUsRepository: getIt(),));
    getIt.registerLazySingleton<DoctorsOfSpecialityUseCase>(() => DoctorsOfSpecialityUseCase(
      doctorsOfSpecialityRepository: getIt(),));

    getIt.registerLazySingleton<FavouriteUseCase>(() => FavouriteUseCase(
      favouriteRepository: getIt(),));


    // Repositories
    getIt.registerLazySingleton<RegisterRepository>(
            () => RegisterRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));
    getIt.registerLazySingleton<LoginRepository>(
            () => LoginRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));
    getIt.registerLazySingleton<ForgetPasswordRepository>(
            () => ForgetPasswordRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));
    getIt.registerLazySingleton<ConfirmPasswordRepository>(
            () => ConfirmPasswordRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));
    getIt.registerLazySingleton<VerifyOtpRepository>(
            () => VerifyOtpRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<SurveyRepository>(
            () => SurveyRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<HomePatientRepository>(
            () => HomePatientRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));
    getIt.registerLazySingleton<SearchRepository>(
            () => SearchRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<LogoutRepository>(
            () => LogoutRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<LookupRepository>(
            () => LookupRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<DoctorRatingsRepository>(
            () => DoctorRatingsRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<DoctorProfileRepository>(
            () => DoctorProfileRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<ChangePasswordRepository>(
            () => ChangePasswordRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));
    getIt.registerLazySingleton<EditPersonalInfoRepository>(
            () => EditPersonalInfoRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<NotificationRepository>(
            () => NotificationRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<AppointmentBookingRepository>(
            () => AppointmentBookingRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<ContactUsRepository>(
            () => ContactUsRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<DoctorsOfSpecialityRepository>(
            () => DoctorsOfSpecialityRepositoryImpl(networkInfo: getIt(), remoteData: getIt()));

    getIt.registerLazySingleton<FavouriteRepository>(
            () => FavouriteRepositoryIml(networkInfo: getIt(), remoteData: getIt()));


    await DioClient().updateHeader();

    // getIt.registerLazySingleton<LocalData>(() => LocalData(getIt()));

    // External
    // final sharedPreferences = await SharedPreferences.getInstance();
    // getIt.registerSingleton<SharedPreferencesService>(SharedPreferencesService(sharedPreferences));
    getIt.registerLazySingleton(
        () => InternetConnectionChecker.createInstance());
  }
}
