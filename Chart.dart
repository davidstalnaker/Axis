#library('Chart');

#import('dart:html');

class Chart {
  num height, width;
  Element parent;
  SVGElement svg;
  
  Chart(this.height, this.width, this.parent) {
    svg = new SVGElement.tag('svg');
    svg.attributes['xmlns'] = 'http://www.w3.org/2000/svg';
    svg.attributes['height'] = '${height}px';
    svg.attributes['width'] = '${width}px';
    parent.nodes.add(svg);
  }
  
  void drawLineGraph(List<DataPoint> points) {
    svg.nodes.clear();
    points = scale(points, new DataPoint(10, 10), new DataPoint(width - 10, height - 10));
    var graph = new SVGElement.tag('path');
    var pathPoints = new StringBuffer('M ');
    pathPoints.add(Strings.join(points.map((p) => '${p.x} ${height - p.y}'), ' L '));
    graph.attributes = {'fill': 'none', 'stroke': '#aaaaaa', 'd': pathPoints, 'stroke-width': '8', 
                        'stroke-linejoin': 'round', 'stroke-linecap':'round'};
    svg.nodes.add(graph);
    for (var p in points) {
      var circle = new SVGElement.tag('circle');
      circle.attributes = {'fill': '#aaaaaa', 'cx': '${p.x}', 'cy': '${height - p.y}', 'r': '8'};
      circle.on.mouseOver.add((e) {
        print(p.x);
        print(p.y);
      });
      svg.nodes.add(circle);
    }
  }
}

class DataPoint {
  num x, y;
  
  DataPoint(this.x, this.y);
  
  DataPoint operator +(DataPoint other) => new DataPoint(this.x + other.x, this.y + other.y);
  DataPoint operator -(DataPoint other) => new DataPoint(this.x - other.x, this.y - other.y);
  DataPoint operator *(DataPoint other) => new DataPoint(this.x * other.x, this.y * other.y);
  DataPoint operator /(DataPoint other) => new DataPoint(this.x / other.x, this.y / other.y);
}

List<DataPoint> scale(List<DataPoint> input, DataPoint outputMins, DataPoint outputMaxs) {
  if (input.length <= 0) {
    return input;
  }
  var mins = new DataPoint(input[0].x, input[0].y);
  var maxs = new DataPoint(input[0].x, input[0].y);
  for (var i = 1; i < input.length; i++) {
    if (input[i].x < mins.x) {
      mins.x = input[i].x;
    }
    if (input[i].x > maxs.x) {
      maxs.x = input[i].x;
    }
    if (input[i].y < mins.y) {
      mins.y = input[i].y;
    }
    if (input[i].y > maxs.y) {
      maxs.y = input[i].y;
    }
  }
  var inputSize = maxs - mins;
  var outputSize = outputMaxs - outputMins;
  return input.map((p) {
    return ((p - mins) / inputSize) * outputSize + outputMins;
  });
}