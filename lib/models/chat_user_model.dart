import 'package:chat_app/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  ChatUserModel(
    image,
    about,
    name,
    createdAt,
    id,
    lastActive,
    isOnline,
    pushToken,
    email,
  ) : super(
          image,
          about,
          name,
          createdAt,
          id,
          lastActive,
          isOnline,
          pushToken,
          email,
        );
  @override
  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
        json['image'] ?? '',
        json['about'] ?? '',
        json['name'] ?? '',
        json['created_at'] ?? '',
        json['id'] ?? '',
        json['last_active'] ?? '',
        json['is_online'] ?? false,
        json['push_token'] ?? '',
        json['email'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'about': about,
      'name': name,
      'created_at': createdAt,
      'id': id,
      'last_active': lastActive,
      'is_online': isOnline,
      'push_token': pushToken,
      'email': email,
    };
  }
}
