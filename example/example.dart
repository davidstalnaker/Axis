#import('dart:html');
#import('../lib/chart.dart');

void main() {
  var chart = new Chart(400, 800, document.query('#chart'));
  var xhr = new XMLHttpRequest.get('example.csv', (res) {
    if (res.status == 200) {
      chart.drawLineGraph(new DataSet.fromCsv(res.responseText));
    }
  });
  chart.drawLineGraph(new DataSet.fromList([[0,0], [1,5], [2,3], [3,7], [4,5]]));
}