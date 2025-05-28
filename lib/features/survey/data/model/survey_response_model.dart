class SurveyModel {
  Model? model;

  SurveyModel({this.model});

  SurveyModel fromMap(Map<String, dynamic> json) {
    model = json['model'] != null ?  Model().fromMap(json['model']) : null;
    return SurveyModel(model: model);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.model != null) {
      data['model'] = this.model!.toMap();
    }
    return data;
  }
}

class Model {
  int? id;
  String? title;
  String? type;
  int? version;
  int? isActive;
  List<ScreenModel>? screens;

  Model(
      {this.id,
        this.title,
        this.type,
        this.version,
        this.isActive,
        this.screens});

  Model fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    version = json['version'];
    isActive = json['is_active'];
    if (json['screens'] != null) {
      screens = <ScreenModel>[];
      json['screens'].forEach((v) {
        screens!.add(new ScreenModel().fromMap(v));
      });
    }
    return Model(title: title,id: id,type: type,isActive: isActive,screens: screens,
    version: version);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['version'] = this.version;
    data['is_active'] = this.isActive;
    if (this.screens != null) {
      data['screens'] = this.screens!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class ScreenModel {
  int? id;
  int? screenNumber;
  String? title;
  String? subtitle;
  List<Question>? questions;

  ScreenModel(
      {this.id, this.screenNumber, this.title, this.subtitle, this.questions});

  ScreenModel fromMap(Map<String, dynamic> json) {
    id = json['id'];
    screenNumber = json['screen_number'];
    title = json['title'];
    subtitle = json['subtitle'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add( Question().fromMap(v));
      });
    }
    return ScreenModel(id: id,title: title,questions: questions,screenNumber: screenNumber,
    subtitle: subtitle);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['screen_number'] = this.screenNumber;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Question {
  int? id;
  String? questionText;
  String? hint;
  String? type;
  bool? isTrue;
  bool? showCheckBoc;
  bool? isRequired;
  int? order;
  dynamic answer;
  List<Option>? options;
  List<LogicRules>? logicRules;

  Question(
      {this.id,
        this.questionText,
        this.type,
        this.isRequired,
        this.order,
        this.hint,
        this.answer,
        this.isTrue,
        this.showCheckBoc,
        this.logicRules,
        this.options});

  Question fromMap(Map<String, dynamic> json) {
    id = json['id'];
    questionText = json['question_text'];
    type = json['type'];
    isRequired = json['is_required'];
    isTrue = json['isTrue'];
    showCheckBoc = json['showCheckBoc'];
    order = json['order'];
    answer = json['answer'];
    if (json['options'] != null) {
      options = <Option>[];
      json['options'].forEach((v) {
        options!.add(Option().fromMap(v));
      });
    }
    if (json['logic_rules'] != null && json['logic_rules'] is List) {
      logicRules = <LogicRules>[];
      json['logic_rules'].forEach((v) {
        logicRules!.add(LogicRules().fromMap(v));
      });
    }
    return Question(id:id,order: order,type: type,options: options,answer: answer,isRequired: isRequired,
    questionText: questionText);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_text'] = this.questionText;
    data['type'] = this.type;
    data['isTrue'] = this.isTrue;
    data['showCheckBoc'] = this.showCheckBoc;
    data['answer'] = this.answer;
    data['is_required'] = this.isRequired;
    data['order'] = order;
    if (this.options != null) {
      data['options'] = options!.map((v) => v.toMap()).toList();
    }
    if (this.logicRules != null && logicRules is List) {
      data['logic_rules'] = logicRules!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Option {
  int? id;
  String? optionText;
  String? optionTextEn;
  String? image;
  dynamic value;
  int? order;

  Option({this.id, this.optionText, this.optionTextEn,this.value, this.order,this.image});

  Option fromMap(Map<String, dynamic> json) {
    id = json['id'];
    optionText = json['option_text'];
    value = json['value'];
    order = json['order'];
    optionTextEn = json['optionTextEn'];
    return Option(id: id,optionText: optionText,order: order,value: value,optionTextEn:optionTextEn);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['option_text'] = this.optionText;
    data['value'] = this.value;
    data['order'] = this.order;
    data['optionTextEn'] = this.optionTextEn;
    return data;
  }
}


class LogicRules {
  String? questionId;
  String? operator;
  String? value;
  String? action;

  LogicRules({this.questionId, this.operator, this.value, this.action});

  LogicRules fromMap(Map<String, dynamic> json) {
    questionId = json['question_id'];
    operator = json['operator'];
    value = json['value'];
    action = json['action'];
    return LogicRules(questionId: questionId,operator: operator,action: action,value: value);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['operator'] = operator;
    data['value'] = value;
    data['action'] = action;
    return data;
  }
}










class PageModel {
   int id;
   String title;
   String subTitle;
   List<QuestionModel> questions;

  PageModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.questions,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['sub_title'],
      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sub_title": subTitle,
    "questions": questions.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() { 
    return 'PageModel(id: $id, title: $title, subTitle: $subTitle, questions: $questions)';
  }
}

class QuestionModel {
   int id;
   String question;
   String type;List<String> options;
  dynamic answer;

  QuestionModel({
    required this.id,
    required this.question,
    required this.type,
    this.options = const [],
    this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      type: json['type'],
      options: List<String>.from(json['options'] ?? []),
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "type": type,
    "options": options,
    "answer": answer,
  };

  @override
  String toString() {
    return 'QuestionModel(id: $id, question: $question, type: $type, options: $options, answer: $answer)';
  }
}



























