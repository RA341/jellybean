import 'package:jellybean/utils/setup.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.model.g.dart';

@JsonSerializable(explicitToJson: true)
class ServerAuthModel {
  ServerAuthModel();

  factory ServerAuthModel.fromJson(Map<String, dynamic> json) =>
      _$ServerAuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServerAuthModelToJson(this);

  // connection strategy
  // how many times to try to connect to a specific host
  int timesToRetry = 3;

  // delay before next connection request
  int retryDelayInMilliseconds = 100;

  // times to go through the host list
  // i.e go to the host list 3 times before showing error message
  int listRetryTimes = 3;

  // url with lowest index will have the highest connection priority
  List<Server> serverList = [];

  // default server in the list
  int defaultServer = 0;

  // device string to use during auth
  String deviceData = '';

  Server? getDefaultServer() {
    return getServer(defaultServer);
  }

  Server? getServer(int index) {
    if (serverList.asMap().containsKey(index)) {
      return serverList[index];
    }
    logDebug('Server with index:$index not found in serverList');
    return null;
  }

  void insertServer(Server server) {
    serverList.add(server);
  }
}

@JsonSerializable(explicitToJson: true)
class Server {
  Server();

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);

  factory Server.fromPrefs({
    required String nickName,
    required String accessToken,
    required List<String> hostList,
  }) {
    return Server()
      ..nickName = nickName
      ..accessToken = accessToken
      ..hostList = hostList;
  }

  Map<String, dynamic> toJson() => _$ServerToJson(this);

  List<String> toPrefs() {
    return [accessToken!, ...hostList];
  }

  String? nickName;

  String? accessToken;

  // list of hosts which point to the same server
  // 0 index will have highest priority when connecting
  List<String> hostList = [];
}
