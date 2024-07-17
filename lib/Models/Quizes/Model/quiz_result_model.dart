// To parse this JSON data, do
//
//     final resultResultModel = resultResultModelFromJson(jsonString);

import 'dart:convert';

ResultResultModel resultResultModelFromJson(String str) =>
    ResultResultModel.fromJson(json.decode(str));

class ResultResultModel {
  ResultResultModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  final QuizData data;

  factory ResultResultModel.fromJson(dynamic json) {
    return ResultResultModel(
      statusCode: json["statusCode"] ?? 0,
      message: json["message"] ?? "",
      data: QuizData.fromJson(json["data"]),
    );
  }
}

class QuizData {
  QuizData({
    required this.pageTitle,
    required this.quizResult,
    required this.userAnswers,
    required this.numberOfAttempt,
    required this.questionsSumGrade,
  });

  final String pageTitle;
  final QuizResult quizResult;
  final Map<String, dynamic> userAnswers;
  final int numberOfAttempt;
  final int questionsSumGrade;

  factory QuizData.fromJson(dynamic json) {
    print('$json');
    return QuizData(
      pageTitle: json["pageTitle"],
      quizResult: QuizResult.fromJson(json["quizResult"]),
      userAnswers: json["userAnswers"] ?? {},
      numberOfAttempt: json["numberOfAttempt"],
      questionsSumGrade: json["questionsSumGrade"],
    );
  }
}

class QuizResult {
  QuizResult({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.results,
    required this.userGrade,
    required this.status,
    required this.createdAt,
    required this.quiz,
  });

  final int id;
  final int quizId;
  final int userId;
  final String results;
  final int userGrade;
  final String status;
  final int createdAt;
  final Quiz quiz;

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json["id"],
      quizId: json["quiz_id"],
      userId: json["user_id"],
      results: json["results"],
      userGrade: json["user_grade"],
      status: json["status"],
      createdAt: json["created_at"],
      quiz: Quiz.fromJson(json["quiz"]),
    );
  }
}

class Quiz {
  Quiz({
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
    required this.webinar,
    required this.translations,
  });

  final int id;
  final int webinarId;
  final int creatorId;
  final int chapterId;
  final String? webinarTitle;
  final int time;
  final dynamic attempt;
  final int passMark;
  final int certificate;
  final String status;
  final int totalMark;
  final int createdAt;
  final dynamic updatedAt;
  final String title;
  final List<QuizQuestion> quizQuestions;
  final Webinar webinar;
  final List<QuizzesQuestionsAnswerTranslation> translations;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        webinarId: json["webinar_id"],
        creatorId: json["creator_id"],
        chapterId: json["chapter_id"] ?? 0,
        webinarTitle: json["webinar_title"],
        time: json["time"],
        attempt: json["attempt"],
        passMark: json["pass_mark"],
        certificate: json["certificate"] ?? 0,
        status: json["status"],
        totalMark: json["total_mark"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        title: json["title"],
        quizQuestions: List<QuizQuestion>.from(
            json["quiz_questions"].map((x) => QuizQuestion.fromJson(x))),
        webinar: Webinar.fromJson(json["webinar"]),
        translations: List<QuizzesQuestionsAnswerTranslation>.from(
            json["translations"]
                .map((x) => QuizzesQuestionsAnswerTranslation.fromJson(x))),
      );
}

class QuizQuestion {
  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.creatorId,
    required this.grade,
    required this.type,
    required this.explanation,
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
  final String? explanation;
  final int createdAt;
  final dynamic updatedAt;
  final String title;
  final dynamic correct;
  final List<QuizzesQuestionsAnswer> quizzesQuestionsAnswers;
  final List<QuizQuestionTranslation> translations;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json["id"],
      quizId: json["quiz_id"],
      creatorId: json["creator_id"],
      grade: json["grade"],
      type: json["type"],
      image: json["image"],
      video: json["video"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"] ?? 0,
      explanation: json["explanation"],
      title: json["title"],
      correct: json["correct"],
      quizzesQuestionsAnswers: List<QuizzesQuestionsAnswer>.from(
          json["quizzes_questions_answers"]
              .map((x) => QuizzesQuestionsAnswer.fromJson(x))),
      translations: List<QuizQuestionTranslation>.from(
          json["translations"].map((x) => QuizQuestionTranslation.fromJson(x))),
    );
  }

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
        updatedAt: json["updated_at"] ?? 0,
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
        locale: json["locale"],
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

class Webinar {
  Webinar({
    required this.id,
    required this.type,
    required this.slug,
    required this.duration,
    required this.price,
    required this.points,
    required this.messageForReviewer,
    required this.status,
    required this.title,
    required this.description,
    required this.seoDescription,
  });

  final int id;
  final String type;
  final String slug;
  final int duration;
  final dynamic price;
  final dynamic points;
  final dynamic messageForReviewer;
  final String status;
  final String title;
  final String description;
  final String seoDescription;

  factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        id: json["id"],
        type: json["type"],
        slug: json["slug"],
        price: json["price"],
        duration: json["duration"],
        points: json["points"],
        messageForReviewer: json["message_for_reviewer"],
        status: json["status"],
        title: json["title"],
        description: json["description"],
        seoDescription: json["seo_description"] ?? "",
      );
}

class WebinarTranslation {
  WebinarTranslation({
    required this.id,
    required this.webinarId,
    required this.locale,
    required this.title,
    required this.seoDescription,
    required this.description,
  });

  final int id;
  final int webinarId;
  final String locale;
  final String title;
  final String seoDescription;
  final String description;

  factory WebinarTranslation.fromJson(Map<String, dynamic> json) =>
      WebinarTranslation(
        id: json["id"],
        webinarId: json["webinar_id"],
        locale: json["locale"],
        title: json["title"],
        seoDescription: json["seo_description"] ?? "",
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "webinar_id": webinarId,
        "locale": locale,
        "title": title,
        "seo_description": seoDescription,
        "description": description,
      };
}
