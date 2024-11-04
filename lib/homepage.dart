import 'package:flutter/material.dart';



class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container( 
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width/2.2,
                  height:170,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hey",style: TextStyle(fontSize: 26),),
                      Text('User',style: TextStyle(fontSize: 26),),
                    ],
                  )
                  ),

                Container( 
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width/2.2,
                  height:170,
                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.person, size: 150,))),
              ],
            ),
            Container(decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                      height: MediaQuery.of(context).size.height-500,
                      width: MediaQuery.of(context).size.width-40,
                      margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                      ),
            const Text('Made with love.',)
          ],
        ),
      ),
    );
  }
}
