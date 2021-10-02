import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation & Routing')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Go to Second Screen'),
            onPressed: () {
              Navigator.pushNamed(context, '/secondScreen');
            },
          ),
          ElevatedButton(
            child: const Text('Second Screen with Data'),
            onPressed: () {
              Navigator.pushNamed(context, '/secondScreenWithData',
                  arguments:
                      'You Just moved from first screen to second screen');
            },
          ),
          ElevatedButton(
            child: const Text('Return Data from Other Screen'),
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, '/returnDataScreen');
              SnackBar snackBar = SnackBar(content: Text('$result'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          ElevatedButton(
            child: const Text('Replace Screen'),
            onPressed: () {
             Navigator.pushNamed(context, '/replaceScreen');
            },
          ),
        ],
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      child: const Text('Back'),
      onPressed: () {
        Navigator.pop(context);
      },
    )));
  }
}

class SecondScreenWithData extends StatelessWidget {
  final String data;

  const SecondScreenWithData(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(data),
            ElevatedButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen({Key? key}) : super(key: key);

  @override
  _ReturnDataScreenState createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Enter your name'),
              ),
            ),
            ElevatedButton(
              child: const Text('Send'),
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class ReplaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Open other Screen'),
          onPressed: () {
            Navigator.pushReplacementNamed(context,'/anotherScreen');
          },
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const Text('Back to First Screen'),
            ElevatedButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/secondScreen': (context) => const SecondScreen(),
        '/secondScreenWithData': (context) => SecondScreenWithData(
            ModalRoute.of(context)?.settings.arguments as String),
        '/returnDataScreen': (context) => const ReturnDataScreen(),
        '/replaceScreen': (context) => ReplaceScreen(),
        '/anotherScreen': (context) => AnotherScreen(),
      },
    );
  }
}
