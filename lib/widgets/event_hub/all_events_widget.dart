import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import '../../pages/event_hub/event_category_page.dart';

class AllEventsWidget extends StatelessWidget {
  const AllEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E4B92),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEventCategory(context, Icons.music_note, 'Concert'),
              _buildEventCategory(context, Icons.sports_soccer, 'Sport'),
              _buildEventCategory(context, Icons.school, 'Education'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventCategory(
      BuildContext context, IconData icon, String category) {
    return GestureDetector(
      onTap: () {
        context.read<EventBloc>().add(SelectCategoryEvent(category: category));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventCategoryPage(category: category),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF3E4B92),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 5),
            Text(
              category,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
