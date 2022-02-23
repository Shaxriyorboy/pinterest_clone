import 'dart:convert';

List<Collection> collectionFromJson(String str) => List<Collection>.from(json.decode(str).map((x) => Collection.fromJson(x)));

String collectionToJson(List<Collection> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Collection {
  Collection({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.curated,
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.tags,
    this.links,
    this.user,
    this.coverPhoto,
    this.previewPhotos,
  });

  String? id;
  String? title;
  String? description;
  DateTime? publishedAt;
  DateTime? lastCollectedAt;
  DateTime? updatedAt;
  bool? curated;
  bool? featured;
  int? totalPhotos;
  bool? private;
  String? shareKey;
  List<Tag>? tags;
  CollectionLinks? links;
  User? user;
  CollectionCoverPhoto? coverPhoto;
  List<PreviewPhoto>? previewPhotos;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    id: json["id"],
    title: json["title"],
    description: json["description"] == null ? null : json["description"],
    publishedAt: DateTime.parse(json["published_at"]),
    lastCollectedAt: DateTime.parse(json["last_collected_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    curated: json["curated"],
    featured: json["featured"],
    totalPhotos: json["total_photos"],
    private: json["private"],
    shareKey: json["share_key"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    links: CollectionLinks.fromJson(json["links"]),
    user: User.fromJson(json["user"]),
    coverPhoto: CollectionCoverPhoto.fromJson(json["cover_photo"]),
    previewPhotos: List<PreviewPhoto>.from(json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description == null ? "" : description,
    "published_at": publishedAt?.toIso8601String(),
    "last_collected_at": lastCollectedAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "curated": curated,
    "featured": featured,
    "total_photos": totalPhotos,
    "private": private,
    "share_key": shareKey,
    "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "user": user?.toJson(),
    "cover_photo": coverPhoto?.toJson(),
    "preview_photos": List<dynamic>.from(previewPhotos!.map((x) => x.toJson())),
  };
}

class CollectionCoverPhoto {
  CollectionCoverPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.user,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  Urls? urls;
  CoverPhotoLinks? links;
  List<dynamic>? categories;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  PurpleTopicSubmissions? topicSubmissions;
  User? user;

  factory CollectionCoverPhoto.fromJson(Map<String, dynamic> json) => CollectionCoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: CoverPhotoLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    topicSubmissions: PurpleTopicSubmissions.fromJson(json["topic_submissions"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt?.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "description": description == null ? null : description,
    "alt_description": altDescription == null ? null : altDescription,
    "urls": urls?.toJson(),
    "links": links?.toJson(),
    "categories": List<dynamic>.from(categories!.map((x) => x)),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections!.map((x) => x)),
    "sponsorship": sponsorship,
    "topic_submissions": topicSubmissions!.toJson(),
    "user": user!.toJson(),
  };
}

class CoverPhotoLinks {
  CoverPhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) => CoverPhotoLinks(
    self: json["self"],
    html: json["html"],
    download: json["download"],
    downloadLocation: json["download_location"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
    "download_location": downloadLocation,
  };
}

class PurpleTopicSubmissions {
  PurpleTopicSubmissions({
    this.foodDrink,
    this.texturesPatterns,
    this.health,
    this.fashion,
    this.businessWork,
    this.the3DRenders,
  });

  The3DRenders? foodDrink;
  The3DRenders? texturesPatterns;
  The3DRenders? health;
  The3DRenders? fashion;
  The3DRenders? businessWork;
  The3DRenders? the3DRenders;

  factory PurpleTopicSubmissions.fromJson(Map<String, dynamic> json) => PurpleTopicSubmissions(
    foodDrink: json["food-drink"] == null ? null : The3DRenders.fromJson(json["food-drink"]),
    texturesPatterns: json["textures-patterns"] == null ? null : The3DRenders.fromJson(json["textures-patterns"]),
    health: json["health"] == null ? null : The3DRenders.fromJson(json["health"]),
    fashion: json["fashion"] == null ? null : The3DRenders.fromJson(json["fashion"]),
    businessWork: json["business-work"] == null ? null : The3DRenders.fromJson(json["business-work"]),
    the3DRenders: json["3d-renders"] == null ? null : The3DRenders.fromJson(json["3d-renders"]),
  );

  Map<String, dynamic> toJson() => {
    "food-drink": foodDrink == null ? null : foodDrink!.toJson(),
    "textures-patterns": texturesPatterns == null ? null : texturesPatterns!.toJson(),
    "health": health == null ? null : health!.toJson(),
    "fashion": fashion == null ? null : fashion!.toJson(),
    "business-work": businessWork == null ? null : businessWork!.toJson(),
    "3d-renders": the3DRenders == null ? null : the3DRenders!.toJson(),
  };
}

class The3DRenders {
  The3DRenders({
    this.status,
    this.approvedOn,
  });

  Status? status;
  DateTime? approvedOn;

  factory The3DRenders.fromJson(Map<String, dynamic> json) => The3DRenders(
    status: statusValues.map![json["status"]],
    approvedOn: DateTime.parse(json["approved_on"]),
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse![status],
    "approved_on": approvedOn?.toIso8601String(),
  };
}

enum Status { APPROVED }

final statusValues = EnumValues({
  "approved": Status.APPROVED
});

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
    smallS3: json["small_s3"] == null ? null : json["small_s3"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
    "small_s3": smallS3 == null ? null : smallS3,
  };
}

class User {
  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  String? id;
  DateTime? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  UserLinks? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
    portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
    bio: json["bio"] == null ? null : json["bio"],
    location: json["location"] == null ? null : json["location"],
    links: UserLinks.fromJson(json["links"]),
    profileImage: ProfileImage.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
    totalCollections: json["total_collections"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    acceptedTos: json["accepted_tos"],
    forHire: json["for_hire"],
    social: Social.fromJson(json["social"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt?.toIso8601String(),
    "username": username,
    "name": name,
    "first_name": firstName,
    "last_name": lastName == null ? null : lastName,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "bio": bio == null ? null : bio,
    "location": location == null ? null : location,
    "links": links!.toJson(),
    "profile_image": profileImage!.toJson(),
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
    "for_hire": forHire,
    "social": social!.toJson(),
  };
}

class UserLinks {
  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
    following: json["following"],
    followers: json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
    "following": following,
    "followers": followers,
  };
}

class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  String? small;
  String? medium;
  String? large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}

class Social {
  Social({
    this.instagramUsername,
    this.portfolioUrl,
    this.twitterUsername,
    this.paypalEmail,
  });

  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  dynamic paypalEmail;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
    portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
    twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
    paypalEmail: json["paypal_email"],
  );

  Map<String, dynamic> toJson() => {
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "paypal_email": paypalEmail,
  };
}

class CollectionLinks {
  CollectionLinks({
    this.self,
    this.html,
    this.photos,
    this.related,
  });

  String? self;
  String? html;
  String? photos;
  String? related;

  factory CollectionLinks.fromJson(Map<String, dynamic> json) => CollectionLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    related: json["related"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "related": related,
  };
}

class PreviewPhoto {
  PreviewPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.blurHash,
    this.urls,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? blurHash;
  Urls? urls;

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    blurHash: json["blur_hash"],
    urls: Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "blur_hash": blurHash,
    "urls": urls!.toJson(),
  };
}

class Tag {
  Tag({
    this.type,
    this.title,
    this.source,
  });

  TypeEnum? type;
  String? title;
  Source? source;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    type: typeEnumValues.map![json["type"]],
    title: json["title"],
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "type": typeEnumValues.reverse![type],
    "title": title,
    "source": source == null ? null : source!.toJson(),
  };
}

class Source {
  Source({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  Ancestry? ancestry;
  String? title;
  String? subtitle;
  String? description;
  String? metaTitle;
  String? metaDescription;
  SourceCoverPhoto? coverPhoto;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    ancestry: Ancestry.fromJson(json["ancestry"]),
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    coverPhoto: SourceCoverPhoto.fromJson(json["cover_photo"]),
  );

  Map<String, dynamic> toJson() => {
    "ancestry": ancestry!.toJson(),
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "cover_photo": coverPhoto!.toJson(),
  };
}

class Ancestry {
  Ancestry({
    this.type,
    this.category,
    this.subcategory,
  });

  TypeClass? type;
  TypeClass? category;
  TypeClass? subcategory;

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
    type: TypeClass.fromJson(json["type"]),
    category: json["category"] == null ? null : TypeClass.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : TypeClass.fromJson(json["subcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type!.toJson(),
    "category": category == null ? null : category!.toJson(),
    "subcategory": subcategory == null ? null : subcategory!.toJson(),
  };
}

class TypeClass {
  TypeClass({
    this.slug,
    this.prettySlug,
  });

  String? slug;
  String? prettySlug;

  factory TypeClass.fromJson(Map<String, dynamic> json) => TypeClass(
    slug: json["slug"],
    prettySlug: json["pretty_slug"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "pretty_slug": prettySlug,
  };
}

class SourceCoverPhoto {
  SourceCoverPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.user,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  Urls? urls;
  CoverPhotoLinks? links;
  List<dynamic>? categories;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  FluffyTopicSubmissions? topicSubmissions;
  User? user;

  factory SourceCoverPhoto.fromJson(Map<String, dynamic> json) => SourceCoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: CoverPhotoLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    topicSubmissions: FluffyTopicSubmissions.fromJson(json["topic_submissions"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt?.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "description": description == null ? null : description,
    "alt_description": altDescription == null ? null : altDescription,
    "urls": urls!.toJson(),
    "links": links!.toJson(),
    "categories": List<dynamic>.from(categories!.map((x) => x)),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections!.map((x) => x)),
    "sponsorship": sponsorship,
    "topic_submissions": topicSubmissions!.toJson(),
    "user": user!.toJson(),
  };
}

class FluffyTopicSubmissions {
  FluffyTopicSubmissions({
    this.foodDrink,
    this.health,
    this.texturesPatterns,
    this.architecture,
    this.wallpapers,
    this.nature,
    this.spirituality,
  });

  The3DRenders? foodDrink;
  The3DRenders? health;
  The3DRenders? texturesPatterns;
  The3DRenders? architecture;
  The3DRenders? wallpapers;
  The3DRenders? nature;
  The3DRenders? spirituality;

  factory FluffyTopicSubmissions.fromJson(Map<String, dynamic> json) => FluffyTopicSubmissions(
    foodDrink: json["food-drink"] == null ? null : The3DRenders.fromJson(json["food-drink"]),
    health: json["health"] == null ? null : The3DRenders.fromJson(json["health"]),
    texturesPatterns: json["textures-patterns"] == null ? null : The3DRenders.fromJson(json["textures-patterns"]),
    architecture: json["architecture"] == null ? null : The3DRenders.fromJson(json["architecture"]),
    wallpapers: json["wallpapers"] == null ? null : The3DRenders.fromJson(json["wallpapers"]),
    nature: json["nature"] == null ? null : The3DRenders.fromJson(json["nature"]),
    spirituality: json["spirituality"] == null ? null : The3DRenders.fromJson(json["spirituality"]),
  );

  Map<String, dynamic> toJson() => {
    "food-drink": foodDrink == null ? null : foodDrink!.toJson(),
    "health": health == null ? null : health!.toJson(),
    "textures-patterns": texturesPatterns == null ? null : texturesPatterns!.toJson(),
    "architecture": architecture == null ? null : architecture!.toJson(),
    "wallpapers": wallpapers == null ? null : wallpapers!.toJson(),
    "nature": nature == null ? null : nature!.toJson(),
    "spirituality": spirituality == null ? null : spirituality!.toJson(),
  };
}

enum TypeEnum { SEARCH, LANDING_PAGE }

final typeEnumValues = EnumValues({
  "landing_page": TypeEnum.LANDING_PAGE,
  "search": TypeEnum.SEARCH
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
