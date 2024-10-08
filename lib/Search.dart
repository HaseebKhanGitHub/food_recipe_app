import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/RecipeView.dart';
import 'package:food_recipe_app/model.dart';
import 'package:http/http.dart';


class Search extends StatefulWidget {

  late String query;
  Search(this.query);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;

  List<RecipeModel> recipeList = <RecipeModel>[];

  List reciptcatlist = [{
    'imageUrl':'https://images.unsplash.com/photo-1593560704563-f176a2eb61db', 'heading': 'Spicy Food '
  },
    {
      'imageUrl':'https://images.unsplash.com/photo-1593560704563-f176a2eb61db', 'heading': 'Non-Spicy Food '
    }];


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
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(//Gradient Container ==============================================
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffec458d),
                Color(0xdd474ed7),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
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
                            onTap: () {
                              if ((searchController.text).replaceAll(' ', '') ==
                                  '') {
                                print('Blanked');
                              } else {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Showing ${recipeList.length} Recipes',
                        style: TextStyle(fontSize: 18,color: Colors.white),)
                      ],
                    ),
                  ),


                  Container( //Dishes cart ========================================================
                    child: isLoading ? LinearProgressIndicator() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String caloText = recipeList[index].appcalo.toString();
                          String displayText = caloText.length > 6 ? caloText.substring(0, 6) : caloText;
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(appurl : recipeList[index].appurl)));
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
                                      child: Container( //Calories Container ============================================================
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              )
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.local_fire_department,size: 16,),
                                                //  Text(recipeList[index].appcalo.toString().substring(0,6)),  changed causing error

                                                Text(displayText),

                                              ],
                                            ),
                                          )
                                      )
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                ] ),
          )
        ],
      ),
    );
  }

}
