class SurveySubmitRequestModel {
  int? type;
  List<SurveySubmitAnswers>? answers;

  SurveySubmitRequestModel({this.type, this.answers});

  SurveySubmitRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['answers'] != null) {
      answers = <SurveySubmitAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(SurveySubmitAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveySubmitAnswers {
  int? questionId;
  String? answer;
  int? optionId;
  List<int>? optionIds;
  List<String>? tags;

  SurveySubmitAnswers({this.questionId, this.answer, this.optionId, this.optionIds,this.tags});

  SurveySubmitAnswers.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    if(json['answer']!=null)answer = json['answer'];
    if(json['option_id']!=null)optionId = json['option_id'];
    if(json['option_ids']!=null)optionIds = json['option_ids'].cast<int>();
    if(json['tags']!=null)tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    if(answer!=null)data['answer'] = answer;
    if(optionId!=null)data['option_id'] = optionId;
    if(optionIds!=null)data['option_ids'] = optionIds;
    if(tags!=null&&tags!.isNotEmpty)data['tags'] = tags;
    return data;
  }
}