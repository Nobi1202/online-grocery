import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final String locale;

  const LocaleState({required this.locale});

  LocaleState copyWith({String? locale}) {
    return LocaleState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
