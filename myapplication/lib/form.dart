import 'package:flutter/material.dart';

enum SearchType { web, image, news, shopping }

void main() => runApp(const MyApp());

// 1. TYPO: Must be 'StatelessWidget' with a capital 'S'
class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Form'),
                    centerTitle: true,
                    backgroundColor: Colors.green[600],  
                ), 
                body: const ProperForm(),
            ), 
        ); // 2. SYNTAX: Missing semicolon to finish the return statement
    }
}

class ProperForm extends StatefulWidget {
    const ProperForm({super.key});
    
    @override
    _ProperFormState createState() => _ProperFormState();
}

class _ProperFormState extends State<ProperForm> {
    final Map<String, dynamic> _searchForm = <String, dynamic>{
        'searchTerm': "",
        'searchType': SearchType.web,
        'safeSearchOn': true,
    };

    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
        return Form(
            key: _key,
            child: Container(
                child: ListView(
                    children:<Widget>[
                        TextFormField(
                            initialValue: _searchForm['searchTerm'],
                            decoration: const InputDecoration(
                                labelText: 'Search terms',
                            ),
                            // 3. NULL SAFETY: Callbacks like onChanged take nullable values (String?)
                            onChanged: (String? val) {
                                setState(() => _searchForm['searchTerm'] = val);
                            },
                            onSaved: (String? val) { },
                            validator: (String? val){
                                // 4. NULL SAFETY: Must check if val is null before checking .isEmpty
                                if (val == null || val.isEmpty){
                                    return 'We need something to search for';
                                }
                                return null;
                            },
                        ),
                        FormField<SearchType>(
                            builder: (FormFieldState<SearchType> state){
                                return DropdownButton<SearchType>(
                                    value: _searchForm['searchType'],
                                    items: const <DropdownMenuItem<SearchType>>[
                                        DropdownMenuItem<SearchType>(
                                            value: SearchType.web,
                                            child: Text('Web'),
                                        ),
                                        DropdownMenuItem<SearchType>(
                                            value: SearchType.image,
                                            child: Text('Image'),
                                        ),
                                        DropdownMenuItem<SearchType>(
                                            value: SearchType.news,
                                            child: Text('News'),
                                        ),
                                        DropdownMenuItem<SearchType>(
                                            value: SearchType.shopping,
                                            child: Text('Shopping'),
                                        ),
                                    ],
                                    onChanged: (SearchType? val){
                                        setState(() => _searchForm['searchType'] = val);
                                    },
                                );
                            },
                            onSaved: (SearchType? initialValue) {},
                        ),
                        FormField<bool>(
                            builder: (FormFieldState<bool> state){
                                return Row(
                                    children: <Widget>[
                                        Checkbox(
                                            value: _searchForm['safeSearchOn'],
                                            onChanged: (bool? val){
                                                setState(() => _searchForm['safeSearchOn'] = val);
                                            },
                                        ),
                                        const Text('Safesearch on'),
                                    ],
                                );
                            },
                            onSaved: (bool? initialValue) {},
                        ),
                        // 5. DEPRECATION: RaisedButton is retired. We use ElevatedButton now.
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: (){
                                // 6. NULL SAFETY: The form state might be null, so we must assert it exists (!)
                                if (_key.currentState!.validate()){
                                    _key.currentState!.save();
                                    print('Successfully saved the state.');
                                }
                            }
                        ),
                    ]
                ),
            ),
        ); // 7. SYNTAX: Must finish the build method's return statement with a semicolon
    }
}