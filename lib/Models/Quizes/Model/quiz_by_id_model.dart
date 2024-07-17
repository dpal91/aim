// To parse this JSON data, do
//
//     final quizeByIdModel = quizeByIdModelFromJson(jsonString);

import 'dart:convert';

QuizeByIdModel quizeByIdModelFromJson(String str) =>
    QuizeByIdModel.fromJson(json.decode(str));

String quizeByIdModelToJson(QuizeByIdModel data) => json.encode(data.toJson());

class QuizeByIdModel {
  QuizeByIdModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  final Data data;

  factory QuizeByIdModel.fromJson(Map<String, dynamic> json) => QuizeByIdModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.webinarId,
    required this.creatorId,
    required this.chapterId,
    required this.webinarTitle,
    required this.time,
    required this.attempt,
    required this.passMark,
    required this.certificate,
    required this.status,
    required this.totalMark,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.quizQuestions,
    required this.translations,
  });

  final int id;
  final int webinarId;
  final int creatorId;
  final int chapterId;
  final String webinarTitle;
  final int time;
  final dynamic attempt;
  final int passMark;
  final int certificate;
  final String status;
  final int totalMark;
  final int createdAt;
  final int updatedAt;
  final String title;
  final List<QuizQuestion> quizQuestions;
  final List<QuizzesQuestionsAnswerTranslation> translations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        webinarId: json["webinar_id"],
        creatorId: json["creator_id"],
        chapterId: json["chapter_id"] ?? 0,
        webinarTitle: json["webinar_title"].toString(),
        time: json["time"] ?? 0,
        attempt: json["attempt"],
        passMark: json["pass_mark"],
        certificate: json["certificate"],
        status: json["status"],
        totalMark: json["total_mark"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        title: json["title"],
        quizQuestions: List<QuizQuestion>.from(
            json["quiz_questions"].map((x) => QuizQuestion.fromJson(x))),
        translations: List<QuizzesQuestionsAnswerTranslation>.from(
            json["translations"]
                .map((x) => QuizzesQuestionsAnswerTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "webinar_id": webinarId,
        "creator_id": creatorId,
        "chapter_id": chapterId,
        "webinar_title": webinarTitle,
        "time": time,
        "attempt": attempt,
        "pass_mark": passMark,
        "certificate": certificate,
        "status": status,
        "total_mark": totalMark,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "quiz_questions":
            List<dynamic>.from(quizQuestions.map((x) => x.toJson())),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class QuizQuestion {
  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.creatorId,
    required this.grade,
    required this.type,
    required this.image,
    required this.video,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.correct,
    required this.quizzesQuestionsAnswers,
    required this.translations,
  });

  final int id;
  final int quizId;
  final int creatorId;
  final String grade;
  final String type;
  final dynamic image;
  final dynamic video;
  final int createdAt;
  final dynamic updatedAt;
  final String title;
  final dynamic correct;
  final List<QuizzesQuestionsAnswer> quizzesQuestionsAnswers;
  final List<QuizQuestionTranslation> translations;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        id: json["id"],
        quizId: json["quiz_id"],
        creatorId: json["creator_id"],
        grade: json["grade"],
        type: json["type"],
        image: json["image"],
        video: json["video"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        title: json["title"],
        correct: json["correct"],
        quizzesQuestionsAnswers: List<QuizzesQuestionsAnswer>.from(
            json["quizzes_questions_answers"]
                .map((x) => QuizzesQuestionsAnswer.fromJson(x))),
        translations: List<QuizQuestionTranslation>.from(json["translations"]
            .map((x) => QuizQuestionTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "creator_id": creatorId,
        "grade": grade,
        "type": type,
        "image": image,
        "video": video,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "correct": correct,
        "quizzes_questions_answers":
            List<dynamic>.from(quizzesQuestionsAnswers.map((x) => x.toJson())),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class QuizzesQuestionsAnswer {
  QuizzesQuestionsAnswer({
    required this.id,
    required this.creatorId,
    required this.questionId,
    required this.image,
    required this.correct,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.translations,
  });

  final int id;
  final int creatorId;
  final int questionId;
  final dynamic image;
  final int correct;
  final int createdAt;
  final dynamic updatedAt;
  final String title;
  final List<QuizzesQuestionsAnswerTranslation> translations;

  factory QuizzesQuestionsAnswer.fromJson(Map<String, dynamic> json) =>
      QuizzesQuestionsAnswer(
        id: json["id"],
        creatorId: json["creator_id"],
        questionId: json["question_id"],
        image: json["image"],
        correct: json["correct"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        title: json["title"] ?? "",
        translations: List<QuizzesQuestionsAnswerTranslation>.from(
            json["translations"]
                .map((x) => QuizzesQuestionsAnswerTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creator_id": creatorId,
        "question_id": questionId,
        "image": image,
        "correct": correct,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class QuizzesQuestionsAnswerTranslation {
  QuizzesQuestionsAnswerTranslation({
    required this.id,
    required this.quizzesQuestionsAnswerId,
    required this.locale,
    required this.title,
    required this.quizId,
  });

  final int id;
  final int quizzesQuestionsAnswerId;
  final String locale;
  final String title;
  final int quizId;

  factory QuizzesQuestionsAnswerTranslation.fromJson(
          Map<String, dynamic> json) =>
      QuizzesQuestionsAnswerTranslation(
        id: json["id"],
        quizzesQuestionsAnswerId: json["quizzes_questions_answer_id"] ?? 0,
        locale: json["locale"] ?? "",
        title: json["title"] ?? "",
        quizId: json["quiz_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quizzes_questions_answer_id": quizzesQuestionsAnswerId,
        "locale": locale,
        "title": title,
        "quiz_id": quizId,
      };
}

class QuizQuestionTranslation {
  QuizQuestionTranslation({
    required this.id,
    required this.quizzesQuestionId,
    required this.locale,
    required this.title,
    required this.correct,
  });

  final int id;
  final int quizzesQuestionId;
  final String locale;
  final String title;
  final dynamic correct;

  factory QuizQuestionTranslation.fromJson(Map<String, dynamic> json) =>
      QuizQuestionTranslation(
        id: json["id"],
        quizzesQuestionId: json["quizzes_question_id"],
        locale: json["locale"],
        title: json["title"],
        correct: json["correct"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quizzes_question_id": quizzesQuestionId,
        "locale": locale,
        "title": title,
        "correct": correct,
      };
}
