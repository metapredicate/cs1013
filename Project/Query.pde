class Query
{
  String search;
  String type;

  Query(String search, String type)
  {
    //read data restricted by "domain".
    String[] xAxis = {};
    int[] yAxis = {};

    //averagePricesByArea (areas, averageOfArea) [barChart]
    //averageOverTime (time, averagePrice) [barChart]
    //top10 / bottom10 (properties, valuesOfProperties) [barChart, pieChart(?)]
    //typeOfHouse [pieChart]
    //range [text]
  }

  float [] getTopTen() {
    db.query( "SELECT * FROM registry ORDER BY Price DESC LIMIT 10" );
    int maxValue=0;
    float [] temp = new float[10];
    for (int i=0; i<10; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
        if (temp[i]>maxValue) 
        {
          maxValue = int(temp[i]);
        }
      }
    }
    return temp;
  } 
  float [] getBottomTen() {
    db.query( "SELECT * FROM registry ORDER BY Price ASC LIMIT 10" );
    int maxValue=0;
    float [] temp = new float[10];
    for (int i=0; i<10; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
        if (temp[i]>maxValue) 
        {
          maxValue = int(temp[i]);
        }
      }
    }
    return temp;
  } 
  float average() {
    String county = "TYNE AND WEAR";
    int average=0;
    db.query("SELECT AVG(Price) From registry WHERE County = '"+county+"'");
    if (db.next())
      average = db.getInt(1);
    println(average);
    return float(average);
  }
  float [] averageOverTime() {
    String county = t.getValue();
    county = county.toUpperCase();
    println(county);
    float[] average = new float[10];
    for (int i=0; i<20; i++) {
      db.query("SELECT AVG(Price) From registry WHERE County = '"+county+"' AND Date>='"+(1995+i)+"-01-01 00:00' and Date< '"+(1996+i)+"-01-01 00:00'");
      if (db.next())
        average[i] = db.getFloat(1);
      println(average+" "+(1995+i));
    }
    return (average);
  }
  float getRange() {
  
  }
  String info() {
    
  }
  
}