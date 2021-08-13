import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class EventBusUtil {
  static send(Object object) {
    eventBus.fire(object);
  }

  static receiver<T>(Function(T object) onEvent) {
    eventBus.on<T>().listen((obj) {
      onEvent(obj);
    });
  }

}
