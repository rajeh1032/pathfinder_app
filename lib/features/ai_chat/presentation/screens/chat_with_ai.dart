import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../ai_mentor_dummymodel.dart';
import '../widgets/ai_mentor_header.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message.dart';

class ChatWithAiScreen extends StatefulWidget {
  const ChatWithAiScreen({super.key});

  @override
  State<ChatWithAiScreen> createState() => _ChatWithAiScreenState();
}
class _ChatWithAiScreenState extends State<ChatWithAiScreen> {
  final List<ChatMessage> _messages = List.from(dummyMessages);
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isFromUser: true,
        time: TimeOfDay.now().format(context),
      ));
      _controller.clear();
    });

    // Auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PathFinder AI',
          style: AppTextStyles.header600Blue28(AppColors.blueNotificationIcons),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history_outlined,
                size: 28.sp,
                color: AppColors.primary.withOpacity(0.5)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // AI Mentor header
          AiMentorHeader(),
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: AppSpacing.sm.h,
              ),
              itemCount: _messages.length,
              itemBuilder: (_, i) => ChatBubble(message: _messages[i]),
            ),
          ),
          // Input bar
          chatInputBar(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}


