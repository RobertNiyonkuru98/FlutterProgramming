import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
    home: NewExpense(), // 1. Pass the Widget (NewExpense) here, not the State!
));

// 2. MISSING WIDGET: You defined the State class below, but forgot to define the StatefulWidget it belongs to!
class NewExpense extends StatefulWidget {
    const NewExpense({super.key});

    @override
    State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
    final _titleController =  TextEditingController();

    @override
    void dispose(){
        _titleController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context){
        // 3. We should wrap the padding in a Scaffold so it has a proper white background
        return Scaffold(
            appBar: AppBar(title: const Text('Add Expense')),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    children: <Widget>[
                        TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                                label: Text('Title')
                            ),
                        ),
                        Row(
                            children: [
                                ElevatedButton(
                                    onPressed: (){
                                        print(_titleController.text);
                                    },
                                    child: const Text('Save Expense'),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        ); // 4. Don't forget the semicolon at the end of the return statement!
    }
}