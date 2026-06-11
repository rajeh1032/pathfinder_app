import 'model_chat_ai_history.dart';

const List<ChatSessionModel> dummySessions = [
  ChatSessionModel(
    id: '1',
    title: 'How to improv...',
    preview: "That's a great question. For...",
    date: '2d ago',
    messageCount: 17,
    isActive: true,
    tag: 'Advanced',
  ),
  ChatSessionModel(
    id: '2',
    title: 'Career...',
    preview: 'To reach Senior Cloud Engineer...',
    date: 'Yesterday',
    messageCount: 6,
    isActive: false,
    tag: '',
  ),
  ChatSessionModel(
    id: '3',
    title: 'Mock Interview...',
    preview: 'Explain the difference between...',
    date: 'Oct 12',
    messageCount: 40,
    isActive: false,
    tag: '#active',
  ),
  ChatSessionModel(
    id: '4',
    title: 'Optimizing SQL...',
    preview: 'By using EXPLAIN/ANALYZE to...',
    date: 'Oct 10',
    messageCount: 9,
    isActive: false,
    tag: '',
  ),
];
