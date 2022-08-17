import 'package:equatable/equatable.dart';

class Summary extends Equatable {
  final String sum;
  final int asset;

  Summary({
    required this.sum,
    required this.asset,
  });

  factory Summary.fromJson(Map<String, dynamic> data) => Summary(
        sum: data['sum'],
        asset: data['asset'],
      );

  Summary copyWith({
    required String sum,
    required int asset,
  }) =>
      Summary(sum: this.sum, asset: this.asset);

  @override
  List<Object> get props => [sum, asset];
}

Summary mockUser = Summary(
  sum: "1123",
  asset: 1,
);
