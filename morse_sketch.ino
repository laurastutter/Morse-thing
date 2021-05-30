char val; // Data received from the serial port
boolean ledState = LOW; //to toggle our LED

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //serial communication with Processing in this baud rate
  pinMode(2, INPUT_PULLUP);//button is input
  pinMode(9, OUTPUT);//LED is output - to be turned on.
  pinMode(10, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  int pusshed = digitalRead(2); //by default it is high
  if (pusshed == LOW) { //when pushed, when low, send voltage to pin 10
    digitalWrite(10, HIGH);
    Serial.println("1");
  } else {
    digitalWrite(10, LOW);
    Serial.println("0");
  }
  delay(10);
  if (Serial.available() > 0){ //if data is available to read
    val = Serial.read(); //read data and store it in val
    if (val == '1') {
        digitalWrite(9, HIGH);
      } else if (val == '0'){
        digitalWrite(9, LOW );
      }
    }
  delay(10);

}
