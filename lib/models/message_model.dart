import 'package:chat_app/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
    String msg,
    String read,
    String told,
    Type type,
    String sent,
    String fromId,
  ) : super(
          msg,
          read,
          told,
          type,
          sent,
          fromId,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      json['msg'] ?? '',
      json['read'] ?? '',
      json['told'] ?? '',
      json['type'] ?? '' == Type.image.name ? Type.image : Type.text,
      json['sent'] ?? '',
      json['fromId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'read': read,
      'told': told,
      'type': type.name,
      'sent': sent,
      'fromId': fromId,
    };
  }

  factory MessageModel.copy(MessageEntity entity) {
    return MessageModel(
      entity.msg,
      entity.read,
      entity.told,
      entity.type,
      entity.sent,
      entity.fromId,
    );
  }
}
