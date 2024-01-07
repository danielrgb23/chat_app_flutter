class ChatUserEntity {
  final String image;
  final String about;
  final String name;
  final String createdAt;
  final String id;
  final String lastActive;
  final bool isOnline;
  final String pushToken;
  final String email;

  ChatUserEntity(
    this.image,
    this.about,
    this.name,
    this.createdAt,
    this.id,
    this.lastActive,
    this.isOnline,
    this.pushToken,
    this.email,
  );
}
