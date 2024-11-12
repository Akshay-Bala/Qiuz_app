import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    print('Initializing the database...');
    _database = await _initDB('quizapp.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    print('Getting database path...');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    print('Database path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    print('Creating the database tables...');
    await db.execute('''
    CREATE TABLE Questions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      questionText TEXT,
      options TEXT,
      answerIndex INTEGER
    );
    ''');

    await _populateDatabase(db);
  }

  Future _populateDatabase(Database db) async {
    print('Populating the database with sample data...');

    await db.insert('Questions', {
      'questionText': 'What is Flutter?',
      'options': 'A web framework,A mobile development framework,A game engine',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'Which programming language is used in Flutter?',
      'options': 'Dart,Java,Python',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'Which company developed Flutter?',
      'options': 'Microsoft,Google,Facebook',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is the command to create a new Flutter project?',
      'options': 'flutter start,flutter create,flutter new',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is the default package manager used in Flutter?',
      'options': 'npm,pip,pub',
      'answerIndex': 2,
    });

    await db.insert('Questions', {
      'questionText':
          'Which widget in Flutter is used to build an app\'s layout?',
      'options': 'Scaffold,Container,Column',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText':
          'Which of the following is not a valid Flutter widget type?',
      'options': 'StatelessWidget,StatefulWidget,LayoutWidget',
      'answerIndex': 2,
    });

    await db.insert('Questions', {
      'questionText': 'Which widget is used for scrolling in Flutter?',
      'options': 'ScrollView,ListView,GridView',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'How do you add a dependency to a Flutter project?',
      'options':
          'In the pubspec.yaml file,In the main.dart file,In the build.gradle file',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText':
          'Which of the following is used to import a Dart package in Flutter?',
      'options': '#import,import,using',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'Which widget is used for showing an app bar in Flutter?',
      'options': 'AppBar,NavigationBar,Header',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'Which class is used to handle user input in Flutter?',
      'options': 'TextInput,TextField,InputBox',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What does a StatefulWidget represent in Flutter?',
      'options':
          'A widget that doesn’t require a rebuild,A widget with mutable state,A widget with fixed state',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'Which of the following widgets is used for arranging widgets vertically?',
      'options': 'Row,Column,Stack',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is hot reload in Flutter?',
      'options':
          'Refreshes the entire app,Refreshes only the changed parts of the app,Rebuilds the app completely',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'Which Flutter widget is used for applying padding?',
      'options': 'Padding,Margin,Spacer',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'What is the purpose of main() function in Flutter?',
      'options':
          'To set the main route for the app,To start the app\'s execution,To handle UI layout',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'Which widget is used for displaying an image in Flutter?',
      'options': 'ImageView,Image.asset,Picture',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'What is the correct way to write a basic Flutter function?',
      'options': 'function main() {},void main() {},void start() {}',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'Access to a cloud database through Flutter is available through which service?',
      'options': ' SQLite,Firebase Database,MYSQL',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'Which method is used to run a Flutter app?',
      'options': 'runApp(),startApp(),launchApp()',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'What type of widget is a Container?',
      'options': 'StatelessWidget,StatefulWidget,Both',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'Which method is used to create a stateful widget?',
      'options': 'createState(),buildState(),initializeState()',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'What does the setState() method do in Flutter?',
      'options':
          'Rebuilds the entire widget tree,Updates the state of a StatefulWidget,Initializes the app',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'Which widget is used to display a list of items?',
      'options': 'ListView,GridView,ListBox',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'What does const keyword do in Flutter?',
      'options':
          'Makes a widget rebuild every time,Creates an immutable widget,Makes the widget stateful',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is the default font size in Flutter?',
      'options': '12,14,16',
      'answerIndex': 2,
    });

    await db.insert('Questions', {
      'questionText':
          'Which widget is used for displaying a button in Flutter?',
      'options': 'Button,FlatButton,RaisedButton',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'How can you make a widget center-aligned in Flutter?',
      'options': 'Align(),Center(),Position()',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is the purpose of Navigator in Flutter?',
      'options':
          'To display a list of items,To control the app’s routes and screens,To manage the app’s state',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'How do you change the background color of an app in Flutter?',
      'options':
          'Using a Container widget,Using the Scaffold widget\'s backgroundColor property,Using a Text widget\'s color property',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is a GestureDetector widget used for?',
      'options':
          'Detecting gestures like taps, swipes, etc.,Displaying a gesture on screen,Performing animations',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'Which widget allows the app to respond to input events?',
      'options': 'GestureDetector,Form,TextField',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'What is the pubspec.yaml file used for?',
      'options':
          'To define app routes,To manage app dependencies and assets,To define app state management',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is the purpose of a StatefulWidget in Flutter?',
      'options':
          'To hold only static content,To hold dynamic content that can change over time,To define a widget’s appearance',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'Which of the following Flutter widgets is used to display a simple text?',
      'options': 'Label,Text,Paragraph',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'What is the recommended way to handle multiple screens in Flutter?',
      'options':
          'Using multiple Scaffold widgets,Using Navigator and Routes,Using Container widgets',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'What is the purpose of the MaterialApp widget in Flutter?',
      'options':
          'To define app layout,To set up the app’s theme and routes,To define app behavior',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'How do you create a custom widget in Flutter?',
      'options':
          'By extending the StatelessWidget or StatefulWidget,By using only the Container widget,By writing raw Dart code',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText':
          'Which method is used to navigate to the previous screen?',
      'options': 'Navigator.pop(),Navigator.push(),Navigator.pushReplacement()',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText': 'What is the default app bar color in Flutter?',
      'options': 'White,Blue,Black',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'What is a Future in Dart/Flutter?',
      'options':
          'A function that returns a value immediately,A placeholder for a value that is available later,A class used for managing UI components',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText':
          'Which widget is used for displaying a snack bar in Flutter?',
      'options': 'SnackBar(),Snackbar(),ScaffoldMessenger()',
      'answerIndex': 2,
    });

    await db.insert('Questions', {
      'questionText': 'What does Navigator.pushNamed() do in Flutter?',
      'options':
          'Pushes a new screen on the stack with a given name,Pushes a new screen on the stack without a name,Navigates to a new screen directly',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText':
          'What is the purpose of the MaterialApp widget in Flutter?',
      'options':
          'To define app layout,To set up the app’s theme and routes,To define app behavior',
      'answerIndex': 1,
    });

    await db.insert('Questions', {
      'questionText': 'How do you create a custom widget in Flutter?',
      'options':
          'By extending the StatelessWidget or StatefulWidget,By using only the Container widget,By writing raw Dart code',
      'answerIndex': 0,
    });

    await db.insert('Questions', {
      'questionText':
          'Which method is used to navigate to the previous screen?',
      'options': 'Navigator.pop(),Navigator.push(),Navigator.pushReplacement()',
      'answerIndex': 0,
    });
  }

  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    final db = await database;
    final questions = await db.query('Questions');
    print('Fetched questions: $questions');
    return questions;
  }
}
