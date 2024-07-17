class QuizQuesAns {
  final int? statusCode;
  final String? message;
  final QuizQuesAnsData? data;

  QuizQuesAns({
    this.statusCode,
    this.message,
    this.data,
  });

  QuizQuesAns.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? QuizQuesAnsData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'statusCode': statusCode, 'message': message, 'data': data?.toJson()};
}

class QuizQuesAnsData {
  final int? id;
  final int? quizId;
  final int? creatorId;
  final String? grade;
  final String? type;
  final dynamic image;
  final dynamic video;
  final int? createdAt;
  final dynamic updatedAt;
  final String? title;
  final dynamic correct;
  final List<QuizzesQuestionsAnswers>? quizzesQuestionsAnswers;
  final List<Translations>? translations;

  QuizQuesAnsData({
    this.id,
    this.quizId,
    this.creatorId,
    this.grade,
    this.type,
    this.image,
    this.video,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.correct,
    this.quizzesQuestionsAnswers,
    this.translations,
  });

  QuizQuesAnsData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        quizId = json['quiz_id'] as int?,
        creatorId = json['creator_id'] as int?,
        grade = json['grade'] as String?,
        type = json['type'] as String?,
        image = json['image'],
        video = json['video'],
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'],
        title = json['title'] as String?,
        correct = json['correct'],
        quizzesQuestionsAnswers = (json['quizzes_questions_answers'] as List?)
            ?.map((dynamic e) =>
                QuizzesQuestionsAnswers.fromJson(e as Map<String, dynamic>))
            .toList(),
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'quiz_id': quizId,
        'creator_id': creatorId,
        'grade': grade,
        'type': type,
        'image': image,
        'video': video,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'title': title,
        'correct': correct,
        'quizzes_questions_answers':
            quizzesQuestionsAnswers?.map((e) => e.toJson()).toList(),
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class QuizzesQuestionsAnswers {
  final int? id;
  final int? creatorId;
  final int? questionId;
  final dynamic image;
  final int? correct;
  final int? createdAt;
  final dynamic updatedAt;
  final String? title;
  final List<Translations>? translations;

  QuizzesQuestionsAnswers({
    this.id,
    this.creatorId,
    this.questionId,
    this.image,
    this.correct,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.translations,
  });

  QuizzesQuestionsAnswers.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        creatorId = json['creator_id'] as int?,
        questionId = json['question_id'] as int?,
        image = json['image'],
        correct = json['correct'] as int?,
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'],
        title = json['title'] as String?,
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'creator_id': creatorId,
        'question_id': questionId,
        'image': image,
        'correct': correct,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'title': title,
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class Translations {
  final int? id;
  final int? quizzesQuestionsAnswerId;
  final String? locale;
  final String? title;

  Translations({
    this.id,
    this.quizzesQuestionsAnswerId,
    this.locale,
    this.title,
  });

  Translations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        quizzesQuestionsAnswerId = json['quizzes_questions_answer_id'] as int?,
        locale = json['locale'] as String?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'quizzes_questions_answer_id': quizzesQuestionsAnswerId,
        'locale': locale,
        'title': title
      };
}

class TranslationsTwo {
  final int? id;
  final int? quizzesQuestionId;
  final String? locale;
  final String? title;
  final dynamic correct;

  TranslationsTwo({
    this.id,
    this.quizzesQuestionId,
    this.locale,
    this.title,
    this.correct,
  });

  TranslationsTwo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        quizzesQuestionId = json['quizzes_question_id'] as int?,
        locale = json['locale'] as String?,
        title = json['title'] as String?,
        correct = json['correct'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quizzes_question_id': quizzesQuestionId,
        'locale': locale,
        'title': title,
        'correct': correct
      };
}
