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
  static const String searchForDoctor = 'home/filter-search-patient?';
  // static const String searchForPatient = 'home/doctors/search';
  static const String searchMap = 'home/nearby-clinics';
  static const String filter = 'home/filter-search';
  static const String cities = 'cities';
  static const String doctorRatingsById = 'ratings/';
  static const String doctorCommentsById = 'ratings/comments/';
  static const String doctorDetails = 'user/doctor-details/';
  static const String notification = 'notification';
  static const String notificationById = 'notification/show/';
  static const String bookAppointment = 'appointment/store';
  static const String contactUs = 'notification/create-ticket';
  static const String doctorsBySpeciality = 'home/doctors-by-speciality/';
  static const String doctorProfileStatus = 'user/doctor-profile-status';
  static const String detailsHomeDoctor = 'home/details-home-doctor';
  static const String addToFavourite = 'user/favorite-status';
  static const String updatePhoto = 'user/update-photo';
  static const String favoriteDoctorList = 'user/favorites';
  static const String doctorPatients = 'user/doctor-patients';
  
  static const String basicInformation = 'user/patient-personal-info/';
  static const String medicalHistory = 'user/medical-history/';
  static const String diagnosis = 'user/diagnosis/';
  static const String addDiagnosis = 'user/add-diagnosis';
  static const String updateDiagnosis = 'user/update-diagnosis/';
  static const String doctorAppointments = 'appointment/doctor';
  static const String patientAppointments = 'appointment/patient';
  static String doctorAppointmentCancel(int doctorId) => 'appointment/$doctorId/cancel';
  static String doctorAppointmentAccept(int doctorId) => 'appointment/$doctorId/change-status';
  static const String doctorPendingAppointments = 'appointment/doctor/pending';

  // _________ drugs
  static const String getDrugs = 'user/drugs/';
  static const String addDrug = 'user/add-drug';
  static const String updateDrug = 'user/update-drug/';
  static const String deleteDrug = 'user/delete-drug/';

  // _____________________ Notes
  static const String getNotes = 'user/doctor-notes/';
  static const String addNote = 'user/doctor-note';
  static const String updateNote = 'user/doctor-note/';
  static const String deleteNote = 'user/doctor-note/';

  // _____________________ Consultation
  static const String getConsultations = 'user/consultations/';
  static const String addConsultation = 'user/add-consultation';
}
