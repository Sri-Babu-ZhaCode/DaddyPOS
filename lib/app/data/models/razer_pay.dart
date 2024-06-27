class RazorPayOrderId {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? status;
  int? attempts;
  List<dynamic>? notes;
  int? createdAt;

  RazorPayOrderId(
      {this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.status,
      this.attempts,
      this.notes,
      this.createdAt});

  RazorPayOrderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    status = json['status'];
    attempts = json['attempts'];
    notes = json["notes"] == null
        ? []
        : List<dynamic>.from(json["notes"]!.map((x) => x));
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entity'] = entity;
    data['amount'] = amount;
    data['amount_paid'] = amountPaid;
    data['amount_due'] = amountDue;
    data['currency'] = currency;
    data['receipt'] = receipt;
    data['status'] = status;
    data['attempts'] = attempts;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}
