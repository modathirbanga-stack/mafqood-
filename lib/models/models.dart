import 'dart:io';

class FoundItem {
  final String id;
  final String finderName;
  final String finderInitial;
  final String title;
  final String description;
  final String location;
  final String emirate;
  final String category;
  final String emoji;
  final DateTime createdAt;
  final double? lat;
  final double? lng;
  final double distanceKm;
  File? localImage;
  bool isResolved;

  FoundItem({
    required this.id,
    required this.finderName,
    required this.finderInitial,
    required this.title,
    required this.description,
    required this.location,
    required this.emirate,
    required this.category,
    required this.emoji,
    required this.createdAt,
    this.lat,
    this.lng,
    this.distanceKm = 0,
    this.localImage,
    this.isResolved = false,
  });
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String icon;
  final String type;
  final DateTime time;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.icon,
    required this.type,
    required this.time,
    this.isRead = false,
  });
}

// Sample data
class SampleData {
  static List<FoundItem> items = [
    FoundItem(
      id: '1',
      finderName: 'محمد العامري',
      finderInitial: 'م',
      title: 'حقيبة سفر سوداء',
      description: 'وجدت حقيبة سفر سوداء بجانب ماكينة قهوة في الصالة. عليها ملصق أحمر. تبدو قيّمة.',
      location: 'مطار دبي — مبنى 3',
      emirate: 'دبي',
      category: 'حقيبة سفر',
      emoji: '🎒',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      lat: 25.2532,
      lng: 55.3657,
      distanceKm: 2.1,
    ),
    FoundItem(
      id: '2',
      finderName: 'فاطمة الزهراني',
      finderInitial: 'ف',
      title: 'محفظة جلدية بنية',
      description: 'محفظة جلدية بنية اللون بداخلها بطاقات هوية وبطاقة بنكية. موجودة عند إدارة المول.',
      location: 'مول الإمارات — الطابق الثاني',
      emirate: 'دبي',
      category: 'محفظة',
      emoji: '👜',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      lat: 25.2048,
      lng: 55.2708,
      distanceKm: 5.4,
    ),
    FoundItem(
      id: '3',
      finderName: 'خالد الدوسري',
      finderInitial: 'خ',
      title: 'مفاتيح Toyota',
      description: 'مفاتيح سيارة Toyota على سلسلة مفاتيح زرقاء. وجدتها داخل عربة المترو.',
      location: 'مترو دبي — محطة BurJuman',
      emirate: 'دبي',
      category: 'مفاتيح',
      emoji: '🔑',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      lat: 25.2631,
      lng: 55.3024,
      distanceKm: 7.2,
    ),
    FoundItem(
      id: '4',
      finderName: 'نورة المنصوري',
      finderInitial: 'ن',
      title: 'آيفون 14 ذهبي',
      description: 'آيفون 14 بروماكس باللون الذهبي، الشاشة مكسورة قليلاً من الجانب. بدون كفر.',
      location: 'جامعة الإمارات — مبنى A',
      emirate: 'أبوظبي',
      category: 'هاتف',
      emoji: '📱',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      lat: 24.4672,
      lng: 54.6139,
      distanceKm: 11.8,
    ),
  ];

  static List<AppNotification> notifications = [
    AppNotification(
      id: '1',
      title: 'مفقود قريب منك!',
      body: 'وُجدت حقيبة سفر على بُعد 2.1 كم منك في مطار دبي',
      icon: '📍',
      type: 'nearby',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    AppNotification(
      id: '2',
      title: 'رسالة من محمد العامري',
      body: 'أنا عند مكتب المفقودات في الطابق الأرضي...',
      icon: '💬',
      type: 'message',
      time: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    AppNotification(
      id: '3',
      title: 'تطابق محتمل لمفقودك',
      body: 'وُجد شيء يشبه وصف حقيبتك المفقودة في الشارقة',
      icon: '🔍',
      type: 'match',
      time: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    AppNotification(
      id: '4',
      title: 'تم استعادة مفقودك',
      body: 'مبروك! تم التأكيد على استعادة محفظتك الجلدية',
      icon: '✅',
      type: 'resolved',
      time: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    AppNotification(
      id: '5',
      title: 'تقييم جديد ⭐',
      body: 'أعطاك خالد الدوسري 5 نجوم على تعاملك الممتاز',
      icon: '⭐',
      type: 'rating',
      time: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
  ];

  static List<ChatMessage> initialMessages = [
    ChatMessage(text: 'السلام عليكم، وجدت حقيبة سفر في مطار دبي. هل هي لك؟', isMe: false, time: DateTime.now().subtract(const Duration(minutes: 28))),
    ChatMessage(text: 'وعليكم السلام! تبدو مطابقة. هل عليها ملصق أحمر؟', isMe: true, time: DateTime.now().subtract(const Duration(minutes: 26))),
    ChatMessage(text: 'نعم! وفيها قفل رقمي أسود.', isMe: false, time: DateTime.now().subtract(const Duration(minutes: 25))),
    ChatMessage(text: 'هذه حقيبتي بالتأكيد! أين أجدك؟', isMe: true, time: DateTime.now().subtract(const Duration(minutes: 24))),
    ChatMessage(text: 'عند مكتب المفقودات — الطابق الأرضي قرب بوابة B.', isMe: false, time: DateTime.now().subtract(const Duration(minutes: 23))),
  ];
}
