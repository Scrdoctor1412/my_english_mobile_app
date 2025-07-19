import 'package:englens/src/ui/screens/home/progress_chart/progress_chart_screen_viewmode.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart/fl_chart.dart';

class ProgressChartScreen extends StatelessWidget {
  static const routeName = "/progressChartScreen";
  const ProgressChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressChartScreenViewmodel>(
      init: ProgressChartScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text("Chart"),
          );
        }

        FlTitlesData _titlesData() {
          return FlTitlesData(
            // Tiêu đề trục dưới (X)
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    // axisSide: meta.axisSide,
                    space: 4.0,
                    meta: meta,
                    child: Text(
                      controller.learningRecords[value.toInt()].learnDate!,
                    ),
                  );
                },
                // getTitlesWidget: (value, meta) {
                //   // Lấy tên viết tắt của ngày trong tuần (T2, T3,...)
                //   String text = '';
                //   if (value.toInt() < weeklyData.length) {
                //     final day = weeklyData[value.toInt()].date;
                //     // 'E' sẽ trả về Mon, Tue,... 'EEEE' sẽ trả về Monday,...
                //     // Chúng ta sẽ tự custom để ra T2, T3...
                //     switch (DateFormat('E').format(day)) {
                //       case 'Mon':
                //         text = 'T2';
                //         break;
                //       case 'Tue':
                //         text = 'T3';
                //         break;
                //       case 'Wed':
                //         text = 'T4';
                //         break;
                //       case 'Thu':
                //         text = 'T5';
                //         break;
                //       case 'Fri':
                //         text = 'T6';
                //         break;
                //       case 'Sat':
                //         text = 'T7';
                //         break;
                //       case 'Sun':
                //         text = 'CN';
                //         break;
                //     }
                //   }
                //   return SideTitleWidget(
                //     axisSide: meta.axisSide,
                //     space: 4.0,
                //     child: Text(text,
                //         style: const TextStyle(
                //             color: Colors.black54, fontSize: 14)),
                //   );
                // },
              ),
            ),
          );
        }

        List<BarChartGroupData> _createBarGroups() {
          return List.generate(
            controller.learningRecords.length <= 7
                ? controller.learningRecords.length
                : 7,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: controller.learningRecords[index].wordIds!.length
                      .toDouble(),
                  color: Colors.lightBlue,
                  gradient: const LinearGradient(
                    colors: [Colors.lightBlue, Colors.indigo],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  width: 20,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                )
              ],
            ),
          );
        }

        _body() {
          // return Center(
          //   child: Text('Hi'),
          // );
          return BarChart(
            BarChartData(
              barGroups: _createBarGroups(),
              titlesData: _titlesData(),
            ),

            duration: Duration(milliseconds: 150), // Optional
            curve: Curves.linear, // Optional
          );
        }

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }
}
