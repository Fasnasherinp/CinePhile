class MoviesModel {
  List<Data>? data;
  String? path;
  int? perPage;
  String? nextCursor;
  String? nextPageUrl;
  dynamic prevCursor;
  dynamic prevPageUrl;

  MoviesModel({this.data, this.path, this.perPage, this.nextCursor, this.nextPageUrl, this.prevCursor, this.prevPageUrl});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    path = json["path"];
    perPage = json["per_page"];
    nextCursor = json["next_cursor"];
    nextPageUrl = json["next_page_url"];
    prevCursor = json["prev_cursor"];
    prevPageUrl = json["prev_page_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["path"] = path;
    _data["per_page"] = perPage;
    _data["next_cursor"] = nextCursor;
    _data["next_page_url"] = nextPageUrl;
    _data["prev_cursor"] = prevCursor;
    _data["prev_page_url"] = prevPageUrl;
    return _data;
  }
}

class Data {
  String? id;
  int? movieId;
  String? originalTitle;
  String? originalLanguage;
  String? overview;
  double? popularity;
  String? posterPath;
  String? backdropPath;
  String? releaseDate;
  double? voteAverage;
  int? voteCount;
  int? adult;
  dynamic createdAt;
  dynamic updatedAt;
  List<Casts>? casts;

  Data({this.id, this.movieId, this.originalTitle, this.originalLanguage, this.overview, this.popularity, this.posterPath, this.backdropPath, this.releaseDate, this.voteAverage, this.voteCount, this.adult, this.createdAt, this.updatedAt, this.casts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    movieId = json["movie_id"];
    originalTitle = json["original_title"];
    originalLanguage = json["original_language"];
    overview = json["overview"];
    // Explicitly cast to double, handling both int and double from JSON
    popularity = (json["popularity"] is int) ? (json["popularity"] as int).toDouble() : json["popularity"];
    posterPath = json["poster_path"];
    backdropPath = json["backdrop_path"];
    releaseDate = json["release_date"];
    // Explicitly cast to double, handling both int and double from JSON
    voteAverage = (json["vote_average"] is int) ? (json["vote_average"] as int).toDouble() : json["vote_average"];
    voteCount = json["vote_count"];
    adult = json["adult"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    casts = json["casts"] == null ? null : (json["casts"] as List).map((e) => Casts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["movie_id"] = movieId;
    _data["original_title"] = originalTitle;
    _data["original_language"] = originalLanguage;
    _data["overview"] = overview;
    _data["popularity"] = popularity;
    _data["poster_path"] = posterPath;
    _data["backdrop_path"] = backdropPath;
    _data["release_date"] = releaseDate;
    _data["vote_average"] = voteAverage;
    _data["vote_count"] = voteCount;
    _data["adult"] = adult;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if(casts != null) {
      _data["casts"] = casts?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Casts {
  String? id;
  int? movieId;
  String? name;
  String? originalName;
  String? popularity;
  String? profilePath;
  String? character;
  dynamic createdAt;
  dynamic updatedAt;

  Casts({this.id, this.movieId, this.name, this.originalName, this.popularity, this.profilePath, this.character, this.createdAt, this.updatedAt});

  Casts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    movieId = json["movie_id"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"];
    profilePath = json["profile_path"];
    character = json["character"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["movie_id"] = movieId;
    _data["name"] = name;
    _data["original_name"] = originalName;
    _data["popularity"] = popularity;
    _data["profile_path"] = profilePath;
    _data["character"] = character;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}