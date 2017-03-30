class Query
{
  String search;
  String type;
  SQLite db;
  Query(String search, String type)
  {
    //read data restricted by "domain".
    this.search = search;
    this.type = type;
    //averagePricesByArea (areas, averageOfArea) [barChart]
    //averageOverTime (time, averagePrice) [barChart]
    //top10 / bottom10 (properties, valuesOfProperties) [barChart, pieChart(?)]
    //typeOfHouse [pieChart]
    //range [text]
  }

  float [] getTop(int numberToReturn) {
    db.query( "SELECT * FROM registry ORDER BY Price DESC LIMIT "+numberToReturn );
    float [] temp = new float[numberToReturn];
    for (int i=0; i<numberToReturn; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
        println(temp[i]);
      }
    }
    return temp;
  } 
  float [] getBottomTen() {
    db.query( "SELECT * FROM registry ORDER BY Price ASC LIMIT 10" );
    float [] temp = new float[10];
    for (int i=0; i<10; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      }
    }
    return temp;
  } 
  float average() {

    int average=0;
    db.query("SELECT AVG(Price) From registry WHERE "+type+" = '"+search+"'");
    if (db.next())
      average = db.getInt(1);
    println(average);
    return float(average);
  }
  float [] averageOverTime() {
    float[] average = new float[10];
    for (int i=0; i<20; i++) {
      db.query("SELECT AVG(Price) From registry WHERE "+type+" = '"+search+"' AND Date>='"+(1995+i)+"-01-01 00:00' and Date< '"+(1996+i)+"-01-01 00:00'");
      if (db.next()){
        average[i] = db.getFloat(1);
      println(average+" "+(1995+i));
      }
    }
    return (average);
  }
  float getMin() {
    float min =0;
    db.query("SELECT MIN(Price) From registry WHERE "+type+" = '"+search+"'");
    if (db.next())
      min = db.getInt(1);
    println(min);  
    return min;
  }
  float getMax() {
    float max =0;
    db.query("SELECT MAX(Price) From registry WHERE "+type+" = '"+search+"'");
    if (db.next())
      max = db.getInt(1);
    println(max);  
    return max;
  }
  
  float getRange() {
    float range = getMax()-getMin();
    println(range+" range");
    return range;
  }
  String info() {
    return null;
  }
  
}