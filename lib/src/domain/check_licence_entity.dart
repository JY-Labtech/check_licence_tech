// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

final class CheckLicenceEntity {
  final String id;
  final String uid;
  final String deviceUid;
  final String deviceSerialNumber;
  final String licenceKey;
  final String licenceEncrypt;
  final DateTime expiredAt;
  final bool isExpired;
  final bool isInactive;

  CheckLicenceEntity({
    required this.id,
    required this.uid,
    required this.deviceUid,
    required this.deviceSerialNumber,
    required this.licenceKey,
    required this.licenceEncrypt,
    required this.expiredAt,
    required this.isExpired,
    required this.isInactive,
  });

  CheckLicenceEntity copyWith({
    String? id,
    String? uid,
    String? deviceUid,
    String? deviceSerialNumber,
    String? licenceKey,
    String? licenceEncrypt,
    DateTime? expiredAt,
    bool? isExpired,
    bool? isInactive,
  }) {
    return CheckLicenceEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      deviceUid: deviceUid ?? this.deviceUid,
      deviceSerialNumber: deviceSerialNumber ?? this.deviceSerialNumber,
      licenceKey: licenceKey ?? this.licenceKey,
      licenceEncrypt: licenceEncrypt ?? this.licenceEncrypt,
      expiredAt: expiredAt ?? this.expiredAt,
      isExpired: isExpired ?? this.isExpired,
      isInactive: isInactive ?? this.isInactive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'deviceUid': deviceUid,
      'deviceSerialNumber': deviceSerialNumber,
      'licenceKey': licenceKey,
      'licenceEncrypt': licenceEncrypt,
      'expiredAt': expiredAt.millisecondsSinceEpoch,
      'isExpired': isExpired,
      'isInactive': isInactive,
    };
  }

  factory CheckLicenceEntity.fromMap(Map<String, dynamic> map) {
    return CheckLicenceEntity(
      id: map['id'] as String,
      uid: map['uid'] as String,
      deviceUid: map['deviceUid'] as String,
      deviceSerialNumber: map['deviceSerialNumber'] as String,
      licenceKey: map['licenceKey'] as String,
      licenceEncrypt: map['licenceEncrypt'] as String,
      expiredAt: DateTime.fromMillisecondsSinceEpoch(map['expiredAt'] as int),
      isExpired: map['isExpired'] as bool,
      isInactive: map['isInactive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckLicenceEntity.fromJson(String source) => CheckLicenceEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CheckLicenceEntity(id: $id, uid: $uid, deviceUid: $deviceUid, deviceSerialNumber: $deviceSerialNumber, licenceKey: $licenceKey, licenceEncrypt: $licenceEncrypt, expiredAt: $expiredAt, isExpired: $isExpired, isInactive: $isInactive)';
  }

  @override
  bool operator ==(covariant CheckLicenceEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.uid == uid && other.deviceUid == deviceUid && other.deviceSerialNumber == deviceSerialNumber && other.licenceKey == licenceKey && other.licenceEncrypt == licenceEncrypt && other.expiredAt == expiredAt && other.isExpired == isExpired && other.isInactive == isInactive;
  }

  @override
  int get hashCode {
    return id.hashCode ^ uid.hashCode ^ deviceUid.hashCode ^ deviceSerialNumber.hashCode ^ licenceKey.hashCode ^ licenceEncrypt.hashCode ^ expiredAt.hashCode ^ isExpired.hashCode ^ isInactive.hashCode;
  }
}
