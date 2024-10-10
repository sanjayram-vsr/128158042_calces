import 'package:calcu/basicScreen/login_screen.dart';
import 'package:calcu/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _firstValueController = TextEditingController();
  final TextEditingController _secondValueController = TextEditingController();
  String _selectedOperation = 'Add';

  void _navigateToResultPage(double result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(result: result),
      ),
    );
  }

  LinearGradient getGradient() {
    final colors = [

      Color(0xff061414),
      Colors.greenAccent,
    ];
    return LinearGradient(
      colors: [
        colors.first,
        colors.last,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  void _calculate() {
    double firstValue = double.tryParse(_firstValueController.text) ?? 0;
    double secondValue = double.tryParse(_secondValueController.text) ?? 0;
    double result = 0;

    switch (_selectedOperation) {
      case 'Add':
        result = firstValue + secondValue;
        break;
      case 'Subtract':
        result = firstValue - secondValue;
        break;
      case 'Multiply':
        result = firstValue * secondValue;
        break;
      case 'Divide':
        result = secondValue != 0
            ? firstValue / secondValue
            : 0; // Prevent division by zero
        break;
    }
    _navigateToResultPage(result);
  }

  void _incrementFirstValue() {
    setState(() {
      double currentValue = double.tryParse(_firstValueController.text) ?? 0;
      _firstValueController.text = (currentValue + 1).toString();
    });
  }

  void _decrementFirstValue() {
    setState(() {
      double currentValue = double.tryParse(_firstValueController.text) ?? 0;
      _firstValueController.text = (currentValue - 1).toString();
    });
  }

  void _incrementSecondValue() {
    setState(() {
      double currentValue = double.tryParse(_secondValueController.text) ?? 0;
      _secondValueController.text = (currentValue + 1).toString();
    });
  }

  void _decrementSecondValue() {
    setState(() {
      double currentValue = double.tryParse(_secondValueController.text) ?? 0;
      _secondValueController.text = (currentValue - 1).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor:  Color(0xff061414),
        centerTitle: true,
        title: Text('Calculator',style: TextStyle(color: Colors.white),),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () async{
              //    Navigator.pop(context);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: getGradient()),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementFirstValue, // Decrement value
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _firstValueController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Color(0xff061414)),
                            border: null,
                            labelText: 'First Value',
                          ),
                          maxLength: 6,
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementFirstValue, // Increment value
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementSecondValue, // Decrement value
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          maxLength: 6,
                          cursorColor: Colors.blue,
                          controller: _secondValueController,
                          decoration: InputDecoration(
                            labelText: 'Second Value',
                            labelStyle: TextStyle(color: Color(0xff061414)),
                            border: null,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementSecondValue, // Increment value
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  //  width: 100,
                  padding: EdgeInsets.all(10),
                  //  color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    value: _selectedOperation,
                    items: ['Add', 'Subtract', 'Multiply', 'Divide']
                        .map((operation) => DropdownMenuItem(
                              value: operation,
                              child: Text(operation),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedOperation = value!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculate,
                  child: Text('Calculate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
