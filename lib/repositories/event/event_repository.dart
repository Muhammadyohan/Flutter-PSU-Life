import 'package:flutter_psu_course_review/models/event_model.dart';

abstract class EventRepository {
  Future<List<EventModel>> fetchTasks();

  Future<String> createEvent({
    required String eventTitle,
    required String eventDescription,
    required String eventDate,
    required String category,
  });

  Future<List<EventModel>> getEvents({
    int page = 1,
  });

  Future<EventModel> getEvent({required int eventId});

  Future<String> updateEvent({
    required String eventTitle,
    required String eventDescription,
    required String eventDate,
    required String category,
    required int likesAmount,
    required int eventId,
  });

  Future<String> deleteEvent({required int eventId});
}
