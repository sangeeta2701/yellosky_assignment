import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';



class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  // Dummy data: projects per weekday
  final Map<int, int> projectsPerDay = const {
    0: 5,  
    1: 3, 
    2: 4,  
    3: 6,  
    4: 2,  
    5: 4,  
    6: 1,  
  };

  static const List<String> weekdays = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
  ];

  @override
  Widget build(BuildContext context) {
    // Convert map to spots for the chart
    List<FlSpot> spots = projectsPerDay.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
        .toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Projects Added Over Week", style: appBarStrle),
        backgroundColor: themeColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Projects Added Each Day",
              style: blackContentStyl,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 300.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < 0 || value.toInt() > 6) return Container();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              weekdays[value.toInt()],
                              style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black26),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: themeColor,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minY: 0,
                  maxY: 7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
