import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';
import 'package:flutter_psu_course_review/services/services.dart';

class EventRepoFromDb extends EventRepository {
  late List<EventModel> events = [];
  late List<EventModel> myEvents = [];

  late EventModel eventModel;
  late EventModelList eventModelList;

  final ApiService apiService = ApiService();
  final String baseUri = '/events';

  @override
  Future<List<EventModel>> fetchTasks() {
    throw UnimplementedError();
  }

  @override
  Future<String> createEvent(
      {required String eventTitle,
      required String eventDescription,
      required String eventDate,
      required String category}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.post(baseUri, data: {
      'event_title': eventTitle,
      'event_description': eventDescription,
      'event_date': eventDate,
      'category': category,
    });

    if (response.statusCode == 200) {
      return 'Event created successfully';
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to create event');
    }
  }

  @override
  Future<String> deleteEvent({required int eventId}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.delete('$baseUri/$eventId');
    if (response.statusCode == 200) {
      return response.data['message'];
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to delete event');
    }
  }

  @override
  Future<EventModel> getEvent({required int eventId}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.get('$baseUri/$eventId');
    if (response.statusCode == 200) {
      eventModel = EventModel.fromJson(response.data);
      return eventModel;
    } else {
      throw Exception('Failed to get event');
    }
  }

  @override
  Future<List<EventModel>> getEvents({int page = 1}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.get(baseUri, queryParameters: {
      'page': page,
    });
    if (response.statusCode == 200) {
      eventModelList = EventModelList.fromJson(response.data);
      events = eventModelList.events;
      events.sort((a, b) => a.id.compareTo(b.id));
      return events;
    } else {
      throw Exception('Failed to get events');
    }
  }

  @override
  Future<List<EventModel>> getMyEvents({int page = 1}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.get('$baseUri/my', queryParameters: {
      'page': page,
    });
    if (response.statusCode == 200) {
      eventModelList = EventModelList.fromJson(response.data);
      myEvents = eventModelList.events;
      myEvents.sort((a, b) => a.id.compareTo(b.id));
      return myEvents;
    } else {
      throw Exception('Failed to get events');
    }
  }

  @override
  Future<List<EventModel>> searchEvents({
    required String searchQuery,
    int page = 1,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    final fiteredEvents = events
        .where((event) =>
            event.eventTitle.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return fiteredEvents;
  }

  @override
  Future<List<EventModel>> searchMyEvents({
    required String searchQuery,
    int page = 1,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    final fiteredEvents = myEvents
        .where((event) =>
            event.eventTitle.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return fiteredEvents;
  }

  @override
  Future<String> updateEvent(
      {required String eventTitle,
      required String eventDescription,
      required String eventDate,
      required String category,
      required int likesAmount,
      required int eventId}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.put(
      '$baseUri/$eventId',
      data: {
        'event_title': eventTitle,
        'event_description': eventDescription,
        'event_date': eventDate,
        'category': category,
        'likes_amount': likesAmount,
      },
    );
    if (response.statusCode == 200) {
      return 'Event updated successfully';
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to update event');
    }
  }
}
