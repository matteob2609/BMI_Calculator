import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropdownValue='Male';

  TextEditingController height=TextEditingController();
  TextEditingController weight=TextEditingController();

  String result='N/A';

  void calculateBMI(double h, double w){
    double finalresult=w/(h*h/10000);
    String bmi=finalresult.toStringAsFixed(2);
    setState(() {
      result=bmi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                height.text='';
                weight.text='';
                result='N/A';
              });
            },
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 40),

            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.wc),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                  color: Colors.black
              ),
              underline: Container(
                height: 2,
                color: Colors.teal,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),

            SizedBox(height: 40),

            TextFormField(
              controller: height,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insert your height (cm)'
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Insert your height (cm)';
                }
                if(value.length>=4 || value.isEmpty || value.compareTo('0')==true){
                  return 'Invalid height';
                }
                return null;
              },
            ),
            SizedBox(height: 40),

            TextFormField(
              controller: weight,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insert your weight (kg)'
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Insert your weight (kg)';
                }
                if(value.length>=4 || value.isEmpty || value.compareTo('0')==true){
                  return 'Invalid weight';
                }
                return null;
              },
            ),

            SizedBox(height: 40),

            OutlineButton(
              textColor: Colors.indigo,
              onPressed: (){
                double h=double.parse(height.value.text);
                double w=double.parse(weight.value.text);
                calculateBMI(h, w);
              },
              child: Text('CONFIRM'),
              color: Colors.blueGrey[200],
            ),

            SizedBox(height: 20),

            Text(
              'Your BMI',
              style: TextStyle(
                  fontSize: 15
              ),
            ),

            SizedBox(height: 10),

            Text(
              '$result',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            OutlineButton(
                textColor: Colors.indigo,
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Page2()
                      )
                  );
                },
                child: Text('TABLE GUIDE'),
                color: Colors.blueGrey[200]
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('BMI Calculator - Info'), centerTitle: true),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              SizedBox(height: 40),

              DataTable(

                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'BMI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Classification',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('< 16.5')),
                      DataCell(Text('Severe underweight')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('16.5 - 18.4')),
                      DataCell(Text('Underweight')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('18.5 - 24.9')),
                      DataCell(Text('Normal')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('25 - 29.9')),
                      DataCell(Text('Overweight')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('30.1 - 34.9')),
                      DataCell(Text('First degree obesity')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('35 - 40')),
                      DataCell(Text('Second degree obesity')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('> 40')),
                      DataCell(Text('Third degree obesity')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
