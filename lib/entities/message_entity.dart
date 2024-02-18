class MessageEntity {
  String msg;
  String read;
  String told;
  Type type;
  String sent;
  String fromId;

  MessageEntity(
    this.msg,
    this.read,
    this.told,
    this.type,
    this.sent,
    this.fromId,
  );
}

enum Type {
  text, image
}
