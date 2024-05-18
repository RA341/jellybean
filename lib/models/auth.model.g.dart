// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerAuthModel _$ServerAuthModelFromJson(Map<String, dynamic> json) =>
    ServerAuthModel()
      ..timesToRetry = (json['timesToRetry'] as num).toInt()
      ..retryDelayInMilliseconds =
          (json['retryDelayInMilliseconds'] as num).toInt()
      ..listRetryTimes = (json['listRetryTimes'] as num).toInt()
      ..serverList = (json['serverList'] as List<dynamic>)
          .map((e) => Server.fromJson(e as Map<String, dynamic>))
          .toList()
      ..defaultServer = (json['defaultServer'] as num).toInt()
      ..deviceData = json['deviceData'] as String;

Map<String, dynamic> _$ServerAuthModelToJson(ServerAuthModel instance) =>
    <String, dynamic>{
      'timesToRetry': instance.timesToRetry,
      'retryDelayInMilliseconds': instance.retryDelayInMilliseconds,
      'listRetryTimes': instance.listRetryTimes,
      'serverList': instance.serverList.map((e) => e.toJson()).toList(),
      'defaultServer': instance.defaultServer,
      'deviceData': instance.deviceData,
    };

Server _$ServerFromJson(Map<String, dynamic> json) => Server()
  ..nickName = json['nickName'] as String?
  ..accessToken = json['accessToken'] as String?
  ..hostList =
      (json['hostList'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
      'nickName': instance.nickName,
      'accessToken': instance.accessToken,
      'hostList': instance.hostList,
    };
