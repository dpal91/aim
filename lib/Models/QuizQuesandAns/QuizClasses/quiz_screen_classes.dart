class Question {
  late final String questionText;
  late final List<Answer> answerList;
  Question({required this.questionText, required this.answerList});
}

class Answer {
  late final String answerText;
  late final bool isCorrect;
  Answer({required this.answerText, required this.isCorrect});
}

List<Question> getQuestions() {
  List<Question> list = [];
  list.add(Question(questionText: 'Who is the owner of flutter?', answerList: [
    Answer(answerText: 'Nokia', isCorrect: false),
    Answer(answerText: 'Samsung', isCorrect: false),
    Answer(answerText: 'Google', isCorrect: true),
    Answer(answerText: 'Apple', isCorrect: false)
  ]));
  list.add(Question(questionText: 'Youtube is a _______ platform', answerList: [
    Answer(answerText: 'Music Sharing', isCorrect: false),
    Answer(answerText: 'Video Sharing', isCorrect: true),
    Answer(answerText: 'Live Streaming', isCorrect: false),
    Answer(answerText: 'All of the above', isCorrect: false),
  ]));
  list.add(
      Question(questionText: 'Flutter uses dart as a language?', answerList: [
    Answer(answerText: 'True', isCorrect: true),
    Answer(answerText: 'False', isCorrect: false),
  ]));
  list.add(Question(questionText: 'Who is the owner of flutter?', answerList: [
    Answer(answerText: 'Nokia', isCorrect: false),
    Answer(answerText: 'Samsung', isCorrect: false),
    Answer(answerText: 'Google', isCorrect: true),
    Answer(answerText: 'Apple', isCorrect: false)
  ]));

  return list;
}
