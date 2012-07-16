class DataSet {
  List<DataPoint> data;
  
  DataSet(this.data);
  
  DataSet.fromList(List<List<num>> list) {
    data = list.map((point) {
      if (point.length != 2) {
        throw new Exception('All datapoints must have 2 fields');
      }
      else {
        return new DataPoint(point[0], point[1]);
      }
    });
  }
  
  DataSet scale(DataPoint outputMins, DataPoint outputMaxs) {
    if (data.length <= 0) {
      return new DataSet([]);
    }
    var mins = new DataPoint(data[0].x, data[0].y);
    var maxs = new DataPoint(data[0].x, data[0].y);
    for (var i = 1; i < data.length; i++) {
      if (data[i].x < mins.x) {
        mins.x = data[i].x;
      }
      if (data[i].x > maxs.x) {
        maxs.x = data[i].x;
      }
      if (data[i].y < mins.y) {
        mins.y = data[i].y;
      }
      if (data[i].y > maxs.y) {
        maxs.y = data[i].y;
      }
    }
    var inputSize = maxs - mins;
    var outputSize = outputMaxs - outputMins;
    var scaled = data.map((p) {
      return ((p - mins) / inputSize) * outputSize + outputMins;
    });
    return new DataSet(scaled);
  }
}