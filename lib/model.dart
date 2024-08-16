


class RecipeModel {
  late String applabel;
  late String appimgurl;
  late double appcalo;
  late String appurl;


  RecipeModel({this.applabel = 'LABEL', this.appimgurl = 'IMAGE', this.appcalo = 0.1, this.appurl = 'URL'});
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applabel: recipe['label'],
      appimgurl: recipe['image'],
      appcalo: recipe['calories'],
      appurl: recipe['url'],

    );
  }

}