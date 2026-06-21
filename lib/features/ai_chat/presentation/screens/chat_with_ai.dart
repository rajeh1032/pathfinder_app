// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/routing/app_routes.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../ai_mentor_dummymodel.dart';
// import '../widgets/ai_mentor_header.dart';
// import '../widgets/chat_bubble.dart';
// import '../widgets/chat_input_bar.dart';
// import '../widgets/chat_message.dart';
//
// class ChatWithAiScreen extends StatefulWidget {
//   const ChatWithAiScreen({super.key});
//
//   @override
//   State<ChatWithAiScreen> createState() => _ChatWithAiScreenState();
// }
//
// class _ChatWithAiScreenState extends State<ChatWithAiScreen> {
//   final List<ChatMessage> _messages = List.from(dummyMessages);
//   final _controller = TextEditingController();
//   final _scrollController = ScrollController();
//
//   void _sendMessage() {
//     final text = _controller.text.trim();
//     if (text.isEmpty) return;
//
//     setState(() {
//       _messages.add(ChatMessage(
//         text: text,
//         isFromUser: true,
//         time: TimeOfDay.now().format(context),
//       ));
//       _controller.clear();
//     });
//
//     // Auto scroll to bottom
//     Future.delayed(const Duration(milliseconds: 100), () {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'PathFinder AI',
//           style: AppTextStyles.header600Blue28(AppColors.blueNotificationIcons),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.history_outlined,
//                 size: 28.sp, color: AppColors.primary.withValues(alpha: 0.5)),
//             onPressed: () => Navigator.pushNamed(
//                 context, AppRoutes.chatAiHistory),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // AI Mentor header
//           AiMentorHeader(),
//           // Messages list
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppSpacing.md.w,
//                 vertical: AppSpacing.sm.h,
//               ),
//               itemCount: _messages.length,
//               itemBuilder: (_, i) => ChatBubble(message: _messages[i]),
//             ),
//           ),
//           // Input bar
//           ChatInputBar(
//             controller: _controller,
//             onSend: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/ai_mentor_header.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/typing_indecator.dart';

class ChatWithAiScreen extends StatelessWidget {
  final String sessionId;

  const ChatWithAiScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatCubit>()..loadMessages(sessionId),
      child: _ChatWithAiView(sessionId: sessionId),
    );
  }
}

class _ChatWithAiView extends StatefulWidget {
  final String sessionId;

  const _ChatWithAiView({required this.sessionId});

  @override
  State<_ChatWithAiView> createState() => _ChatWithAiViewState();
}

class _ChatWithAiViewState extends State<_ChatWithAiView> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSend() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(
      sessionId: widget.sessionId,
      message: text,
    );

    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 18.sp, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: const AiMentorHeader(),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) {
            _scrollToBottom();
          }
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ChatLoading || state is ChatInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md.w,
                      vertical: AppSpacing.sm.h,
                    ),
                    itemCount:
                    state.messages.length + (state.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (state.isTyping &&
                          index == state.messages.length) {
                        return const TypingIndicator();
                      }
                      final msg = state.messages[index];
                      return ChatBubble(
                        message: msg.message,
                        isFromUser: msg.isFromUser,
                      );
                    },
                  ),
                ),
                ChatInputBar(
                  controller: _messageController,
                  onSend: _onSend,
                ),
              ],
            );
          }

          if (state is ChatError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.bodyMedium(cs.error),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}




