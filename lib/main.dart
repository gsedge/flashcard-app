import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'userfile.dart';
import 'collectionfile.dart';
import 'flashcardfile.dart';

List<CollectionClass> collectionList = [];
List<UserClass> userList = [];

late Box<UserClass> box1;
late Box<CollectionClass> box2;
late Box<FlashcardClass> box3;

late Box<dynamic> boxUsers;
late Box<dynamic> boxCollection;
late Box<dynamic> flashcardBox;

Color globalCol1 = Colors.redAccent.shade400;
Color globalCol2 =  Colors.indigo.shade600;

void main() async {

  //Setting up hive
  WidgetsFlutterBinding.ensureInitialized();   

  await Hive.initFlutter();   

  Hive.registerAdapter(UserClassAdapter());
  await Hive.openBox('userBox');

  Hive.registerAdapter(CollectionClassAdapter());
  await Hive.openBox('collectionBox');
  
  Hive.registerAdapter(FlashcardClassAdapter());
  await Hive.openBox('flashcardBox');

  boxUsers = Hive.box("userBox");
  boxCollection = Hive.box("collectionBox");
  flashcardBox = Hive.box("flashcardBox");

  boxUsers.add(UserClass(0, "george", "123"));
  boxCollection.add(CollectionClass(0, "col1", 0));

  runApp(const MyApp());
}

List<CollectionClass> getUserCollections (passId) {
  
  collectionList = [];

  for (int i = 0; i < boxCollection.length; i++) {
    if (boxCollection.getAt(i).userBelong == passId) {
      collectionList.add(boxCollection.getAt(i));
    }
  }

  for (int i = 0; i < flashcardBox.length; i++) {

    for (int x = 0; x < collectionList.length; x++) {

      if (collectionList[x].collectionId == flashcardBox.getAt(i).collectionId) {

        if (collectionList[x].userBelong == passId) {

          if (!(collectionList[x].cards.contains(flashcardBox.getAt(i)))) {
            collectionList[x].cards.add(flashcardBox.getAt(i));
          }
        }
      }
    }
  }

  return collectionList;

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage()//StartPage()
    );
  }
}


class StartPage extends StatelessWidget {
  //Startpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),
        
        body: ListView(
          children: [
             Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Align(
                alignment: Alignment.center,

                child: Text(
                  "FlashCards",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle (
                    fontWeight:FontWeight.bold,
                    fontSize:MediaQuery.of(context).size.width * 0.1,
                    color: globalCol2,
                  )
                )
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 200, 20, 50),
              child: Align(
                alignment: Alignment.center,

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,

                  child: ElevatedButton (

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(globalCol1),
                      overlayColor: MaterialStateProperty.all(Colors.cyan.shade300),
                      
                    ),
                    child: const Text("Login", style: TextStyle(fontSize: 30)),

                  )
                )
              )
            ),

             Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
              child: Align(
                alignment: Alignment.center,

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,

                  child: ElevatedButton (

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                    },

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(globalCol1),
                      overlayColor: MaterialStateProperty.all(Colors.cyan.shade300),
                      
                    ),
                    child: const Text("Sign up", style: TextStyle(fontSize: 30)),

                  )
                )
              )
            )

          ]

        )
      )
    );
  }


}


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  int checkUser (username, password) {
    bool correct = false;
    int userId = -1;
    Box<dynamic> boxUsers = Hive.box("userBox");

    if (boxUsers.length > 0) {

      for (int i = 0; i < boxUsers.length; i++) {

        UserClass testUser = boxUsers.getAt(i); 

        if (testUser.userName == username) {

          if (testUser.password == password) {
            correct = true;
            userId = testUser.userID;
          }
        }

        if (correct == true) {
            break;
        }
      }
    }
    
    if (correct == true) {
      return userId;
    } else {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),
        
        body: ListView(
          
          children: [  
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Align(
                alignment: Alignment.center,

                child: Text(
                  "FlashCards",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle (
                    fontWeight:FontWeight.bold,
                    fontSize:35,
                    color: globalCol2,
                  )
                )
              )
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),

            

            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Align(
                alignment: Alignment.center,

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,

                  child: TextField (
                    controller: textController1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'USERNAME',
                      fillColor: Colors.blueGrey.shade200,
                      
                    ),
                  )
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: Align(
                alignment: Alignment.center,

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,

                  child: TextField (
                    controller: textController2,
                    obscureText: true,
                    textAlign: TextAlign.center,

                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'PASSWORD',
                      fillColor: Colors.blueGrey.shade200,
                      
                    ),
                  )
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),

              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.4,
                
                child: ElevatedButton (
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(globalCol1),
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 30)),
                  
                  onPressed: () {
                    int passId = checkUser(textController1.text, textController2.text);
                    if (passId >= 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userId: passId)));
                    }
                  },
                )
              )
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),

                child: TextButton(
                  
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: const Text("Click to sign up", style: TextStyle(color: Colors.lightBlue, fontSize: 20))

                )
              )
            )
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  String errorText = "";

  SignupPage();
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),

         appBar: AppBar(
          backgroundColor: globalCol1,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),

        body: ListView(
          children: [

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),

                child: Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 40,
                    color: globalCol2,
                  ),
                ),
              )
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    controller: widget.controller1,
                    textAlign: TextAlign.center,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'FULL NAME',
                    )
                  )
                )
              )
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    controller: widget.controller2,
                    textAlign: TextAlign.center,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'USERNAME',
                    )
                  )
                )
              )
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),

                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    controller: widget.controller3,
                    textAlign: TextAlign.center,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'PASSWORD',
                    )
                  )
                )
              )
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SizedBox.expand(

                    child: ElevatedButton(

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(globalCol1),
                      ),
                      child: const Text("Create account", style: TextStyle(fontSize: 30)),


                      onPressed: () {

                        if (widget.controller1.text.length > 3 && 
                          widget.controller2.text.length > 3 &&
                          widget.controller3.text.length > 3) {

                          int userId = boxUsers.length+1;
                          boxUsers.add(UserClass(userId, widget.controller2.text, widget.controller3.text));

                          Navigator.pop(context);
                        } else {

                          widget.errorText = "Invalid entry, please fill all feilds";
                          setState((){});

                        }
                      },
   
                    )
                  ) 
                )
              )
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  widget.errorText,
                  style: const TextStyle(color: Colors.red, fontSize:15),
                )
              )
            )
          ]
        )
      )
    );
  }
}


class HomePage extends StatefulWidget {
  int userId;
  HomePage({super.key, required this.userId});

  final textController3 = TextEditingController();
  
  _HomeState createState() => _HomeState();
}
 
class _HomeState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  String getFlashcardLen(collection) {
    String newLen = collection.cards.length.toString();
    return "$newLen cards";
  }

    
  List<Widget> getExistingCollection (context, passId) {

    List<CollectionClass> collectionList = getUserCollections(passId);

    List<Widget> widgetList1 = [] ;
    List<List<Widget>> widgetList2 = [] ;
    List<Widget> rowList = [];
    int restartCount = 0;

    int toRemove = -1;

    for (int i = 0; i < collectionList.length; i++) {
      
      if (restartCount == 3) {
        widgetList2.add(widgetList1);
        widgetList1 = [];
        restartCount = 0;
      } 
      widgetList1.add(
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),

          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.32,/////////
            width: MediaQuery.of(context).size.width * 0.25,/////////

            child: SizedBox.expand(

              child: ElevatedButton ( 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(globalCol2)
                ),

                onPressed: () {
                  if (collectionList[i].cards.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionPage(collection: collectionList[i], index: 0, side: 1)));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Collection is empty"),
                        content: const Text("Add cards?"),
                        actions: [
                          TextButton(
                            onPressed: () {Navigator.of(context).pop();},
                            child: const Text("Cancel")
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(userId: widget.userId, colName: i.toString(), existing: true))).then((_) {  
                                  setState(() {});
                                });
                            } ,
                            child: const Text("Add cards")
                          ),
                        ]
                      )

                    );
                  }
                },

                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: Text(
                          collectionList[i].name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        )
                      )
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.19),

                    Row(
                      children: [
                        Align(
                          alignment:FractionalOffset.bottomLeft,
                          child: Text(

                            getFlashcardLen(collectionList[i]),
                            textAlign: TextAlign.left,
                          )
                        ),
                      ]
                    ),
                  ]
                )
              )
            ),
          ),
        ) 
      );
      
      restartCount = restartCount + 1;
    }
      

    if (widgetList1.isNotEmpty) {
      widgetList2.add(widgetList1);
    }
    
    for (int i = 0; i < widgetList2.length; i++) {
      rowList.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgetList2[i],
        )  
      );
    }

    if (toRemove > -1) {
      rowList = getExistingCollection (context, collectionList);
    }

    setState(() {});
    return rowList;

  }

  Widget build(BuildContext context) {

    Future openCdialog() => showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("New collection name"),
        content: TextField(
          decoration: const InputDecoration(),
          controller: widget.textController3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.textController3.clear();
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")
          ),
          TextButton(
            onPressed: () {
              if (widget.textController3.text.isNotEmpty) {
                String toForward = widget.textController3.text;
                widget.textController3.clear();
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(userId: widget.userId, colName: toForward, existing: false))).then((_) {
                  
                  setState(() {});
                });
              }
            },
            child: const Text("Create")
          )
        ]
      )
    );

    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),

        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            "FlashCards",
            style: TextStyle(color: Colors.white),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: globalCol1,

            )
          ),
        ),
        

        body: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: TextButton (

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange.shade50.withOpacity(0.5))
                ),

                onPressed: () {openCdialog();},

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    Text(
                      "New Collection",
                      style: TextStyle(color: globalCol2, fontSize: 30.0),
                    ),
                    Icon(
                      Icons.add,
                      color: globalCol2
                    ),
                    
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ElevatedButton (
                
                onPressed: () {null;},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(globalCol1), 
                ),
                child: const Text(
                  "Your Flashcard collections",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            SingleChildScrollView(
              child: 
              Column(

                children: getExistingCollection(context, widget.userId),
              ),
            )
          ],
        ),
      ),  
    );
  }
}


class CollectionPage extends StatefulWidget {
  late CollectionClass collection;
  late int index;
  late int side;


  CollectionPage({super.key, required this.collection, required this.index, required this.side});

  List<Color> colorSelection = [Colors.deepPurple.shade200, Colors.indigo.shade300, Colors.lightBlue, Colors.greenAccent, Colors.orange, Colors.red.shade300];
  static const IconData arrow_back = IconData(0xe092, fontFamily: 'MaterialIcons', matchTextDirection: true);
  static const IconData arrow_front = IconData(0xe092, fontFamily: 'MaterialIcons', matchTextDirection: false);


  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<CollectionPage> {

  double buttonO (int index) {
    double toReturn = 1.0;

    if (index == 0) {
      if (widget.index == 0) {
        toReturn = 0.0;
      } else {
        toReturn = 1.0;
      }
    } else {
      if (index == 1) {
        if (widget.index == widget.collection.cards.length-1) {
          toReturn = 0.0;
        } else {
          toReturn = 1.0;
        }
      }
    }

    return toReturn;
  }

  String getText(collection, index, side) {
    String showText;
      if (side == 1) {
        showText = collection.cards[index].frontside;
      } else {
        showText = collection.cards[index].backside;
      }

      return showText;
  }

  Color getColor(collection, index) {
    return widget.colorSelection[collection.cards[index].cardColor];
  }
    
  @override
  State<CollectionPage> createState() => _CollectionState();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),

        appBar: AppBar(
          backgroundColor: globalCol1,
          title: Text(widget.collection.name),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),

        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child:
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: 
                        IconButton(
                          onPressed: () {
                            if (widget.index > 0) {
                              widget.index = widget.index - 1;
                              widget.side = 1;
                              
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.black.withOpacity(buttonO(0)),
                        )
                    )
                  ),
                  

                Align(
                  alignment: const Alignment(0.0, 0.0),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 30.0),

                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.58,
      
                      child: DecoratedBox (
                        decoration: BoxDecoration(
                          color: getColor(widget.collection, widget.index),
                          border: Border.all(
                            color: getColor(widget.collection, widget.index),
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),

                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            getText(widget.collection, widget.index, widget.side),
                            style: const TextStyle(fontSize: 30),
                          ),
                        )
                      )
                    )
                  )
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: 

                      IconButton(
                        onPressed: () {
                          if (widget.index < widget.collection.cards.length-1) {
                            widget.index = widget.index + 1;
                            widget.side = 1;
                            
                          }
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_forward),
                        color: Colors.black.withOpacity(buttonO(1)),
                      )
                    ),
                )
              ]
            ),

            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.58,

                child: SizedBox.expand(
                  child: ElevatedButton(

                    onPressed: () {

                      if (widget.side == 1) {
                        setState(() {
                          widget.side = 2;
                        });
    
                      } else {
                        setState(() {
                          widget.side = 1;
                        });
                      }
                    },

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(globalCol2),
                    ),

                    child: const Text("FLIP CARD", style: TextStyle(fontSize: 30))
                  )
                )
              )
            )
          ]
        ),
      )
    );
  }
}


class CreatePage extends StatefulWidget {
  int userId;
  String colName;
  bool existing;
  
  CreatePage({super.key, required this.userId, required this.colName, required this.existing});

  final textController4 = TextEditingController();
  final textController5 = TextEditingController();
  late CollectionClass newCollection;

  List<Color> cBoxColors = [Colors.blueGrey.shade900, Colors.blueGrey.shade200, Colors.blueGrey.shade200, Colors.blueGrey.shade200, Colors.blueGrey.shade200, Colors.blueGrey.shade200];
  List<Color> colorSelection = [Colors.deepPurple.shade200, Colors.indigo.shade300, Colors.lightBlue, Colors.greenAccent, Colors.orange, Colors.red.shade300];
  int oldCselected = 0;
  int cSelected = 0;

  _CreateStateClass createState() => _CreateStateClass();
}

class _CreateStateClass extends State<CreatePage> { 

  @override
  void initState() {
    if (widget.existing == true) {
      widget.newCollection = collectionList[int.parse(widget.colName)]; 
      widget.colName = widget.newCollection.name;

    } else {
      int colId = 0;

      if (collectionList.isNotEmpty) {
        

        colId = collectionList.length + 1;
      } 

      widget.newCollection = CollectionClass(colId, widget.colName, widget.userId);
 
      boxCollection.add(widget.newCollection);
    }
    setState(() {});
    super.initState();
  } 

  Widget getColorButtons (context) {

    List<Widget> toReturn = [];

    for (int i = 0; i < 6; i++) {
      toReturn.add(

        Padding(
          padding: const EdgeInsets.fromLTRB(2, 10.0, 2, 5.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width * 0.075,
            
            child: DecoratedBox (
              decoration: BoxDecoration(
                color: widget.cBoxColors[i],
              ),

              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.074,
                width: MediaQuery.of(context).size.width * 0.074,

                child: IconButton(
                  onPressed: () {
                    widget.oldCselected = widget.cSelected;
                    widget.cSelected = i;

                    widget.cBoxColors[widget.cSelected] = Colors.blueGrey.shade900;
                    widget.cBoxColors[widget.oldCselected] = Colors.blueGrey.shade200;
                    
                    setState(() {});
                  },

                  color: widget.colorSelection[i],
                  icon: const Icon(Icons.square),

                )
              )
            )     
          )
        )
      );
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: toReturn,
    );
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: globalCol1,
          title: Text(widget.colName),
          leading: GestureDetector(
            onTap: () {
              
              Navigator.pop(context);
            },
            child: const Align(
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                  Text("SAVE")
                ]
              )
            )
          ),
        ),

        body: 
          ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 15.0),
                    child: SizedBox(
                      
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,

                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.colorSelection[widget.cSelected],
                          border: Border.all(
                            color: widget.colorSelection[widget.cSelected],
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                        ),

                        child: Align(
                          alignment: Alignment.center,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              const Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 15, 0.0, 30.0),
                                  child: Text(
                                    "Front of your card",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.3,

                                child: SizedBox.expand(

                                  child: Align(
                                    alignment: Alignment.center,
                    
                                    child: TextField(
                                      maxLines: 5,
                                      minLines: 5,

                                      controller: widget.textController4,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                      ),
                                    )
                                  )
                                )
                              )
                            ]
                          )
                        )
                      )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 30.0, 15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,

                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.colorSelection[widget.cSelected],
                          border: Border.all(
                            color: widget.colorSelection[widget.cSelected],
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                        ),

                        child: Align(
                          alignment: Alignment.center,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              const Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 15, 0.0, 30.0),
                                  child: Text(
                                    "Back of your card",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      fontSize: 20,
                                    ),
                                  ),  
                                )
                              ),


                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.3,

                                child: SizedBox.expand(

                                  child: Align(
                                    alignment: Alignment.center,

                                    child:TextField(
                                      controller: widget.textController5,
                                      maxLines: 12,
                                      minLines: 12,

                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                      ),
                                    )
                                  )
                                )
                              )
                            ]
                          )
                        )
                      )
                    ),
                  )
                ]
              ),

              getColorButtons(context),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),

                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.30,

                      child: SizedBox.expand(
        
                        child: ElevatedButton(
                          onPressed: () {
                            widget.textController4.clear();
                            widget.textController5.clear();
                          }, 

                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(globalCol1),
                          ),

                          child: const Text(
                            "Clear",
                            style: TextStyle(
                              fontSize: 20,
                            )
                          ),
                        ),
                      )
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),

                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.30,

                      child: SizedBox.expand(
            
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.textController4.text.isNotEmpty) {
                              if (widget.textController5.text.isNotEmpty) {

                                FlashcardClass newCard = FlashcardClass(widget.newCollection.collectionId, widget.cSelected, widget.textController4.text, widget.textController5.text);

                                widget.newCollection.addCard(newCard);
                                flashcardBox.add(newCard);
                                
                                widget.textController4.clear();
                                widget.textController5.clear(); 
                              }
                            }
                          }, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(globalCol1),
                          ),
                          child: const Center(
                            child: Text(
                              "Add to collection",
                              style: TextStyle(
                                fontSize: 20,
                              )
                            )
                          )
                        ),
                      )
                    )
                  )
                ]
              ),
            ]
          ),
      )
    );
  }
}