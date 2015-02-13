import org.firmata.*;
import cc.arduino.*;


//create json object, which will store the json file
JSONObject json;
String myURL = "https://www.kimonolabs.com/api/38lcd9rw?apikey=No7h5YUcyCWbbn7xjG0ukUrDZTpjWFUU";

Arduino arduino;

int ledPin = 9;

void setup() {
  json = loadJSONObject(myURL);
  //println(json);
  background(255);
  size(460, 320);
  loaddata();

  println(Arduino.list());

  arduino = new Arduino( this, Arduino.list()[7], 57600 );
}



void loaddata() {
  JSONObject results = json.getJSONObject("results");

  JSONArray collection = results.getJSONArray("collection1");

  int sizeOfCollection = collection.size();


  for (int i = 0; i < sizeOfCollection; i++)
  {
    JSONObject quake = collection.getJSONObject(i);
    float mag = quake.getFloat("");
    JSONObject location = quake.getJSONObject("location");
    String loc = location.getString("text");
    println(mag);
    println(loc);

    int magnitude = quake.size();

    if (magnitude > 1 ) {

      for (int fadeValue = 0; fadeValue <= magnitude*20; fadeValue +=5) { 
        arduino.analogWrite(ledPin, fadeValue);         
        delay(30);
      } 

      for (int fadeValue = magnitude*20; fadeValue >= magnitude*20; fadeValue -=5) { 
        arduino.analogWrite(ledPin, fadeValue);         
        delay(30);
      }
    }
  }
}

