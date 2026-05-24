import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/models.dart';

class ChatScreen extends StatefulWidget {
  final FoundItem item;
  const ChatScreen({super.key, required this.item});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();
  late List<ChatMessage> _msgs;

  @override
  void initState() {
    super.initState();
    _msgs = List.from(SampleData.initialMessages);
  }

  void _send() {
    final txt = _ctrl.text.trim();
    if (txt.isEmpty) return;
    setState(() {
      _msgs.add(ChatMessage(text: txt, isMe: true, time: DateTime.now()));
    });
    _ctrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
    // Auto reply
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _msgs.add(ChatMessage(text: 'تمام، أنا بانتظارك. شكراً على تواصلك السريع 🙏', isMe: false, time: DateTime.now()));
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        });
      }
    });
  }

  String _fmt(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_forward_ios, size: 16), onPressed: () => Navigator.pop(context)),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.blue.withOpacity(0.3),
              child: Text(widget.item.finderInitial, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.blue2, fontFamily: 'Tajawal')),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.finderName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'Tajawal')),
                Row(children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  const Text('متصل الآن', style: TextStyle(fontSize: 10, color: AppColors.green, fontFamily: 'Tajawal')),
                ]),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.phone_outlined, size: 20), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(14),
              itemCount: _msgs.length,
              itemBuilder: (_, i) {
                final m = _msgs[i];
                return Align(
                  alignment: m.isMe ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                    decoration: BoxDecoration(
                      gradient: m.isMe
                        ? const LinearGradient(colors: [AppColors.blue, AppColors.blue2])
                        : null,
                      color: m.isMe ? null : AppColors.card2,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: m.isMe ? const Radius.circular(4) : const Radius.circular(16),
                        bottomRight: m.isMe ? const Radius.circular(16) : const Radius.circular(4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: m.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Text(m.text, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.5, fontFamily: 'Tajawal')),
                        const SizedBox(height: 4),
                        Text(_fmt(m.time), style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.6), fontFamily: 'Tajawal')),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
            color: AppColors.card,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal', fontSize: 13),
                    onSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      hintStyle: const TextStyle(color: AppColors.textMuted, fontFamily: 'Tajawal'),
                      filled: true,
                      fillColor: AppColors.navy2,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: AppColors.gold.withOpacity(0.15))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: AppColors.gold.withOpacity(0.15))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: AppColors.gold.withOpacity(0.4))),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.blue, AppColors.blue2]),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.4), blurRadius: 10, spreadRadius: 1)],
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
