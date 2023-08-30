import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // キーボードが出てきても画面が崩れないようにする
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                // ダイアログを出して入力する
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    final TextEditingController controller =
                        TextEditingController();
                    return AlertDialog(
                      title: const Text('メモを入力してください'),
                      content: TextField(
                        controller: controller,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('calendar')
                                .add({
                              'date': Timestamp.fromDate(_selectedDay!),
                              'memo': controller.text,
                            });
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                print("Error adding document: $e");
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay, // どの日付を選択したか
            firstDay: DateTime(1990), // 最初に利用可能な日付
            lastDay: DateTime(2050), // 最後に利用可能な日付
            calendarFormat: _calendarFormat,
            // カレンダーウィジェットに以下のコードを追加すると、ユーザーのタップに反応し、
            // タップされた日を選択されたようにマークします
            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day), // 選択された日付をマークする
            onDaySelected: (selectedDay, focusedDay) {
              // 日付が選択されたときに呼び出される
              _focusedDay = focusedDay;
              _selectedDay = selectedDay;
              setState(() {});
            },
          ),
          // StreamBuilderを使って、Firestoreのcalendarコレクションのデータを取得する
          // StreamBuilderを使って、Firestoreのcalendarコレクションのデータを取得する
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('calendar').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // calendarコレクションのデータを取得する
                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;

                // 選択された日付と一致するドキュメントだけをフィルタリング
                final List<QueryDocumentSnapshot> filteredDocuments =
                    documents.where((doc) {
                  final date = (doc['date'] as Timestamp).toDate();
                  return isSameDay(_selectedDay, date);
                }).toList();

                // calendarコレクションのデータを日付順に並び替える
                filteredDocuments
                    .sort((a, b) => a['date'].compareTo(b['date']));

                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredDocuments.length,
                    itemBuilder: (context, index) {
                      // calendarコレクションのデータを取得する
                      final document = filteredDocuments[index];
                      // calendarコレクションのデータをDateTime型に変換する
                      final date = (document['date'] as Timestamp).toDate();
                      // calendarコレクションのデータを表示する
                      return ListTile(
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('calendar')
                                .doc(document.id)
                                .delete();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        title: Text(document['memo']),
                        subtitle:
                            Text('${date.year}/${date.month}/${date.day}'),
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
