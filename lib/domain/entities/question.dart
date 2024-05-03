class Question {
  final String content;
  final List<String> answers;
  final int? correctAnswer;

  Question({
    required this.content,
    required this.answers,
    this.correctAnswer,
  });
}