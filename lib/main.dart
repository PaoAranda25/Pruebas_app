import 'package:flutter/material.dart';

void main() {
  runApp(const FutbolQuizApp());
}

class FutbolQuizApp extends StatelessWidget {
  const FutbolQuizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futbol Quiz',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = const [
    {
      'questionText': '¿En qué año ganó Argentina su primera Copa del Mundo?',
      'answers': [
        {'text': '1930', 'score': 0},
        {'text': '1978', 'score': 10},
        {'text': '1986', 'score': 0},
        {'text': '1990', 'score': 0},
      ],
    },
    {
      'questionText':
          '¿Cuál es el equipo más exitoso en la historia de la Copa Libertadores?',
      'answers': [
        {'text': 'River Plate', 'score': 0},
        {'text': 'Santos', 'score': 0},
        {'text': 'Boca Juniors', 'score': 10},
        {'text': 'Independiente', 'score': 0},
      ],
    },
    {
      'questionText': '¿Quién ha ganado más Balones de Oro en la historia?',
      'answers': [
        {'text': 'Lionel Messi', 'score': 10},
        {'text': 'Cristiano Ronaldo', 'score': 0},
        {'text': 'Michel Platini', 'score': 0},
        {'text': 'Johan Cruyff', 'score': 0},
      ],
    },
    {
      'questionText': '¿En qué año se fundó el Real Madrid?',
      'answers': [
        {'text': '1897', 'score': 0},
        {'text': '1902', 'score': 10},
        {'text': '1910', 'score': 0},
        {'text': '1920', 'score': 0},
      ],
    },
    {
      'questionText':
          '¿Cuál es el máximo goleador en la historia de la Liga Española?',
      'answers': [
        {'text': 'Lionel Messi', 'score': 10},
        {'text': 'Cristiano Ronaldo', 'score': 0},
        {'text': 'Telmo Zarra', 'score': 0},
        {'text': 'Luis Suárez', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _questionIndex++;
      _score += score;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Futbol Quiz'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_score, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            () => answerQuestion(answer['score']),
            answer['text'] as String,
          );
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        questionText,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 10) {
      resultText = '¡Puedes mejorar! Tu puntaje es $resultScore.';
    } else {
      resultText = '¡Felicidades! Tu puntaje es $resultScore.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resetHandler,
            child: const Text('Reiniciar Quiz'),
          ),
        ],
      ),
    );
  }
}
