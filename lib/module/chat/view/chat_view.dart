import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/module/chat/widget/chat_item_widget.dart';
import 'package:pet_affinity/shared/search_bar_widget.dart';
import 'package:pet_affinity/utils/app_images.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SearchBarWidget(
            hintText: 'Pesquisar',
            onSearch: (value) {},
            controller: TextEditingController(),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemBuilder: (context, index) {
                return ChatItemWidget(
                  name: 'Sarah Doe',
                  message: 'Olá, como vai você?',
                  time: '12:00',
                  image: AppImages.banner,
                  isRead: index % 2 == 0,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
            ),
          ),
        ],
      ),
    );
  }
}
