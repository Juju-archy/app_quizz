import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:app_quizz/models/question.dart';

class PageQuizz extends StatefulWidget {

  @override
  _PageQuizzState createState() => _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz> {

  late Question question;
  List<Question> listQuestions = [
    Question('La devise de la Belgique est l\'union fait la force', true, '', 'belgique.JPG'),
    Question('La lune va finir par tomber sur terre à cause de la gravité', false, 'Au contraire la lune s\'éloigne', 'lune.jpg'),
    Question('La Russie est plus grande en superficie que Pluton', true, '', 'russie.jpg'),
    Question('Nyctalope est une race naine d\'antilope', false, 'C’est une aptitude à voir dans le noir', 'nyctalope.jpg'),
    Question('Le Commodore 64 est l\’oridnateur de bureau le plus vendu', true, '', 'commodore.jpg'),
    Question('Le nom du drapeau des pirates es black skull', false, 'Il est appelé Jolly Roger', 'pirate.png'),
    Question('Haddock est le nom du chien Tintin', false, 'C\'est Milou', 'tintin.jpg'),
    Question('La barbe des pharaons était fausse', true, 'A l\'époque déjà ils utilisaient des postiches', 'pharaon.jpg'),
    Question('Au Québec tire toi une bûche veut dire viens viens t\'asseoir', true, 'La bûche, fameuse chaise de bucheron', 'buche.jpg'),
    Question('Le module lunaire Eagle de possédait de 4Ko de Ram', true, 'Dire que je me plains avec mes 8GO de ram sur mon mac', 'eagle.jpg'),
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listQuestions[index];
  }

  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      appBar: AppBar(
        title: CustomText('Le Quizz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText("Question numérp : ${index+1}", color: Colors.grey[900]),
            CustomText("Score : $score / $index}", color: Colors.grey[900],),
            Card(
              elevation: 10.0,
              child: SizedBox(
                height: taille,
                width: taille,
                child: Image.asset(
                  'quizz assets/${question.imagePath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CustomText(question.question, color: Colors.grey[900], factor: 1.3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                boutonBool(true),
                boutonBool(false)
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton boutonBool(bool b) {
    return ElevatedButton(

      onPressed: () => dialogue(b),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, elevation: 10.0),
      child: CustomText((b)? "Vrai": "Faux", factor: 1.25,),
    );
  }

  Future<Null> dialogue(bool b) async {
    bool goodAnswer = (b == question.reponse);
    String vrai = "quizz assets/vrai.jpg";
    String faux = "quizz assets/faux.jpg";
    if (goodAnswer){
      score ++;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title:  CustomText((goodAnswer)? "C'est gagné!": "Oups ! perdu ...",
                factor: 1.4, color: (goodAnswer)? Colors.green : Colors.redAccent),
            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              Image.asset((goodAnswer)? vrai : faux, fit: BoxFit.cover,),
              Container(height: 25.0,),
              CustomText(question.explication, factor: 1.25, color: Colors.grey[900],),
              Container(height: 25,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    nextQuestion();
                  },
                  child: CustomText("Au suivant", factor: 1.25, color: Colors.blue)
              )
            ],
          );
        }
    );
  }

  Future<Null> alerte() async {
    return showAdaptiveDialog(context: context,
        builder: (BuildContext buildBontext){
          return AlertDialog(
            title: CustomText("C'est fini", color: Colors.blue, factor: 1.25,),
            contentPadding: EdgeInsets.all(10.0),
            content: CustomText("Votre score: $score / $index", color: Colors.grey[900],),
            actions: <Widget>[
              TextButton(onPressed: (){
                  Navigator.pop(buildBontext);
                  Navigator.pop(context);
                },
                child: CustomText("OK", factor: 1.25, color: Colors.blue,)
              ),
            ],
          );
        },
        barrierDismissible: false);
  }

  void nextQuestion(){
    if(index < listQuestions.length - 1){
      index++;
      setState(() {
        question = listQuestions[index];
      });
    } else {
      alerte();
    }
  }

}