class ResponseModel {
  int? userID;
  String? userName;
  bool? status;
  String? message;
  String? token;

  ResponseModel(
      {this.userID, this.userName, this.status, this.message, this.token});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    userName = json['UserName'];
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    data['UserName'] = userName;
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}

