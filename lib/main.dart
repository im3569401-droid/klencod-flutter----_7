import 'package:flutter/material.dart';

void main() {
  runApp(const StudentManagementApp());
}

// نموذج بيانات الطالب المتقدم
class Student {
  String id;
  String name;
  String attendanceStatus; // 'حاضر', 'متأخر', 'غائب', 'معذور'
  List<String> badges;     // الشارات التكريمية
  String notes;            // ملاحظات المعلم
  DateTime date;

  Student({
    required this.id,
    required this.name,
    required this.attendanceStatus,
    required this.badges,
    required this.notes,
    required this.date,
  });
}

class StudentManagementApp extends StatelessWidget {
  const StudentManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نظام إدارة الطلاب الاحترافي',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF2D3142),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ================= 1. شاشة تسجيل الدخول الاحترافية =================
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4E54C8), Color(0xFF8F94FB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4E54C8).withOpacity(0.4),
                              blurRadius: 25,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.verified_user_rounded, size: 50, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      'مرحباً بك أستاذنا الكريم',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'سجل الدخول لإدارة الحضور والشارات بكل إتقان',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم أو البريد',
                        prefixIcon: const Icon(Icons.person_rounded, color: Color(0xFF4E54C8)),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_rounded, color: Color(0xFF4E54C8)),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4E54C8), Color(0xFF8F94FB)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4E54C8).withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= 2. الشاشة الرئيسية الاحترافية لإدارة الطلاب =================
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Student> _students = [
    Student(id: '1', name: 'أحمد محمد الحارثي', attendanceStatus: 'حاضر', badges: ['المبدع', 'الحافظ المثالي'], notes: 'تلاوة متقنة وحفظ ممتاز', date: DateTime.now()),
    Student(id: '2', name: 'خالد علي العمري', attendanceStatus: 'غائب', badges: [], notes: 'تخلف عن الحلقة بدون عذر مسبق', date: DateTime.now()),
    Student(id: '3', name: 'عمر إبراهيم باوزير', attendanceStatus: 'معذور', badges: ['المشارك النشط'], notes: 'عذر مرضي رسمي معتمد', date: DateTime.now()),
    Student(id: '4', name: 'عبد الله صالح السقاف', attendanceStatus: 'متأخر', badges: [], notes: 'حضر متأخراً 10 دقائق', date: DateTime.now()),
  ];

  DateTime? _startDate;
  DateTime? _endDate;

  // عرض نافذة منبثقة بنسخ تقرير الواتساب لولي الأمر مباشرة
  void _showWhatsAppReportDialog(Student student) {
    String reportText = '''
📢 *نظام إدارة الطلاب والحضور*
السلام عليكم ولي الأمر الكريم لـ: *${student.name}*
إليك تقرير الأداء والحضور:
- 📌 حالة الحضور: *${student.attendanceStatus}*
- 🏅 الشارات المكتسبة: ${student.badges.isEmpty ? 'لا توجد' : student.badges.join(', ')}
- 📝 ملاحظات المعلم: ${student.notes}
- 📅 التاريخ: ${student.date.toLocal().toString().split(' ')[0]}
    ''';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تقرير ولي الأمر (واتساب)', textDirection: TextDirection.rtl),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('قم بنسخ التقرير وأرسله مباشرة عبر واتساب:', textDirection: TextDirection.rtl),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              child: SelectableText(reportText, textDirection: TextDirection.rtl),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Student> filteredStudents = _students.where((student) {
      if (_startDate == null || _endDate == null) return true;
      return student.date.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
             student.date.isBefore(_endDate!.add(const Duration(days: 1)));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الحضور والأداء المتقدم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range_rounded, color: Color(0xFF4E54C8)),
            tooltip: 'فلترة بالتاريخ',
            onPressed: _selectDateRange,
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            tooltip: 'تسجيل الخروج',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          if (_startDate != null && _endDate != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Text('الفترة: ${_startDate.toString().split(' ')[0]} إلى ${_endDate.toString().split(' ')[0]}'),
                  TextButton(
                    onPressed: () => setState(() { _startDate = null; _endDate = null; }),
                    child: const Text('إلغاء الفلتر', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];

                Color cardColor = Colors.white;
                Color borderColor = Colors.grey.withOpacity(0.2);
                if (student.attendanceStatus == 'غائب') {
                  cardColor = Colors.red.withOpacity(0.08);
                  borderColor = Colors.red.withOpacity(0.3);
                } else if (student.attendanceStatus == 'معذور') {
                  cardColor = Colors.purple.withOpacity(0.08);
                  borderColor = Colors.purple.withOpacity(0.3);
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFF4E54C8),
                                  child: Icon(Icons.person, color: Colors.white, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  student.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: student.attendanceStatus == 'غائب' ? Colors.red : (student.attendanceStatus == 'معذور' ? Colors.purple : Colors.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                student.attendanceStatus,
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.military_tech_rounded, size: 18, color: Colors.amber),
                            const SizedBox(width: 6),
                            Text('الشارات: ${student.badges.isEmpty ? 'لا توجد' : student.badges.join(', ')}',
                                style: const TextStyle(fontSize: 13, color: Colors.blueGrey)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.note_alt_rounded, size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text('الملاحظات: ${student.notes}',
                                  style: const TextStyle(fontSize: 13, color: Colors.grey)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton.icon(
                            onPressed: () => _showWhatsAppReportDialog(student),
                            icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                            label: const Text('تقرير واتساب', style: TextStyle(color: Colors.white, fontSize: 13)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF25D366),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}