import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  //imported

class CustomBarChart extends StatelessWidget {
  final Map<String, int> stepsData;  //holds the steps count data for each day of the week.
  final double barWidth;
  final Color barColor;
  final Color containerColor;
  final Size size; 

  //Create a flutter widget class
  //Parameters included
  const CustomBarChart({
    Key? key,
    required this.stepsData,
    this.barWidth = 12.0,
    this.barColor = Colors.orange,
    this.containerColor = const Color(0xFFFFFFFF),
    this.size = const Size(300, 200), // Default size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,    //By default is transparent
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Last Week",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                //Barchart starts here
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(  //On touch
                        tooltipBgColor: Colors.transparent, //Background of number
                        tooltipMargin: 0,
                        getTooltipItem: (
                          group,            //representing the group of bars that the touched bar belongs to. 
                          groupIndex,       //The index of the BarChartGroupData in the list of bar groups  
                          rod,              //the number of the specific bar that was touched
                          rodIndex,          //index of the BarChartRodData in the list of rods (bars) within that group
                        ) {
                          return BarTooltipItem(
                            rod.toY.round().toString(),
                            const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            );
                            Widget text;
                            switch (value.toInt()) {  //Columns of the graph
                              case 0:
                                text = const Text('Mon', style: style);
                                break;
                              case 1:
                                text = const Text('Tues', style: style);
                                break;
                              case 2:
                                text = const Text('Wed', style: style);
                                break;
                              case 3:
                                text = const Text('Thur', style: style);
                                break;
                              case 4:
                                text = const Text('Fri', style: style);
                                break;
                              case 5:
                                text = const Text('Sat', style: style);
                                break;
                              case 6:
                                text = const Text('Sun', style: style);
                                break;
                              default:
                                text = const Text('', style: style);
                                break;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: text,
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,      //Don't show y-intercept
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),  //Don't show barGraph index
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),    //Don't show y-intercept on the right
                      ),
                    ),
                    borderData: FlBorderData(show: false),      //Don't show box
                    gridData: FlGridData(show: false),          //Don't show grid
                    barGroups: [
                      BarChartGroupData(
                        x: 0,       //This is the groupIndex
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Monday']?.toDouble() ?? 0,    //Y-value of the graph
                            color: barColor,                              //Bar-color (Can be controlled in parameter)
                            width: barWidth,                              //Bar-width (Can be controlled in parameter)
                            borderRadius: const BorderRadius.only(        //Edges of the graphgs
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Tuesday']?.toDouble() ?? 0,
                            color: barColor,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Wednesday']?.toDouble() ?? 0,
                            color: barColor,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Thursday']?.toDouble() ?? 0,
                            color: barColor,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Friday']?.toDouble() ?? 0,
                            color: barColor,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Saturday']?.toDouble() ?? 0,
                            color: barColor,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(
                            toY: stepsData['Sunday']?.toDouble() ?? 0,
                            color: barColor,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
