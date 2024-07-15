import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TemperatureConversionScreen(),
    );
  }
}

class TemperatureConversionScreen extends StatefulWidget {
  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isCelsius = true;
  String _convertedTemperature = '';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    if (_controller.text.isEmpty) return;

    double inputTemperature = double.parse(_controller.text);
    double convertedTemperature;

    if (_isCelsius) {
      convertedTemperature = (inputTemperature * 9 / 5) + 32;
      _conversionHistory.insert(0,
          'C to F: ${inputTemperature.toStringAsFixed(1)} => ${convertedTemperature.toStringAsFixed(1)}');
    } else {
      convertedTemperature = (inputTemperature - 32) * 5 / 9;
      _conversionHistory.insert(0,
          'F to C: ${inputTemperature.toStringAsFixed(1)} => ${convertedTemperature.toStringAsFixed(1)}');
    }

    setState(() {
      _convertedTemperature = convertedTemperature.toStringAsFixed(1);
    });
  }

  void _toggleConversion() {
    setState(() {
      _isCelsius = !_isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildResultSection(),
                SizedBox(height: 20),
                Text('Enter Temperature',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Degree',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        value: _isCelsius ? 'C' : 'F',
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem<String>(
                            value: 'C',
                            child: Text('°C'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'F',
                            child: Text('°F'),
                          ),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            _toggleConversion();
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Convert In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: _isCelsius ? 'Fahrenheit (°F)' : 'Celsius (°C)',
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'Fahrenheit (°F)',
                      child: Text('Fahrenheit (°F)'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Celsius (°C)',
                      child: Text('Celsius (°C)'),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      _toggleConversion();
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _convertTemperature,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 109, 204, 195),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Convert'),
                  ),
                ),
                SizedBox(height: 20),
                Text('History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200, // Adjust as necessary
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _conversionHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_conversionHistory[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 166, 233, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          _convertedTemperature.isNotEmpty
              ? '$_convertedTemperature ${_isCelsius ? '°F' : '°C'}'
              : '',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      ),
    );
  }
}
