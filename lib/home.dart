

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchController = new TextEditingController();


  void getRecipe(String query) async{
    //String url = 'https://api.edamam.com/api/recipes/v2?type=any&q=$query&app_id=6b0ebedc&app_key=c0375006048ed6bc6dae30a6282ca977&ingr=0-3&health=alcohol-free&calories=100-300';
    String url = 'https://api.edamam.com/api/recipes/v2?type=any&q=$query&app_id=6b0ebedc&app_key=c0375006048ed6bc6dae30a6282ca977';
    var response = await http.get(Uri.parse(url));
    print(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe('Ladoo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors:  [
                      Color(0xffec458d), Color(0xdd474ed7),
                  ]
              ),
            ),
          ),
          Column(
            children: [
              //Search Bar ===========================================================
              SafeArea(
                child: Container(

                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if((searchController.text).replaceAll(' ', '') == ''){
                            print('Blanked');
                          } else{
                            print(searchController.text);
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search, color: Colors.blue,),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Recipe',
                            border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('WHAT DO YOU WANT TO COOK TODAY?',style: TextStyle(fontSize: 33,color: Colors.white)),
                    SizedBox(height: 12,),
                    Text('Lets cook something!',style: TextStyle(fontSize: 20,color: Colors.white),)
                  ],
                ),
              )




            ],
          )
        ],
      ),
    );
  }
}



