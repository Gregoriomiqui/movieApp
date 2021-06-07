class Cast {

  List<Actor> actores = [];
  Cast.fromJsonList( List<dynamic> jsonList){

    if (jsonList == null ) return;

    jsonList.forEach( (item){
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}





class Actor {
  bool? adult;
  int? gender;
  int id = 0;
  String? knownForDepartment;
  String name = "";
  String? originalName;
  double? popularity;
  String? profilePath;
  int castId= 0;
  String? character;
  String? creditId;
  int? order;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ){
    adult                = json['adult']; 
    gender               = json['gender']; 
    id                   = json['id']; 
    knownForDepartment   = json['known_for_department']; 
    name                 = json['name']; 
    originalName         = json['original_name']; 
    popularity           = json['popularity']; 
    profilePath          = json['profile_path']; 
    castId               = json['cast_id']; 
    character            = json['character']; 
    creditId             = json['credit_id']; 
    order                = json['order']; 
  }

  getFoto() {
    if (profilePath == null || profilePath == ""){
      return 'https://www.pikpng.com/pngl/b/75-756814_login-user-imagen-user-png-clipart.png';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}

