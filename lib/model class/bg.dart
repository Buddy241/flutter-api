class model1 {
  bool? success;
  String? message;
  Data? data;

  model1({this.success, this.message, this.data});

  model1.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? fullName;
  String? username;
  int? postId;
  String? description;
  String? cameraModel;
  String? shutterSpeed;
  String? iso;
  String? fStop;
  String? dimension;
  String? location;
  String? profileImage;
  String? hashtags;
  int? isLiked;
  int? isFollowed;
  int? isSaved;
  String? images;
  int? likedCount;
  int? commentCount;
  int? firstLikeId;
  String? firstLikeUsername;
  String? firstLikeName;
  String? firstLikeProfileImage;
  String? uploadedDate;

  Data(
      {this.userId,
        this.fullName,
        this.username,
        this.postId,
        this.description,
        this.cameraModel,
        this.shutterSpeed,
        this.iso,
        this.fStop,
        this.dimension,
        this.location,
        this.profileImage,
        this.hashtags,
        this.isLiked,
        this.isFollowed,
        this.isSaved,
        this.images,
        this.likedCount,
        this.commentCount,
        this.firstLikeId,
        this.firstLikeUsername,
        this.firstLikeName,
        this.firstLikeProfileImage,
        this.uploadedDate});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    username = json['username'];
    postId = json['post_id'];
    description = json['description'];
    cameraModel = json['camera_model'];
    shutterSpeed = json['shutter_speed'];
    iso = json['iso'];
    fStop = json['f_stop'];
    dimension = json['dimension'];
    location = json['location'];
    profileImage = json['profile_image'];
    hashtags = json['hashtags'];
    isLiked = json['isLiked'];
    isFollowed = json['isFollowed'];
    isSaved = json['isSaved'];
    images = json['images'];
    likedCount = json['Liked_count'];
    commentCount = json['Comment_count'];
    firstLikeId = json['first_like_id'];
    firstLikeUsername = json['first_like_username'];
    firstLikeName = json['first_like_name'];
    firstLikeProfileImage = json['first_like_profile_image'];
    uploadedDate = json['uploaded_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['username'] = this.username;
    data['post_id'] = this.postId;
    data['description'] = this.description;
    data['camera_model'] = this.cameraModel;
    data['shutter_speed'] = this.shutterSpeed;
    data['iso'] = this.iso;
    data['f_stop'] = this.fStop;
    data['dimension'] = this.dimension;
    data['location'] = this.location;
    data['profile_image'] = this.profileImage;
    data['hashtags'] = this.hashtags;
    data['isLiked'] = this.isLiked;
    data['isFollowed'] = this.isFollowed;
    data['isSaved'] = this.isSaved;
    data['images'] = this.images;
    data['Liked_count'] = this.likedCount;
    data['Comment_count'] = this.commentCount;
    data['first_like_id'] = this.firstLikeId;
    data['first_like_username'] = this.firstLikeUsername;
    data['first_like_name'] = this.firstLikeName;
    data['first_like_profile_image'] = this.firstLikeProfileImage;
    data['uploaded_date'] = this.uploadedDate;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

