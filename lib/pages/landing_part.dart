import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
               borderRadius: BorderRadius.circular(20),
              child: Image.asset("images/building.jpeg",
              height: MediaQuery.of(context).size.height/1.7,
              fit:BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),
            Text('News from around the \n        world for you. ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
             SizedBox(height: 10),
            Text('This is the best  time to read take a \n       little of your time and read. ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(18)
              ),
              width: MediaQuery.of(context).size.width/1.5,
              padding: EdgeInsets.symmetric(vertical: 14  ),
              child: Center(child: Text("Get started", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)),
              
            )
          ],
        ),
      ),
    );
  }
}