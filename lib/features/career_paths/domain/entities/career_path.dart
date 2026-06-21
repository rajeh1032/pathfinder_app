import 'package:equatable/equatable.dart';

class CareerPath extends Equatable {
  const CareerPath({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  @override
  List<Object?> get props => [id, title];
}
