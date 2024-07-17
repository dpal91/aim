class NotificationModel {
  int? statusCode;
  String? message;
  Data? data;

  NotificationModel({this.statusCode, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? pageTitle;
  Notifications? notifications;

  Data({this.pageTitle, this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    notifications = json['notifications'] != null
        ? Notifications.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageTitle'] = pageTitle;
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    return data;
  }
}

class Notifications {
  int? currentPage;
  List<NotificationData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Notifications(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Notifications.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class NotificationData {
  int? id;
  int? userId;
  dynamic senderId;
  dynamic groupId;
  dynamic webinarId;
  String? title;
  String? message;
  String? sender;
  String? type;
  int? createdAt;
  int? count;
  NotificationStatus? notificationStatus;

  NotificationData(
      {this.id,
      this.userId,
      this.senderId,
      this.groupId,
      this.webinarId,
      this.title,
      this.message,
      this.sender,
      this.type,
      this.createdAt,
      this.count,
      this.notificationStatus});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    groupId = json['group_id'];
    webinarId = json['webinar_id'];
    title = json['title'];
    message = json['message'];
    sender = json['sender'];
    type = json['type'];
    createdAt = json['created_at'];
    count = json['count'];
    notificationStatus = json['notification_status'] != null
        ? NotificationStatus.fromJson(json['notification_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['sender_id'] = senderId;
    data['group_id'] = groupId;
    data['webinar_id'] = webinarId;
    data['title'] = title;
    data['message'] = message;
    data['sender'] = sender;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['count'] = count;
    if (notificationStatus != null) {
      data['notification_status'] = notificationStatus!.toJson();
    }
    return data;
  }
}

class NotificationStatus {
  int? id;
  int? userId;
  int? notificationId;
  int? seenAt;

  NotificationStatus({this.id, this.userId, this.notificationId, this.seenAt});

  NotificationStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    notificationId = json['notification_id'];
    seenAt = json['seen_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['notification_id'] = notificationId;
    data['seen_at'] = seenAt;
    return data;
  }
}
