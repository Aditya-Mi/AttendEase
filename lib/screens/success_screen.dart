import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:attendease/widgets/function_button.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool _isCollapse = false;
  @override
  void initState() {
    super.initState();
    collapseScreen();
  }

  void collapseScreen() async {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isCollapse = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isCollapse
          ? AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 18, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.bg200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text1('Subject Name'),
                      text2('Microwave Engineering'),
                      text1('Semester'),
                      text2('7th Sem'),
                      text1('Branch'),
                      text2('ECE'),
                      text1('Section'),
                      text2('7E4'),
                      const SizedBox(
                        height: 8,
                      ),
                      const CustomDivider(
                        color: Color(0xffD5D5D5),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      text3('Total Number of Students : 40'),
                      const SizedBox(
                        height: 21,
                      ),
                      text3('Number of Student Present : 20 '),
                      const SizedBox(
                        height: 21,
                      ),
                      text3('Number of Student Absent :20'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 21),
                        child: CustomDivider(
                          color: Color(0xffD5D5D5),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FunctionButton(
                            icon: Icons.share_outlined,
                            text: text1('Share'),
                          ),
                          const SizedBox(
                            width: 41,
                          ),
                          FunctionButton(
                            icon: Icons.edit_outlined,
                            text: text1('Edit'),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          FunctionButton(
                            icon: Icons.keyboard_return,
                            text: text1('Return Home'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  scale: 1.6,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'Powered by AttendEase',
                  style: AppText.textStyle(
                      color: const Color(0xff969696), size: 12.94),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: _isCollapse ? null : 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              color: AppColors.accent200,
              width: double.infinity,
              height: _isCollapse ? 100 : MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: _isCollapse
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Attendance Recorded',
                    style: AppText.textStyle(color: Colors.white, size: 20),
                  ),
                  Text(
                    'Successfully',
                    style: AppText.textStyle(color: Colors.white, size: 27)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  _isCollapse ? const Spacer() : const SizedBox(),
                  _isCollapse
                      ? Text(
                          '09 Mar 2024, 12:45 pm',
                          style: AppText.textStyle(
                              color: AppColors.bg200, size: 12.95),
                        )
                      : const SizedBox(),
                  _isCollapse
                      ? const SizedBox(
                          height: 9,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget text1(String text) {
    return Text(
      text,
      style: AppText.textStyle(color: AppColors.text200, size: 12.94),
    );
  }

  Widget text2(String text) {
    return Text(
      text,
      style: AppText.textStyle(color: AppColors.text100, size: 16.18),
    );
  }

  Widget text3(String text) {
    return Text(
      text,
      style: AppText.textStyle(color: AppColors.text100, size: 17)
          .copyWith(fontWeight: FontWeight.w400),
    );
  }
}
