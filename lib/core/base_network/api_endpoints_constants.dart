class ApiEndpointsConstants {
  static const String baseImageUrl = 'https://mawidk.com/storage/';
  static const String baseUrl = 'https://mawidk.com/api/v1/';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String forgetPassword = 'auth/forgot-password/send-otp';
  static const String confirmPassword = 'auth/forgot-password/reset';
  static const String changePassword = 'auth/change-password';
  static const String editProfile = 'user/update';
  static const String getProfile = 'user/profile';
  static const String refreshToken = 'auth/refresh-token';
  static const String logout = 'auth/logout';
  static const String deleteAccount = 'auth/delete-account';
  static const String verifyOtp = 'auth/forgot-password/verify-otp';
  static const String verifyOtpLogin = 'auth/verify-otp';
  static const String userProfile = 'user/profile';
  static const String healthChecks = 'health-checks';
  static const String getVersion = 'versions';
  static const String categories = 'categories';
  static const String survey = 'survey';
  static const String surveyAnswer = 'survey/answer';
  static const String addSurveyPatient = 'user/patient-profiles';
  static const String addSurveyDoctor = 'user/doctor-profiles';

  // patient
  // static const String getDoctorsForPatient = 'home/doctors-by-disease';
  static const String getDoctorsForPatient = 'home/doctors-by-rating';
  static const String banners = 'banners';
  // static const String searchForPatient = 'home/doctors/search?search=';
  static const String searchForPatient = 'home/doctors/search?';
  // static const String searchForPatient = 'home/doctors/search';
  static const String searchMap = 'home/nearby-clinics';
  static const String filter = 'home/filter-search';
  static const String cities = 'cities';
  static const String doctorRatingsById = 'ratings/';
  static const String doctorDetails = 'user/doctor-details/';
  static const String notification = 'notification';
  static const String notificationById = 'notification/show/';
  static const String bookAppointment = 'appointment/store';
  static const String doctorsBySpeciality = 'home/doctors-by-speciality/';
  static const String doctorProfileStatus = 'user/doctor-profile-status';
  static const String detailsHomeDoctor = 'home/details-home-doctor';
  static const String addToFavourite = 'user/favorite-status';
  static const String updatePhoto = 'user/update-photo';
  static const String favoriteDoctorList = 'user/favorites';
}
