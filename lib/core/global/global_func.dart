import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/global_widgets.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/core/services/localization/app_localization.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/home/data/model/doctor_profile_status_response_model.dart';
import 'package:mawidak/features/home/data/repository/home_patient_repository_impl.dart';
import 'package:mawidak/features/home/domain/use_case/home_patient_use_case.dart';
import 'package:mawidak/features/home/presentation/ui/page/home_screen_doctor.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';

final GlobalKey<NavigatorState> dialogNavigatorKey =
    GlobalKey<NavigatorState>();

loadDialog() {
  showDialog(
    useRootNavigator: false,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    context: Get.context!,
    builder: (_) {
      return PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvokedWithResult: (didPop, result) {
          // if (!didPop) {
          //   Get.context!.pop(); // Return value
          // }
        },
        child: Center(
          child: customLoader(),
        ),
      );
    },
  );
}

void hideLoadingDialog({bool isRefresh = false}) {
  if (Navigator.of(
    Get.context!,
  ).canPop()) {
    Navigator.of(
      Get.context!,
    ).pop(isRefresh);
  }
}


extension MapIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    int index = 0;
    return map((element) => f(index++, element));
  }
}

dynamic createFadeRoute({required Widget widget}) {
  return CustomTransitionPage(
    child: widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

dynamic createRoute({required Widget widget}) {
  return CustomTransitionPage(
    child: widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeAnimation = Tween(begin: 0.0, end: 3.0).animate(animation);
      var slideAnimation =
          Tween<Offset>(begin: const Offset(3.0, 0.0), end: Offset.zero)
              .animate(animation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },
  );
}

dynamic createNavigation({required Widget widget}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeAnimation = Tween(begin: 0.0, end: 3.0).animate(animation);
      var slideAnimation =
          Tween<Offset>(begin: const Offset(3.0, 0.0), end: Offset.zero)
              .animate(animation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },
  );
}


String getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  final i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

class NoLeadingSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the text starts with a space and remove it
    if (newValue.text.startsWith(' ')) {
      return oldValue; // Reject the new value if it starts with space
    }
    return newValue;
  }
}

bool isDarkContext(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

bool get isDark {
  if (Get.context == null) {
    return SharedPreferenceService().getBool(SharPrefConstants.isDarkThemeKey);
  }
  return Theme.of(Get.context!).brightness == Brightness.dark;
}

// void setSystemNavigationBarColor({bool? isDarkMode}) {
//   isDarkMode = isDarkMode ??
//       SharedPreferenceService().getBool(SharPrefConstants.isDarkThemeKey);
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     systemNavigationBarColor: isDarkMode
//         ? AppColors.darkBottomBarColor
//         : AppColors.backgroundColor, // Change color
//     systemNavigationBarIconBrightness:
//         isDarkMode ? Brightness.light : Brightness.dark, // Change icon color
//   ));
// }

bool isBase64Image(String data) {
  final base64Regex =
      RegExp(r'^data:image\/(png|jpeg|jpg|gif|webp);base64,([A-Za-z0-9+/=]+)$');
  return base64Regex.hasMatch(data);
}

String darkMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [{"color": "#414c5d"}]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#ffffff"}]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [{"color": "#1f1f1f"}]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [{"color": "#5e6673"}]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [{"color": "#2a2a2a"}]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [{"color": "#5e6673"}]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#5e6673"}]
  },
  {
    "featureType": "transit",
    "stylers": [{"visibility": "off"}]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [{"color": "#0b1e35"}]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#4e6d70"}]
  }
]
''';

String convertMapToHtml(Map<String, dynamic> data) {
  StringBuffer buffer = StringBuffer();
  buffer.writeln('<div style="direction: rtl;">');

  data.forEach((key, value) {
    buffer.writeln('$key: $value<br />');
  });

  buffer.writeln('</div>');
  return buffer.toString();
}

List<String> arabicDays = [
  'الأحد',
  'الاثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
];


List<PageModel> patientStaticSurvey = [
  PageModel(
    id: 0,
    title: "معلومات عامة",
    subTitle: "من فضلك قم باستكمال البيانات",
    questions: [
      QuestionModel(
        id: 1,
        question: "النوع",
        type: "single_choice_grid",
        options: ["ذكر", "انثي"],
      ),
      QuestionModel(id: 2, question: "العمر", type: "number"),
      QuestionModel(id: 3, question: "الوزن", type: "number"),
      QuestionModel(id: 4, question: "الطول", type: "number"),
    ],
  ),
  PageModel(
    id: 1,
    title: "كيف تصف حالتك الصحية العامة؟",
    subTitle: "اختر من الاختيارات التالية",
    questions: [
      QuestionModel(
        id: 1,
        question: "",
        type: "radio_button",
        options: ["ممتازة", "جيدة","متوسطة","ضعيفة"],
      ),
    ],
  ),
  PageModel(
    id: 2,
    title: "الامراض المزمنة",
    subTitle: "هل تعاني من اي امراض مزمنة ؟",
    questions: [
      QuestionModel(
        id: 1,
        question: "",
        type: "multi_select",
        options: ["السكري", "الضغط","الربو","امراض القلب","لا شئ مما سبق"],
      ),
    ],
  ),
  PageModel(
    id: 3,
    title: "معلومات صحية اساسية",
    subTitle: "من فضلك قم باستكمال البيانات",
    questions: [
      QuestionModel(
        question:"هل تستخدم اي ادوية بشكل يومي ؟",
        id: 0,
        type: "tapped_text_field",
      ),
      QuestionModel(
        question:"هل لديك حساسية من ادوية او اطعمة ؟",
        id: 1,
        type: "tapped_text_field",
      ),
      QuestionModel(
        question:"هل عانيت من اي نوع من الامراض المعدية في الاشهر الستة الماضية ؟",
        id: 2,
        type: "tapped_text_field",
      ),
    ],
  ),
  PageModel(
    id: 4,
    title: "هل تمارس الرياضة بانتظام ؟",
    subTitle: "اختر من الاختيارات التالية",
    questions: [
      QuestionModel(
        id: 1,
        question: "",
        type: "radio_button",
        options: ["يوميا", "3 الى 5 مرات اسبوعيا","مرة الى مرتين اسبوعيا","لا امارس"],
      ),
    ],
  ),
  PageModel(
    id: 5,
    title: "نمط حياتك",
    subTitle: "من فضلك قم باستكمال البيانات",
    questions: [
      QuestionModel(
        id: 0,
        question: "هل تدخن",
        type: "single_select",
        options: ["نعم", "لا","كنت مدخن",],
      ),
      QuestionModel(
        id: 1,
        question: "هل تعاني من  مشاكل في النوم مثل الارق ؟",
        type: "single_select",
        options: ["نعم", "لا"],
      ),
    ],
  ),
  PageModel(
    id: 6,
    title: "التاريخ الطبي و العائلي",
    subTitle: "من فضلك قم باستكمال البيانات",
    questions: [
      QuestionModel(
        question:"هل لديك تاريخ لامراض وراثية في عائلتك ؟",
        id: 0,
        type: "tapped_text_field",
      ),
      QuestionModel(
        question:"هل عانيت من مشاكل صحية حادة في السنوات الاخيرة ؟",
        id: 1,
        type: "tapped_text_field",
      ),
      QuestionModel(
        question:"هل اجريت فحوصات طبيه دورية خلال السنة الماضية ",
        id: 2,
        type: "tapped_text_field",
      ),
    ],
  ),
  PageModel(
    id: 7,
    title: "تفضيلات عامة",
    subTitle: "من فضلك قم باستكمال البيانات",
    questions: [
      QuestionModel(
        id: 0,
        question: "هل تفضل الاستشارة الطبية عن بعد ام بالحضور الى العيادة ؟",
        type: "single_select",
        options: ["عن بعد", "حضوريا","لا فرق",],
      ),
      QuestionModel(
        id: 1,
        question: "هل تفضل استشارة طبيب من نفس منطقتك ام من اي منطقة اخرى ؟",
        type: "single_select",
        options: ["نفس المنطقة", "اي منطقة"],
      ),
      QuestionModel(
        id: 2,
        question: "هل ترغب في تلقي اشعارات طبية من التطبيق ؟",
        type: "single_select",
        options: ["نعم", "لا"],
      ),
      QuestionModel(
        id: 3,
        question: "هل ترغب في متابعه صحية دورية عبر التطبيق ؟",
        type: "single_select",
        options: ["نعم", "لا"],
      ),
    ],
  ),
];

final demoSurveyDoctor = [
  PageModel(
    id: 0,
    title: "معلوماتك الأساسية",
    subTitle: "هذه المعلومات مطلوبة للمتابعة",
    questions: [
      QuestionModel(
        id: 1,
        question: "النوع",
        type: "single_choice",
        options: ["ذكر", "انثي"],
      ),
      QuestionModel(
        id: 1,
        question: "اختر تخصصك",
        type: "multi_select",
        options: ["باطنة","طب عام","قلب","اطفال","جراحة","انف واذن"],
      ),
    ],
  ),
  PageModel(
    id: 1,
    title: "المعلومات المهنية ",
    subTitle: "من فضلك اجب على الاسئلة التالية ",
    questions: [
      QuestionModel(
        id: 1,
        question: "ما عدد سنوات الخبرة الطبية لديك ؟",
        type: "radio_button",
        options: ["اقل من سنة", "١-٣ سنوات","من ٤-٦ سنوات","اكثر من ٥ سنوات"],
      ),
      QuestionModel(id: 2, question: "أدخل رقم الترخيص الطبي الخاص بك", type: "number"),
    ],
  ),
];



List<Option> allDiseases = [
  Option(id: 1, optionText: "ارتفاع ضغط الدم", optionTextEn: "Hypertension"),
  Option(id: 2, optionText: "مرض السكري", optionTextEn: "Diabetes"),
  Option(id: 3, optionText: "السمنة", optionTextEn: "Obesity"),
  Option(id: 4, optionText: "الربو", optionTextEn: "Asthma"),
  Option(id: 5, optionText: "أمراض القلب الوقائية", optionTextEn: "Preventive Heart Diseases"),
  Option(id: 6, optionText: "هشاشة العظام", optionTextEn: "Osteoporosis"),
  Option(id: 7, optionText: "أمراض الغدة الدرقية المزمنة", optionTextEn: "Chronic Thyroid Diseases"),
  Option(id: 8, optionText: "اضطرابات الدهون", optionTextEn: "Lipid Disorders"),
  Option(id: 9, optionText: "مرض الشريان التاجي", optionTextEn: "Coronary Artery Disease"),
  Option(id: 10, optionText: "قصور القلب المزمن", optionTextEn: "Chronic Heart Failure"),
  Option(id: 11, optionText: "اضطرابات النظم القلبي", optionTextEn: "Cardiac Arrhythmias"),
  Option(id: 12, optionText: "ارتفاع ضغط الدم الرئوي", optionTextEn: "Pulmonary Hypertension"),
  Option(id: 13, optionText: "أمراض صمامات القلب", optionTextEn: "Valvular Heart Diseases"),
  Option(id: 14, optionText: "الصرع", optionTextEn: "Epilepsy"),
  Option(id: 15, optionText: "الشلل الرعاش", optionTextEn: "Parkinson’s Disease"),
  Option(id: 16, optionText: "التصلب المتعدد", optionTextEn: "Multiple Sclerosis"),
  Option(id: 17, optionText: "الصداع النصفي المزمن", optionTextEn: "Chronic Migraine"),
  Option(id: 18, optionText: "اعتلال الأعصاب الطرفية", optionTextEn: "Peripheral Neuropathy"),
  Option(id: 19, optionText: "مرض ألزهايمر", optionTextEn: "Alzheimer’s Disease"),
  Option(id: 20, optionText: "الشلل الدماغي", optionTextEn: "Cerebral Palsy"),
  Option(id: 21, optionText: "اعتلال الشبكية السكري", optionTextEn: "Diabetic Retinopathy"),
  Option(id: 22, optionText: "الجلوكوما", optionTextEn: "Glaucoma"),
  Option(id: 23, optionText: "التنكس البقعي المرتبط بالعمر", optionTextEn: "Age-Related Macular Degeneration"),
  Option(id: 24, optionText: "جفاف العين المزمن", optionTextEn: "Chronic Dry Eye"),
  Option(id: 25, optionText: "القرنية المخروطية", optionTextEn: "Keratoconus"),
  Option(id: 26, optionText: "المياه البيضاء", optionTextEn: "Cataracts"),
  Option(id: 27, optionText: "التهاب المفاصل الروماتويدي", optionTextEn: "Rheumatoid Arthritis"),
  Option(id: 28, optionText: "الفصال العظمي", optionTextEn: "Osteoarthritis"),
  Option(id: 29, optionText: "تشوهات العظام الوراثية", optionTextEn: "Congenital Bone Deformities"),
  Option(id: 30, optionText: "آلام أسفل الظهر المزمنة", optionTextEn: "Chronic Low Back Pain"),
  Option(id: 31, optionText: "الانزلاق الغضروفي", optionTextEn: "Herniated Disc"),
  Option(id: 32, optionText: "قصور الغدة الدرقية", optionTextEn: "Hypothyroidism"),
  Option(id: 33, optionText: "فرط نشاط الغدة الدرقية", optionTextEn: "Hyperthyroidism"),
  Option(id: 34, optionText: "أمراض الغدة الكظرية", optionTextEn: "Adrenal Gland Disorders"),
  Option(id: 35, optionText: "أورام الغدة النخامية", optionTextEn: "Pituitary Tumors"),
  Option(id: 36, optionText: "هشاشة العظام بسبب اضطرابات الغدد", optionTextEn: "Osteoporosis Due to Endocrine Disorders"),
  Option(id: 37, optionText: "الأنيميا المنجلية", optionTextEn: "Sickle Cell Anemia"),
  Option(id: 38, optionText: "الثلاسيميا", optionTextEn: "Thalassemia"),
  Option(id: 39, optionText: "الهيموفيليا", optionTextEn: "Hemophilia"),
  Option(id: 40, optionText: "كثرة الحمر الحقيقية", optionTextEn: "Polycythemia Vera"),
  Option(id: 41, optionText: "اضطرابات النزف الوراثية", optionTextEn: "Hereditary Bleeding Disorders"),
  Option(id: 42, optionText: "قرحة المعدة المزمنة", optionTextEn: "Chronic Peptic Ulcer"),
  Option(id: 43, optionText: "التهاب القولون التقرحي", optionTextEn: "Ulcerative Colitis"),
  Option(id: 44, optionText: "متلازمة القولون العصبي", optionTextEn: "Irritable Bowel Syndrome"),
  Option(id: 45, optionText: "مرض كرون", optionTextEn: "Crohn’s Disease"),
  Option(id: 46, optionText: "أمراض الكبد المزمنة", optionTextEn: "Chronic Liver Diseases"),
  Option(id: 47, optionText: "أمراض الكلى المزمنة", optionTextEn: "Chronic Kidney Diseases"),
  Option(id: 48, optionText: "الانسداد الرئوي المزمن", optionTextEn: "Chronic Obstructive Pulmonary Disease"),
  Option(id: 49, optionText: "توسع الشعب الهوائية", optionTextEn: "Bronchiectasis"),
  Option(id: 50, optionText: "التليف الرئوي", optionTextEn: "Pulmonary Fibrosis"),
  Option(id: 51, optionText: "توقف التنفس أثناء النوم", optionTextEn: "Sleep Apnea"),
  Option(id: 52, optionText: "التهابات الجيوب الأنفية المزمنة", optionTextEn: "Chronic Sinusitis"),
  Option(id: 53, optionText: "فقدان السمع التدريجي", optionTextEn: "Progressive Hearing Loss"),
  Option(id: 54, optionText: "الطنين المزمن", optionTextEn: "Chronic Tinnitus"),
  Option(id: 55, optionText: "مشاكل التوازن المرتبطة بالأذن الداخلية", optionTextEn: "Inner Ear Balance Disorders"),
  Option(id: 56, optionText: "أمراض دواعم الأسنان", optionTextEn: "Periodontal Diseases"),
  Option(id: 57, optionText: "تسوس الأسنان المزمن", optionTextEn: "Chronic Dental Caries"),
  Option(id: 58, optionText: "التهابات جذور الأسنان المزمنة", optionTextEn: "Chronic Root Infections"),
  Option(id: 59, optionText: "تآكل الأسنان بسبب الطحن", optionTextEn: "Tooth Wear Due to Grinding"),
  Option(id: 60, optionText: "فقدان الأسنان", optionTextEn: "Tooth Loss"),
  Option(id: 61, optionText: "التليف الكيسي", optionTextEn: "Cystic Fibrosis"),
  Option(id: 62, optionText: "أمراض القلب الخلقية", optionTextEn: "Congenital Heart Diseases"),
  Option(id: 63, optionText: "الأمراض العصبية الوراثية", optionTextEn: "Hereditary Neurological Diseases"),
  Option(id: 64, optionText: "ترميم ما بعد الحروق", optionTextEn: "Post-Burn Reconstruction"),
  Option(id: 65, optionText: "ترميم الثدي بعد استئصال السرطان", optionTextEn: "Breast Reconstruction Post-Cancer"),
  Option(id: 66, optionText: "التشوهات الخلقية", optionTextEn: "Congenital Deformities"),
  Option(id: 67, optionText: "قرح الفراش المزمنة", optionTextEn: "Chronic Pressure Ulcers"),
  Option(id: 68, optionText: "بطانة الرحم المهاجرة", optionTextEn: "Endometriosis"),
  Option(id: 69, optionText: "متلازمة تكيس المبايض", optionTextEn: "Polycystic Ovary Syndrome"),
  Option(id: 70, optionText: "الأورام الليفية الرحمية", optionTextEn: "Uterine Fibroids"),
  Option(id: 71, optionText: "عقم النساء", optionTextEn: "Female Infertility"),
  Option(id: 72, optionText: "اضطرابات الطمث المزمنة", optionTextEn: "Chronic Menstrual Disorders"),
  Option(id: 73, optionText: "السرطانات بأنواعها", optionTextEn: "Various Cancers"),
  Option(id: 74, optionText: "اللوكيميا", optionTextEn: "Leukemia"),
  Option(id: 75, optionText: "اللمفوما", optionTextEn: "Lymphoma"),
  Option(id: 76, optionText: "الاكتئاب المزمن", optionTextEn: "Chronic Depression"),
  Option(id: 77, optionText: "اضطراب ثنائي القطب", optionTextEn: "Bipolar Disorder"),
  Option(id: 78, optionText: "الفصام", optionTextEn: "Schizophrenia"),
  Option(id: 79, optionText: "اضطرابات القلق المزمنة", optionTextEn: "Chronic Anxiety Disorders"),
  Option(id: 80, optionText: "اضطرابات الوسواس القهري", optionTextEn: "Obsessive-Compulsive Disorder"),
  Option(id: 81, optionText: "الصدفية", optionTextEn: "Psoriasis"),
  Option(id: 82, optionText: "الأكزيما المزمنة", optionTextEn: "Chronic Eczema"),
  Option(id: 83, optionText: "حب الشباب المستمر", optionTextEn: "Persistent Acne"),
  Option(id: 84, optionText: "البهاق", optionTextEn: "Vitiligo"),
  Option(id: 85, optionText: "الثعلبة", optionTextEn: "Alopecia"),
  Option(id: 86, optionText: "التهاب الجلد الدهني", optionTextEn: "Seborrheic Dermatitis"),
  Option(id: 87, optionText: "أورام المخ", optionTextEn: "Brain Tumors"),
  Option(id: 88, optionText: "الانزلاق الغضروفي العنقي والقطني", optionTextEn: "Cervical and Lumbar Herniated Disc"),
  Option(id: 89, optionText: "تمدد الأوعية الدموية الدماغية", optionTextEn: "Cerebral Aneurysm"),
  Option(id: 90, optionText: "استسقاء الرأس المزمن", optionTextEn: "Chronic Hydrocephalus"),
];


List<Option> specializations = [
  Option(id: 1, optionText: "طب الأسرة والمجتمع", optionTextEn: "Family and Community Medicine"
  ,image:AppSvgIcons.one),
  Option(id: 2, optionText: "أمراض القلب", optionTextEn: "Cardiology",image:AppSvgIcons.two),
  Option(id: 3, optionText: "طب الأعصاب", optionTextEn: "Neurology",image:AppSvgIcons.three),
  Option(id: 4, optionText: "طب العيون", optionTextEn: "Ophthalmology",image:AppSvgIcons.four),
  Option(id: 5, optionText: "جراحة العظام", optionTextEn: "Orthopedic Surgery",image:AppSvgIcons.five),
  Option(id: 6, optionText: "أمراض الغدد الصماء", optionTextEn: "Endocrinology",image:AppSvgIcons.eighteen),
  Option(id: 7, optionText: "أمراض الدم", optionTextEn: "Hematology",image:AppSvgIcons.seven),
  Option(id: 8, optionText: "الأمراض الباطنية", optionTextEn: "Internal Medicine",image:AppSvgIcons.eight),
  Option(id: 9, optionText: "أمراض الصدر", optionTextEn: "Pulmonology",image:AppSvgIcons.nine),
  Option(id: 10, optionText: "الأنف والأذن والحنجرة", optionTextEn: "Otolaryngology (ENT)",image:AppSvgIcons.ten),
  Option(id: 11, optionText: "طب الأسنان", optionTextEn: "Dentistry",image:AppSvgIcons.eleven),
  Option(id: 12, optionText: "طب الأطفال", optionTextEn: "Pediatrics",image:AppSvgIcons.twelve),
  Option(id: 13, optionText: "جراحة التجميل والترميم", optionTextEn: "Plastic & Reconstructive Surgery"
      ,image:AppSvgIcons.thirteen),
  Option(id: 14, optionText: "أمراض النساء والولادة", optionTextEn: "Obstetrics & Gynecology",image:AppSvgIcons.fourteen),
  Option(id: 15, optionText: "طب الأورام", optionTextEn: "Oncology",image:AppSvgIcons.fifteen),
  Option(id: 16, optionText: "الطب النفسي", optionTextEn: "Psychiatry",image:AppSvgIcons.sixteen),
  Option(id: 17, optionText: "الأمراض الجلدية", optionTextEn: "Dermatology",image:AppSvgIcons.seventeen),
  Option(id: 18, optionText: "جراحة المخ والأعصاب", optionTextEn: "Neurosurgery",image:AppSvgIcons.eighteen),
];


bool isDoctor(){
  return SharedPreferenceService().getBool(SharPrefConstants.isDoctor);
}

bool isArabic(){
  return AppLocalization.isArabic;
}

bool isValidSaudiPhoneNumber(String phoneNumber) {
  final RegExp saudiPhoneRegex = RegExp(r'^(009665|9665|\+9665|05)[0-9]{8}$');
  return saudiPhoneRegex.hasMatch(phoneNumber);
}

Future<bool> getDoctorProfileStatus() async {
  HomePatientUseCase homePatientUseCase =HomePatientUseCase(homePatientRepository:getIt());
  var response = await homePatientUseCase.getDoctorProfileStatus();
  response.fold((l) {
    isProfileDoctorIsActive = false;
    return false;
  },(r) {
   int isActive = (((r).model as DoctorProfileStatusResponseModel).model?.isActive??0);
   if(isActive==1){
     isProfileDoctorIsActive = true;
     return true;
   }else{
     isProfileDoctorIsActive = false;
     return false;
   }
  },);
  return false;
}