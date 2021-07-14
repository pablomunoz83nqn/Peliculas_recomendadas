class Cast {

  List<Actor> actores = new List();

  Cast.fromJsonList (List<dynamic> jsonList  ){

    if (jsonList == null) return;

    jsonList.forEach((item) { 

      final actor = Actor.fromJsonMap(item);
      actores.add(actor);


    });


  }


}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json){

    adult             = json['adult'];
    gender            = json['gender'];
    id                = json['id'];
    knownForDepartment = json['known_for_department'];
    name              = json['name'];
    originalName      = json['originalName'];
    popularity        = json['popularity'];
    profilePath       = json['profile_path'];
    castId            = json['cast_id'];
    character         = json['character'];
    creditId          = json['credit_id'];
    order             = json['order'];
    department        = json['department'];
    job               = json['job'];

  }

    getFoto(){

    if( profilePath == null) {
      return 'https://www.pngfind.com/pngs/m/341-3416003_no-avatar-pic-unknown-person-png-transparent-png.png';

    }else{

    return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }


  }

}
