import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LiveDemoForm(),
));

class LiveDemoForm extends StatefulWidget {
    const LiveDemoForm({super.key});

    @override
    State<LiveDemoForm> createState() => _LiveDemoFormState();
}

class _LiveDemoFormState extends State<LiveDemoForm> {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    
    bool _obscurePassword = true;
    String _selectedSex = 'Male'; // Default radio selection
    
    // Checkbox states
    bool _mlCourse = true;
    bool _fsCourse = true;
    bool _mobileCourse = false;
    
    double _tuition = 20.0; // Slider state

    void _submitForm() {
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
            // Show the success SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Submitted successful 🥳🥳🥳'),
                    backgroundColor: Colors.black87,
                ),
            );
        }
    }

    void _clearForm() {
        // Reset all states when 'Clear' is pressed
        setState(() {
            _usernameController.clear();
            _passwordController.clear();
            _selectedSex = 'Male';
            _mlCourse = false;
            _fsCourse = false;
            _mobileCourse = false;
            _tuition = 0.0;
        });
    }

    @override
    void dispose() {
        _usernameController.dispose();
        _passwordController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                            // 1. Welcome Back Header
                            Container(
                                width: double.infinity,
                                color: Colors.grey[300],
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: const Center(
                                    child: Text(
                                        'Welcome Back!!!',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                        ),
                                    ),
                                ),
                            ),
                            
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            // 2. Username Row (using Expanded as per the Constraint Rule)
                                            Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    const SizedBox(
                                                        width: 90,
                                                        child: Padding(
                                                            padding: EdgeInsets.only(top: 12.0),
                                                            child: Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
                                                        ),
                                                    ),
                                                    Expanded(
                                                        child: TextFormField(
                                                            controller: _usernameController,
                                                            decoration: const InputDecoration(
                                                                filled: true,
                                                                fillColor: Color(0xFFEEEEEE),
                                                                border: InputBorder.none,
                                                                helperText: 'Username must be 10 char long',
                                                                helperStyle: TextStyle(color: Colors.red, fontSize: 10),
                                                                isDense: true,
                                                            ),
                                                            validator: (val) => (val == null || val.length < 10) ? 'Too short' : null,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            const SizedBox(height: 10),
                                            
                                            // 3. Password Row
                                            Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    const SizedBox(
                                                        width: 90,
                                                        child: Padding(
                                                            padding: EdgeInsets.only(top: 12.0),
                                                            child: Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                                                        ),
                                                    ),
                                                    Expanded(
                                                        child: TextFormField(
                                                            controller: _passwordController,
                                                            obscureText: _obscurePassword,
                                                            decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: const Color(0xFFEEEEEE),
                                                                border: InputBorder.none,
                                                                helperText: 'password must be 8 char long',
                                                                helperStyle: const TextStyle(color: Colors.red, fontSize: 10),
                                                                isDense: true,
                                                                suffixIcon: IconButton(
                                                                    icon: Icon(
                                                                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                                                        color: Colors.grey,
                                                                    ),
                                                                    onPressed: () {
                                                                        setState(() {
                                                                            _obscurePassword = !_obscurePassword;
                                                                        });
                                                                    },
                                                                ),
                                                            ),
                                                            validator: (val) => (val == null || val.length < 8) ? 'Too short' : null,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            const SizedBox(height: 10),
                                            
                                            // 4. Sex Radio Buttons
                                            Row(
                                                children: [
                                                    const SizedBox(
                                                        width: 90,
                                                        child: Text('Sex', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    ),
                                                    Radio<String>(
                                                        value: 'Male',
                                                        groupValue: _selectedSex,
                                                        onChanged: (val) => setState(() => _selectedSex = val!),
                                                    ),
                                                    const Text('Male', style: TextStyle(fontSize: 12)),
                                                    const SizedBox(width: 10),
                                                    Radio<String>(
                                                        value: 'Female',
                                                        groupValue: _selectedSex,
                                                        onChanged: (val) => setState(() => _selectedSex = val!),
                                                    ),
                                                    const Text('Female', style: TextStyle(fontSize: 12)),
                                                ],
                                            ),
                                            const SizedBox(height: 10),
                                            
                                            // 5. Courses Checkboxes
                                            Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    const SizedBox(
                                                        width: 90,
                                                        child: Padding(
                                                            padding: EdgeInsets.only(top: 12.0),
                                                            child: Text('Courses', style: TextStyle(fontWeight: FontWeight.bold)),
                                                        ),
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                            children: [
                                                                _buildCourseCheckbox('Machine Learning', _mlCourse, (val) => setState(() => _mlCourse = val!)),
                                                                _buildCourseCheckbox('Full stack', _fsCourse, (val) => setState(() => _fsCourse = val!)),
                                                                _buildCourseCheckbox('Mobile application', _mobileCourse, (val) => setState(() => _mobileCourse = val!)),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            const SizedBox(height: 20),
                                            
                                            // 6. Tuition Slider
                                            const Text('Tuition', style: TextStyle(fontWeight: FontWeight.bold)),
                                            SliderTheme(
                                                data: SliderTheme.of(context).copyWith(
                                                    activeTrackColor: Colors.lightGreen,
                                                    inactiveTrackColor: Colors.grey[300],
                                                    thumbColor: Colors.grey[700],
                                                    trackHeight: 4.0,
                                                ),
                                                child: Slider(
                                                    value: _tuition,
                                                    min: 0,
                                                    max: 100,
                                                    onChanged: (val) => setState(() => _tuition = val),
                                                ),
                                            ),
                                            
                                            const SizedBox(height: 20),
                                            
                                            // 7. Action Buttons
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                    OutlinedButton(
                                                        onPressed: _submitForm,
                                                        style: OutlinedButton.styleFrom(
                                                            backgroundColor: const Color(0xFFF0F4C3), // Light greenish-yellow
                                                            side: const BorderSide(color: Colors.green),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                                        ),
                                                        child: const Text('Submit', style: TextStyle(color: Colors.black)),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: _clearForm,
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.red,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                                        ),
                                                        child: const Text('Clear', style: TextStyle(color: Colors.white)),
                                                    ),
                                                ],
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
    
    // A quick helper method to avoid copying and pasting Checkbox code three times!
    Widget _buildCourseCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
        return Row(
            children: [
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Checkbox(
                        value: value,
                        onChanged: onChanged,
                        activeColor: Colors.deepPurple,
                    ),
                ),
                Text(title, style: const TextStyle(fontSize: 12)),
            ],
        );
    }
}
