import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/RecipeView.dart';
import 'package:food_recipe_app/Search.dart';
import 'package:food_recipe_app/model.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  List<RecipeModel> recipeList = <RecipeModel>[];

  List reciptcatlist = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1526346698789-22fd84314424?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpbGxpc3xlbnwwfHwwfHx8MA%3D%3D',
      'heading': 'Spicy Food'
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'heading': 'Non-Spicy Food'
    },
    {
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1667546202654-e7574a20872c?q=80&w=1473&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'heading': 'Desserts'
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njh8fGRyaW5rc3xlbnwwfHwwfHx8MA%3D%3D',
      'heading': 'Drinks'
    }
  ];

  TextEditingController searchController = TextEditingController();

  void getRecipe(String query) async {
    recipeList.clear();
    //String url = 'https://api.edamam.com/api/recipes/v2?type=any&q=$query&app_id=6b0ebedc&app_key=c0375006048ed6bc6dae30a6282ca977&ingr=0-3&health=alcohol-free&calories=100-300';
    String url =
        'https://api.edamam.com/api/recipes/v2?type=any&q=$query&app_id=6b0ebedc&app_key=c0375006048ed6bc6dae30a6282ca977';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // log(data.toString());
    data['hits'].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
      log(recipeList.toString());
    });
    setState(() {});

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
    });
  }

  @override
  void initState() {
    super.initState();
    getRecipe('Apple');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //Gradient Container ==============================================
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xe82c3e50),
                Color(0xff4A235A),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Column(children: [
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
                        onTap: () {
                          if ((searchController.text).replaceAll(' ', '') ==
                              '') {
                            print('Blanked');
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Search(searchController.text)));
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: 'Search Recipe',
                              border: InputBorder.none),
                        ),
                      ),

                      ElevatedButton(onPressed: (){ //Search Button ========================================
                        if ((searchController.text).replaceAll(' ', '') ==
                            '') {
                          print('Blanked');
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Search(searchController.text)));
                        }
                      }, child: Text('Search',
                           style: TextStyle(
                            fontWeight: FontWeight.w500,
                                color: Colors.white)),
                                 style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.blue.shade200),
                               )
                    ],
                  ),
                ),
              ),

              Container(
                //Text Container ==================================================
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('WHAT DO YOU WANT TO COOK TODAY?',
                        style: TextStyle(fontSize: 33, color: Colors.white)),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Lets cook something!',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox( //Featured Dishes ===============================================
                  height: 200,
                  child: CarouselView(
                      padding: EdgeInsets.all(12),
                      itemExtent: MediaQuery.sizeOf(context).width - 100,
                      children: [
                        Image.asset(
                          'assets/images/img1.jpg',
                          fit: BoxFit.cover,
                        ),
                       Image.asset(
                          'assets/images/img2.png',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/img3.png',
                          fit: BoxFit.cover,
                        )
                      ])),



              Container(
                //Dishes cart ========================================================
                child: isLoading
                    ? LinearProgressIndicator()
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String caloText =
                              recipeList[index].appcalo.toString();
                          String displayText = caloText.length > 6
                              ? caloText.substring(0, 6)
                              : caloText;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeView(
                                          appurl: recipeList[index].appurl)));
                            },
                            child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipeList[index].appimgurl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black26),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            recipeList[0].applabel,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ))),
                                  Positioned(
                                      right: 0,
                                      child: Container(
                                          //Calories Container ============================================================
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              )),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.local_fire_department,
                                                  size: 16,
                                                ),
                                                //  Text(recipeList[index].appcalo.toString().substring(0,6)),  changed causing error

                                                Text(displayText),
                                              ],
                                            ),
                                          )))
                                ],
                              ),
                            ),
                          );
                        }),
              ),

              Container(
                //Horizontal Containers for Food Catogories ====================================================
                height: 100,
                child: ListView.builder(
                    itemCount: reciptcatlist.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search(
                                        reciptcatlist[index]['heading'])));
                          },
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(18.0),
                                    child: Image.network(
                                      reciptcatlist[index]['imageUrl'],
                                      fit: BoxFit.cover,
                                      height: 250,
                                      width: 300,
                                    )),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          color: Colors.black26),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            reciptcatlist[index]['heading'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ]),
          )
        ],
      ),
    );
  }
}
