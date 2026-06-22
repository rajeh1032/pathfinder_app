import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/ai_mentor_header.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/typing_indecator.dart';
import 'chat_history_screen.dart';

class ChatWithAiScreen extends StatelessWidget {
  final String sessionId;

  const ChatWithAiScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (_) => getIt<ChatCubit>()..loadMessages(sessionId),
      child: _ChatWithAiView(
        sessionId: sessionId,
      ),
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
      drawer: ChatSidebarDrawer(
        currentSessionId: widget.sessionId,
        onNewChat: () async {
          Navigator.pop(context);
          final session = await context.read<ChatCubit>().createSession();
          if (session != null && context.mounted) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.aiChat,
              arguments: session.id,
            );
          }
        },
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: Icon(Icons.menu_rounded, size: 22.sp),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),

          // onPressed: () => Navigator.push(
          // context,
          // MaterialPageRoute(
          // builder: (context) => ChatSidebarDrawer(
          // currentSessionId: widget.sessionId,
          // onNewChat: () => context.read<ChatCubit>().createSession(),
          // ),
          // ),
          // ),
        ),
        title: const AiMentorHeader(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) {
            _scrollToBottom();
          }
          if (state is ChatError) {
            CustomSnackbar.showError(
              context: context,
              message: state.message.tr(),
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
                    itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (state.isTyping && index == state.messages.length) {
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
