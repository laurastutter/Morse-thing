import processing.serial.*;
import mqtt.*;
MQTTClient client;
Serial myPort;       
boolean lightOn = false;
boolean plightOn = false;

//serial port light on should be the button in this case and the light on the rigth should 
//be triggered when in the MESSAGE RECEIVED
void setup () {
  size(400, 300);
  background(25, 79, 99);
  //rect(0, 0, width/2, height);
  //fill(100);
  //rect(width/2, 0, width, height);  //write text that says press to lit here in middle of second square.
  //  println(Serial.list()); // List all the available serial ports // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.bufferUntil('\n');
  client = new MQTTClient(this);
  client.connect("mqtt://public:public@public.cloud.shiftr.io", "laura");
}
void draw () {
  //will be called only if lighton has changed since last loop
  //println("before conditinal lighton",lightOn);
  // println("before conditinal plighton",plightOn);
  //Publish the changes of state through MQTT - 
  if (lightOn!=plightOn) {
    if (lightOn==true) {
      client.publish("/morse", "1");//Or is it off or do I need to create conditional?
      //println("1");
      //myPort.write('1');
    } else {
      client.publish("/morse", "0");
      //println("0");
      //myPort.write('0');
    }
  }
  plightOn = lightOn;

    if (lightOn) {
      fill(25, 79, 99);
      rect(0, 0, width/2, height);
      //myPort.write('1');
      //send mqtt message here
    } else {
      //and here
      fill(25);
      rect(0, 0, width/2, height);
      //myPort.write('0');
      
    }
}
//void mousePressed() {
//  if (mouseX > width/2) {
//    fill(125, 79, 199);
//    rect(width/2, 0, width, height);
//    client.publish("/morse", "1");
//    //   myPort.write('1');
//  }
//}
//void mouseReleased() {
//  if (mouseX > width/2) {
//    fill(100);
//    rect(width/2, 0, width, height);
//    client.publish("/morse", "0");
//    //   myPort.write('0');
//  }
//}


//to get my messages from the arduino board through the USB port and send
void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {

    // NI IDEA ¿? --> trim off any whitespace:
    inString = trim(inString);
    //here is where we change the state of the light with the incoming message 
    if (inString.length()>0) {
      if (inString.equals("0")) {
        //fill(100);
        //rect(width/2, 0, width, height);
        //client.publish("/morse", "0");
        myPort.write('0');
        lightOn = false;
      } else if (inString.equals("1")) {
        //fill(100);
        //rect(width/2, 0, width, height);
        //client.publish("/morse", "1");
        myPort.write('1');
        lightOn = true;
      }
      //println("serial event",inString);
    }
  }
}

void clientConnected() {
  println("client connected");
  client.subscribe("/morse");
}
void connectionLost() {
  println("connection lost");
}
void messageReceived(String topic, byte[] payload) {
  String string = new String(payload);
  if (topic.equals("/morse")) {
    if (string.equals("0")) {
      println("0");
      fill(25);
      rect(0, 0, width/2, height);  
      lightOn = false;
    } else if (string.equals("1")) {
      println("1");
      fill(25, 79, 99);
      rect(0, 0, width/2, height);
      lightOn = true;
    }
  }
}

//ACI ES ON HAS DE FICAR LA LLUM QUE S'IL·LUMINA AMB ELS MISSATGES DE TEXT 
//ENVIATS DESDE MQTT QUE ESCRIGUEN 1
