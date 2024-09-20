import 'package:flutter_psu_course_review/models/review_post_model.dart';
import 'package:flutter_psu_course_review/repositories/review_post/review_post_repository.dart';

class ReviewPostMockRepo extends ReviewPostRepository {
  final List<ReviewPostModel> _tasks = [
    ReviewPostModel(
        title: 'This course is so good',
        text:
            'This course is about mobile app developer. It is good to learn and give me good grade',
        authorName: 'Pea',
        courseCode: '240-001',
        courseName: 'Mobile app developer'),
    ReviewPostModel(
        title: 'This course is so bad',
        text: 'This course is bad',
        authorName: 'X',
        courseCode: '240-002',
        courseName: 'Maew'),
    ReviewPostModel(
        title: 'I love this course',
        text: 'yqekqe',
        authorName: 'Maew',
        courseCode: '240-003',
        courseName: 'Web developer'),
  ];
  @override
  Future<List<ReviewPostModel>> fetchTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _tasks;
  }
}
