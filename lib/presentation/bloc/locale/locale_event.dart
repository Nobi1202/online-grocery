abstract class LocaleEvent {}

class OnLocaleInitializedEvent extends LocaleEvent {}

class OnLocaleChangedEvent extends LocaleEvent {
  final String locale;

  OnLocaleChangedEvent(this.locale);
}
