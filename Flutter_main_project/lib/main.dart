import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  int seconds=0,minutes=0,hours=0;
  String digitseconds="00",digitMinutes="00",digitHours="00";
  Timer? timer;
  bool started=false;
  List laps=[];

  void stop(){
    timer!.cancel();
    setState(() {
      started= false;
    });
  }

  void reset(){
    timer!.cancel();
    setState(() {
      seconds=0;
      minutes=0;
      hours=0;

      digitseconds="00";
      digitMinutes="00";
      digitHours="00";
      started=false;
    });
  }
  void addlaps(){
    String lap="$digitHours:$digitMinutes:$digitseconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start(){
    started=true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localseconds= seconds+1;
      int localMinutes=minutes;
      int localHours=hours;

      if(localseconds>59){
        if(localMinutes>59){
          localHours++;
          localMinutes=0;
        }else{
          localMinutes++;
          localseconds=0;
        }
      }
      setState(() {
        seconds=localseconds;
        minutes=localMinutes;
        hours=localHours;
        digitseconds= (seconds>10)?"$seconds":"0$seconds";
        digitHours= (hours>10)?"$hours":"0$hours";
        digitMinutes= (minutes>10)?"$minutes":"0$minutes";
      });
    }
    
    
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "stopwatch app",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text("$digitHours:$digitMinutes:$digitseconds",
              style: TextStyle(
                color: Colors.white,
                fontSize: 82.0,
                fontWeight: FontWeight.w600 ,
                ),),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 56, 53, 53),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child :Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n°${index+1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      
                      )
                    );
                    

                  },),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                  child: RawMaterialButton(
                    onPressed: (){
                      (!started) ? start() : stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Color.fromARGB(255, 239, 242, 245)),
                    ),
                    child: Text(
                      (!started)? "start":"pause",
                      style: TextStyle(color: Colors.white),),
                      
                    ),
                    ),
                    SizedBox(width: 8.0,),
                    IconButton(
                      color: Colors.white,
                      onPressed: (){
                        addlaps();
                      },
                       icon: Icon(Icons.flag),
                       ),
                        SizedBox(
                          width: 8.0,
                          ),
                     Expanded(
                  child: RawMaterialButton(
                    onPressed: (){
                      reset();
                    },
                    fillColor: Color.fromARGB(255, 234, 236, 238),
                    shape: const StadiumBorder(
                      
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
                    ),
                    ),
                    ],
              )
            ],
            
          ),
        ),
      ),
      );
    
  }
}
