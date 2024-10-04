import 'package:rachacontas/models/Proof.dart';
import 'package:rachacontas/models/UserToDebt.dart';

class Debt {
  int? id;
  int? totalValue;
  String? debtDate;
  String? maxPayDate;
  List<UserToDebt>? userToDebt;
  List<Proofs>? proofs;

  Debt(
      {this.id,
      this.totalValue,
      this.debtDate,
      this.maxPayDate,
      this.userToDebt,
      this.proofs});

  Debt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalValue = json['total_value'];
    debtDate = json['debt_date'];
    maxPayDate = json['max_pay_date'];
    if (json['user_to_debt'] != null) {
      userToDebt = <UserToDebt>[];
      json['user_to_debt'].forEach((v) {
        userToDebt!.add(UserToDebt.fromJson(v));
      });
    }
    if (json['proofs'] != null) {
      proofs = <Proofs>[];
      json['proofs'].forEach((v) {
        proofs!.add(new Proofs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_value'] = totalValue;
    data['debt_date'] = debtDate;
    data['max_pay_date'] = maxPayDate;
    if (userToDebt != null) {
      data['user_to_debt'] = userToDebt!.map((v) => v.toJson()).toList();
    }
    if (proofs != null) {
      data['proofs'] = proofs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
