import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int ms=0, s=0, m=0;
  String digmilisec="00", digsec="00", digmin="00";
  Timer? timer;
  bool started = false;

  List Laps=[];

  // Stop Function

  void stop()
  {
    timer!.cancel();
    setState(() {
      started=false;
    });
  }

  // Restart Function

  void reset()
  {
    timer!.cancel();
    setState(() {
      ms=0;
      s=0;
      m=0;
      digmilisec="00";
      digsec="00";
      digmin="00";
      started=false;
    });
  }
  
  //start Function
  
  void start()
  {
    started=true;
    timer = Timer.periodic(Duration(milliseconds: 1), (timer){

      int localmilisec = ms+1;
      int localsec = s;
      int localmin = m;

      if (localmilisec > 59)
        {
          if ( localsec >59)
            {
              localmin++;
              localsec=0;
            }
          else
            {
              localsec++;
              localmilisec=0;
            }
        }

      setState(() {
        ms=localmilisec;
        s=localsec;
        m=localmin;
        digmilisec = (ms>=10) ? "$ms" : "0$ms";
        digsec = (s>=10) ? "$s" : "0$s";
        digmin = (m>=10) ? "$m" : "0$m";
      });

    }
    );
  }

  // addlaps Function

  void addlaps()
  {
    String lap = "$digmin:$digsec:$digmilisec";
    setState(() {
      Laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2657),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'StopWatch',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xFF313E66),
                        shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Text(
                          "$digmin:$digsec:$digmilisec",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: Laps.length,
                        itemBuilder: (context,index)
                      {
                        return Padding(
                            padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lap ${index+1}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                                ),
                              ),
                              Text("${Laps[index]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: (){
                              (!started) ? start() : stop();
                            },
                          fillColor: Colors.blue,
                          shape: StadiumBorder(
                            side: BorderSide( color: Colors.blue)
                          ),
                          child: Text(
                            (!started) ? "Start" : "Stop",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                        ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                        onPressed: (){
                          addlaps();
                        },
                        icon: Icon(Icons.flag,
                        color: Colors.white,),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: StadiumBorder(
                            side: BorderSide( color: Colors.blue)
                        ),
                        child: Text(
                          "Restart",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}