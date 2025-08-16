import 'package:cosmetic/screen/register_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Expanded(child:Image.asset("assets/images/cosmetic_1.png", width: 200, height: 200,)
              ),
              Padding(padding: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  }, child: Text("Get Start", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
