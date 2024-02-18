class ChatUserEntity {
   String image;
   String about;
   String name;
   String createdAt;
   String id;
   String lastActive;
   bool isOnline;
   String pushToken;
   String email;

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
