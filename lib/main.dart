import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
    String e="0";
    String r="0";
    String exp="0";
    double ef=38.0;
    double rf=48.0;
    buttonPressed(String buttonText){
      setState(() {
        if(buttonText=="C"){
            e="0";
            r="0";
            ef=38.0;
            rf=48.0;
        }
        else if(buttonText == "⌫"){
          ef=38.0;
          rf=48.0;
                e=e.substring(0,e.length-1);
                if(e==""){
                  e="0";
                }
        }
        else if(buttonText=="="){
          ef=38.0;
          rf=48.0;
          exp=e;
          exp=exp.replaceAll('×','*');
          exp=exp.replaceAll('÷','/');
          try{
            Parser p= new Parser();
            Expression exxp=p.parse(exp);
            ContextModel cm= ContextModel();
            r='${exxp.evaluate(EvaluationType.REAL, cm)}';

          }catch(e){
            r="Error";
          }

        }
        else {
          ef=38.0;
          rf=48.0;
          if (e == "0") {
            e = buttonText;
          }
          else {
            e = e + buttonText;
          }
        }
      });

    }
  Widget buildButton(String buttonText,double buttonHeight,Color buttonColor){
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid,
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: ()=> buttonPressed(buttonText),
          child:Text(
              buttonText,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              )
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              e,
              style: TextStyle(fontSize:  ef),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              r,
              style: TextStyle(fontSize: rf),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width *.75,
                child: Table(
                  children: [
                    TableRow(
                      children:[
                          buildButton("C",1,Colors.redAccent),
                        buildButton("⌫",1,Colors.blue),
                        buildButton("÷",1,Colors.blue),
                      ]
                    ),
                    TableRow(
                        children:[
                          buildButton("7",1,Colors.black54),
                          buildButton("8",1,Colors.black54),
                          buildButton("9",1,Colors.black54),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton("4",1,Colors.black54),
                          buildButton("5",1,Colors.black54),
                          buildButton("6",1,Colors.black54),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton("1",1,Colors.black54),
                          buildButton("2",1,Colors.black54),
                          buildButton("3",1,Colors.black54),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton(".",1,Colors.black54),
                          buildButton("0",1,Colors.black54),
                          buildButton("00",1,Colors.black54),
                        ]
                    )

                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children:[
                    TableRow(
                      children:[
                        buildButton("×",1,Colors.blue),
                      ]
                    ),
                    TableRow(
                        children:[
                          buildButton("-",1,Colors.blue),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton("+",1,Colors.blue),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton("=",2,Colors.red),
                        ]
                    )
                  ]
                )
              )
            ]
          ),
        ],
      ),
    );
  }
}
