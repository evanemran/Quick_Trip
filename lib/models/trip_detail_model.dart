class TripDetailModel {
  String id;
  List<Person> members;

  TripDetailModel({
    required this.id,
    required this.members,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) {
    return TripDetailModel(
      id: json['id'],
      members: (json['members'] as List)
          .map((e) => Person.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members.map((e) => e.toJson()).toList(),
    };
  }
}

class Person {
  String id;
  String name;
  bool isAdmin;
  double amountSpent;
  double amountShared;
  double deposit;
  double dueOrRefund;
  List<Expense> expenses;

  Person({
    required this.id,
    required this.name,
    required this.isAdmin,
    this.amountSpent = 0,
    this.amountShared = 0,
    this.deposit = 0,
    this.dueOrRefund = 0,
    List<Expense>? expenses,
  }): expenses = expenses ?? [];

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      isAdmin: json['isAdmin'],
      amountSpent: (json['amountSpent'] as num).toDouble(),
      amountShared: (json['amountShared'] as num).toDouble(),
      deposit: (json['deposit'] as num).toDouble(),
      dueOrRefund: (json['dueOrRefund'] as num).toDouble(),
      expenses: (json['expenses'] as List)
          .map((e) => Expense.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isAdmin': isAdmin,
      'amountSpent': amountSpent,
      'amountShared': amountShared,
      'deposit': deposit,
      'dueOrRefund': dueOrRefund,
      'expenses': (expenses!=null) ? expenses!.map((e) => e.toJson()).toList() : [],
    };
  }
}

class Expense {
  String id;
  String description;
  String category;
  bool isSharedByAll;
  List<String> sharedMembers;
  String date;
  String currency;
  double expenseAmount;

  Expense({
    required this.id,
    required this.description,
    required this.category,
    required this.isSharedByAll,
    required this.sharedMembers,
    required this.date,
    required this.currency,
    required this.expenseAmount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      description: json['description'],
      category: json['category'],
      isSharedByAll: json['isSharedByAll'],
      sharedMembers: List<String>.from(json['sharedMembers'] ?? []),
      date: json['date'],
      currency: json['currency'],
      expenseAmount: (json['expenseAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'category': category,
      'isSharedByAll': isSharedByAll,
      'sharedMembers': sharedMembers,
      'date': date,
      'currency': currency,
      'expenseAmount': expenseAmount,
    };
  }
}