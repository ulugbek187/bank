class UserCardsModel {
  final String cardHolder;
  final String cardNumber;
  final String cardName;
  final String expireDate;
  final String userId;
  final int type;
  final String cvc;
  final String icon;
  final double balance;
  final String bankName;
  final String cardId;
  final String color;
  final bool isMain;

  UserCardsModel({
    required this.cardHolder,
    required this.cardNumber,
    required this.expireDate,
    required this.userId,
    required this.type,
    required this.cvc,
    required this.icon,
    required this.balance,
    required this.bankName,
    required this.cardId,
    required this.color,
    required this.isMain,
    required this.cardName,
  });

  factory UserCardsModel.fromJson(Map<String, dynamic> json) => UserCardsModel(
        cardHolder: json['cardHolder'] as String? ?? '',
        cardNumber: json['cardNumber'] as String? ?? '',
        expireDate: json['expireDate'] as String? ?? '',
        userId: json['userId'] as String? ?? '',
        type: json['type'] as int? ?? 0,
        cvc: json['cvc'] as String? ?? '',
        icon: json['icon'] as String? ?? '',
        balance: (json['balance'] as num? ?? 0).toDouble(),
        bankName: json['bankName'] as String? ?? '',
        cardId: json['cardId'] as String? ?? '',
        color: json['color'] as String? ?? '',
        cardName: json['cardName'] as String? ?? '',
        isMain: json['isMain'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'expireDate': expireDate,
      'userId': userId,
      'type': type,
      'cvc': cvc,
      'icon': icon,
      'balance': balance,
      'bankName': bankName,
      'cardId': cardId,
      'color': color,
      'isMain': isMain,
      'cardName': cardName,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'balance': balance,
      'color': color,
      'isMain': isMain,
      'cardName': cardName,
    };
  }

  UserCardsModel copyWith({
    String? cardHolder,
    String? cardNumber,
    String? expireDate,
    String? userId,
    int? type,
    String? cvc,
    String? icon,
    double? balance,
    String? bankName,
    String? cardId,
    String? color,
    String? cardName,
    bool? isMain,
  }) {
    return UserCardsModel(
      cardHolder: cardHolder ?? this.cardHolder,
      cardNumber: cardNumber ?? this.cardNumber,
      expireDate: expireDate ?? this.expireDate,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      cvc: cvc ?? this.cvc,
      icon: icon ?? this.icon,
      balance: balance ?? this.balance,
      bankName: bankName ?? this.bankName,
      cardId: cardId ?? this.cardId,
      color: color ?? this.color,
      isMain: isMain ?? this.isMain,
      cardName: cardName ?? this.cardName,
    );
  }

  static UserCardsModel initial() => UserCardsModel(
        cardHolder: '',
        cardNumber: '',
        expireDate: '',
        userId: '',
        type: 1,
        cvc: '',
        icon: '',
        balance: 0,
        bankName: '',
        cardId: '',
        color: '',
        cardName: '',
        isMain: false,
      );
}
