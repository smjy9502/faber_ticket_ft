import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/screens/main_screen.dart';
import 'package:faber_ticket_ft/screens/photo_screen.dart';
import 'package:faber_ticket_ft/screens/song_screen.dart';
import 'package:faber_ticket_ft/utils/constants.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  int _rating = 0; // 평점
  final TextEditingController reviewController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController rowController = TextEditingController();
  final TextEditingController seatController = TextEditingController();

  Future<void> saveData() async {
    try {
      Map<String, dynamic> data = {
        'rating': _rating,
        'review': reviewController.text,
        'section': sectionController.text,
        'row': rowController.text,
        'seat': seatController.text,
      };
      await _firebaseService.saveCustomData(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving data: $e')));
    }
  }

  Future<void> loadCustomData() async {
    try {
      final data = await _firebaseService.getCustomData();
      if (data != null) {
        setState(() {
          _rating = data['rating'] ?? 0;
          reviewController.text = data['review'] ?? '';
          sectionController.text = data['section'] ?? '';
          rowController.text = data['row'] ?? '';
          seatController.text = data['seat'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadCustomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.ticketBackImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Back 버튼 (화면 좌측 상단)
              Positioned(
                top: 3,
                left: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                ),
              ),

              // Save 버튼 (화면 우측 상단)
              Positioned(
                top: 5,
                right: 20,
                child: ElevatedButton(
                  onPressed: saveData,
                  child: Text('Save'),
                ),
              ),

              // Rate (평점 기능)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.58, // 이미지 위치를 아래로 이동
                left: MediaQuery.of(context).size.width * 0.5 - 120, // 이미지 위치 조정
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 이미지 간격 조정
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (index < _rating) {
                            _rating = index + 1;
                          } else if (index == _rating) {
                            _rating = index;
                          } else {
                            _rating = index + 1;
                          }
                        });
                      },
                      child: Image.asset(
                        index < _rating ? Constants.petalFullImage : Constants.petalEmptyImage,
                        width: 40, // 이미지 크기 조정
                        height: 40,
                      ),
                    );
                  }),
                ),
              ),


              // Review 입력
              Positioned(
                top: MediaQuery.of(context).size.height * 0.69, // 이미지 상의 "Review" 위치
                left: MediaQuery.of(context).size.width * 0.5 - 150,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: reviewController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Write your review",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              // Section, Row, Seat 입력
              Positioned(
                top: MediaQuery.of(context).size.height * 0.805, // 이미지 상의 "Section", "Row", "Seat" 위치
                left: MediaQuery.of(context).size.width * 0.18,
                right: MediaQuery.of(context).size.width * 0.18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: sectionController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Section",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: rowController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Row",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: seatController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Seat",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // SetList 버튼과 Photo 버튼 (화면 하단)
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02, // 약간 더 아래로 이동
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SongScreen()),
                        );
                      },
                      child: Text("SetList"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PhotoScreen()),
                        );
                      },
                      child: Text("Photo"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
