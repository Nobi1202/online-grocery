import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/datasources/local/secure_storage.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_event.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final SecureStorage _secureStorage;

  LocaleBloc(this._secureStorage) : super(LocaleState(locale: 'en')) {
    on<OnLocaleChangedEvent>(_onLocaleChanged);
    on<OnLocaleInitializedEvent>(_onLocaleInitialized);
    add(OnLocaleInitializedEvent());
  }

  void _onLocaleInitialized(
    OnLocaleInitializedEvent event,
    Emitter<LocaleState> emit,
  ) async {
    final locale = _secureStorage.getLocale();
    if (locale != null) {
      emit(state.copyWith(locale: locale));
    }
  }

  void _onLocaleChanged(OnLocaleChangedEvent event, Emitter<LocaleState> emit) {
    _secureStorage.saveLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }
}
