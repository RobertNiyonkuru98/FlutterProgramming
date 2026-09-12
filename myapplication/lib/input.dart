import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// 1. The Root Widget sets up the Material App design
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Input Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      // We point home to a StatefulWidget because we are dealing with user input (state)
      home: const InputDemoPage(),
    );
  }
}

// 2. A StatefulWidget to hold our controllers and variables
class InputDemoPage extends StatefulWidget {
  const InputDemoPage({super.key});

  @override
  State<InputDemoPage> createState() => _InputDemoPageState();
}

class _InputDemoPageState extends State<InputDemoPage> {
  // A controller lets you read the text, set initial text, and clear it
  final TextEditingController _emailController = TextEditingController(text: "Initial value here");
  
  // A simple string variable to hold the search term from the other TextField
  String _searchTerm = '';

  @override
  void dispose() {
    // Always dispose of controllers when the widget is destroyed to prevent memory leaks!
    _emailController.dispose();
    super.dispose();
  }

  // 3. The build method is where we actually construct the UI (the format that renders)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Fields Demo'),
      ),
      // The body of the app. We use a Column to stack widgets vertically.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Terms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            // TextField #1: Using onChanged to update a variable
            TextField(
              onChanged: (String val) {
                // setState tells Flutter to redraw the screen because data changed
                setState(() {
                  _searchTerm = val;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Type something to search...',
              ),
            ),
            
            const SizedBox(height: 10), // Adds a little vertical space
            Text('Current search term: $_searchTerm', style: const TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 40), // Adds more vertical space
            
            // TextField #2: Using a Controller to manage the input
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'you@email.com',
                icon: Icon(Icons.contact_mail),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // A button to demonstrate reading from the controller
            ElevatedButton(
              onPressed: () {
                print("Email submitted: ${_emailController.text}");
              },
              child: const Text('Submit Email'),
            )
          ],
        ),
      ),
    );
  }
}
