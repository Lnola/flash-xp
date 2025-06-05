import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/data/dto/question.dto.dart';

class QuestionRepository {
  Future<List<QuestionDto>> fetch() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockQuestions();
  }

  List<QuestionDto> _mockQuestions() {
    final random = DateTime.now().millisecondsSinceEpoch % 2;
    if (random == 0) return _mockMultipleChoiceQuestions();
    return _mockSelfAssessmentQuestions();
  }

  List<QuestionDto> _mockMultipleChoiceQuestions() {
    return [
      QuestionDto(
        id: 1,
        text:
            'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        answerOptionDtos: [
          AnswerOptionDto(label: 'A', isCorrect: true),
          AnswerOptionDto(label: 'B', isCorrect: false),
          AnswerOptionDto(label: 'C', isCorrect: false),
          AnswerOptionDto(label: 'D', isCorrect: false),
        ],
      ),
      QuestionDto(
        id: 2,
        text:
            'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        answerOptionDtos: [
          AnswerOptionDto(label: 'A', isCorrect: false),
          AnswerOptionDto(label: 'B', isCorrect: true),
          AnswerOptionDto(label: 'C', isCorrect: false),
          AnswerOptionDto(label: 'D', isCorrect: false),
        ],
      ),
      QuestionDto(
        id: 3,
        text: 'Question is: Short',
        answer:
            'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        answerOptionDtos: [
          AnswerOptionDto(label: 'A', isCorrect: false),
          AnswerOptionDto(label: 'B', isCorrect: false),
          AnswerOptionDto(label: 'C', isCorrect: true),
          AnswerOptionDto(label: 'D', isCorrect: false),
        ],
      ),
      QuestionDto(
        id: 4,
        text: 'Question is: Short',
        answer: 'Answer is: Short',
        answerOptionDtos: [
          AnswerOptionDto(label: 'A', isCorrect: false),
          AnswerOptionDto(label: 'B', isCorrect: false),
          AnswerOptionDto(label: 'C', isCorrect: false),
          AnswerOptionDto(label: 'D', isCorrect: true),
        ],
      ),
    ];
  }

  List<QuestionDto> _mockSelfAssessmentQuestions() {
    return [
      QuestionDto(
        id: 1,
        text:
            'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        answer:
            'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
      QuestionDto(
        id: 2,
        text:
            'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        answer: 'Answer is: Short',
      ),
      QuestionDto(
        id: 3,
        text: 'Question is: Short',
        answer:
            'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
      QuestionDto(
        id: 4,
        text: 'Question is: Short',
        answer: 'Answer is: Short',
      ),
    ];
  }
}
