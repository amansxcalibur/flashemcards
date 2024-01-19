import 'package:flashem/flashcard.dart';
import 'package:flashem/flashcard_view.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
//import 'package:customizable_flashcard/customizable_flashcard.dart';

void main() {
  runApp(MyApp());
}

int globalindex = 0;
List<List> _flashcards = [
  [
    Flashcard(question: "What language does flutter uses?", answer: "Dart"),
    Flashcard(question: "What language does React uses?", answer: "JavaScript")
  ],
  [
    Flashcard(
        question: "What language does Angular uses?", answer: "JavaScript"),
  ],
  [
    Flashcard(
        question: "What language does Electron uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does React Native uses?", answer: "JavaScript")
  ],
];

int currentindex = 0;

class MyApp extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SOSS Flutter'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      globalindex = index;
                      return const SecondPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.amber[colorCodes[index]], // Background color
              ),
              child: Container(
                height: 50,
                child: Center(child: Text('Entry ${entries[index]}')),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
              'SOSS Quiz', style: TextStyle(color: Colors.white),),
          actions: [
            IconButton.outlined(
              onPressed: ()=>{Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditPage()))
                          },
                          icon: Icon(Icons.add),
              ),
            IconButton.outlined(
              onPressed: ()=>{Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DelPage()))
                          },
                          icon: Icon(Icons.delete)
              )
            ]
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left : 0.15*MediaQuery.of(context).size.width),
                child: 
                  Stack(
                    children: [
                      Row(                    
                        children: [
                          Container(
                            width: 12,
                            height: 0.6 * MediaQuery.of(context).size.height,
                            /*decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)
                              ),*/
                          ),
                          Column(
                            children: [
                              Container(
                                width: 17,
                                height: 7,
                              ),
                              Container(
                                width: 0.7 * MediaQuery.of(context).size.width-17,
                                height: 0.6 * MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          /*decoration: BoxDecoration(
                            color: Colors.black,
                          ),*/
                          width: 0.7 * MediaQuery.of(context).size.width-12,
                          height: 0.6 * MediaQuery.of(context).size.height,
                          child: FlipCard(
                              front: FlashcardView(
                                  text: _flashcards[globalindex][_currIndex]
                                      .question),
                              back: FlashcardView(
                                  text: _flashcards[globalindex][_currIndex]
                                      .answer))),
                    ],
                  ),),
                  Container(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 0.7 * MediaQuery.of(context).size.width,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromARGB(255, 255, 184, 171),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: -20 +
                          0.6 *
                              (_currIndex + 1) *
                              MediaQuery.of(context).size.width /
                              _flashcards[globalindex].length,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Container(
                      color: Colors.black,
                      width: 0.12 * MediaQuery.of(context).size.width,
                    ),
                    IconButton.outlined(
                      iconSize: 60,
                      color: Colors.white,
                      onPressed: previousCard,
                      icon: Icon(Icons.chevron_left),
                    ),
                    Container(
                      width: 55,
                      alignment: Alignment.center,
                      child: Text(_currIndex.toString()+"/"+_flashcards[globalindex].length.toString()),
                    ),
                    IconButton.outlined(
                      iconSize: 60,
                      onPressed: nextCard,
                      color: Colors.white,
                      icon: Icon(Icons.chevron_right),
                    ),
                    Container(
                      color: Colors.black,
                      width: 0.12 * MediaQuery.of(context).size.width,
                    )
                    ]),
                  ),
                ],
              ),
            ),
        );
  }

  void nextCard() {
    setState(() {
      _currIndex = (_currIndex + 1 < _flashcards[globalindex].length)
          ? _currIndex + 1
          : 0;
      currentindex = _currIndex;
    });
  }

  void previousCard() {
    setState(() {
      _currIndex = (_currIndex - 1 >= 0)
          ? _currIndex - 1
          : _flashcards[globalindex].length - 1;
      currentindex = _currIndex;
    });
  }
}

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: myController,
            ),
            TextField(
              controller: myController2,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          onPressed: () {
        setState(() {
          _flashcards[globalindex].add(Flashcard(
              question: myController.text, answer: myController2.text));
        });
      }),
    );
    ;
  }
}

class DelPage extends StatefulWidget {
  const DelPage({super.key});

  @override
  State<DelPage> createState() => _DelPageState();
}

class _DelPageState extends State<DelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Are you sure you want to delete this flashcard PERMANENTLY?'),
      ),
      body: FloatingActionButton(onPressed: () {
        setState(() {
          _flashcards[globalindex].removeAt(currentindex);
        });
        Navigator.pop(context);
      }),
    );
    ;
  }
}
