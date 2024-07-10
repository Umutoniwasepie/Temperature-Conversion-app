import 'package:flutter/material.dart';

void main() => runApp(TempConversionApp());

class TempConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TempConversionHomePage(),
    );
  }
}

class TempConversionHomePage extends StatefulWidget {
  @override
  _TempConversionHomePageState createState() => _TempConversionHomePageState();
}

class _TempConversionHomePageState extends State<TempConversionHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convert() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0;
      double output;
      if (_conversionType == 'F to C') {
        output = (input - 32) * 5 / 9;
      } else {
        output = input * 9 / 5 + 32;
      }
      _result = output.toStringAsFixed(2);
      _history.insert(0, '$_conversionType: $input => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: const Text('Fahrenheit to Celsius'),
                    leading: Radio<String>(
                      value: 'F to C',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Celsius to Fahrenheit'),
                    leading: Radio<String>(
                      value: 'C to F',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Temperature: $_result',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
