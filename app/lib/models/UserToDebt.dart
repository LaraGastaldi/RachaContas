import 'package:rachacontas/models/User.dart';

class UserToDebt {
  int? id;
  String? relationship;
  String? phone;
  String? email;
  bool? smsSent;
  bool? emailSent;
  bool? verifiedAt;
  int? value;
  User? user;

  UserToDebt(
      {this.id,
        this.relationship,
        this.phone,
        this.email,
        this.smsSent,
        this.emailSent,
        this.verifiedAt,
        this.value,
        this.user});

  UserToDebt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relationship = json['relationship'];
    phone = json['phone'];
    email = json['email'];
    smsSent = json['sms_sent'];
    emailSent = json['email_sent'];
    verifiedAt = json['verified_at'];
    value = json['value'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['relationship'] = relationship;
    data['phone'] = phone;
    data['email'] = email;
    data['sms_sent'] = smsSent;
    data['email_sent'] = emailSent;
    data['verified_at'] = verifiedAt;
    data['value'] = value;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}