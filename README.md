# Morse-thing
These are all the sketches in progress. 
<p> <strong>morse_sketch.pde</strong> is connecting Processing and Arduino and sending the information through MQTT but it was made to prove the connection (Arduino Processing and Procesisng MQTT) possible and had to be changed in order to be able to actually establish a morse system through MQTT: to reconfigure how the serial signal is being translated into morse. </p>
<p><strong>morse_sketch_just_ino.pde</strong> tries to bypass this problem by not having a Processing interface that also sends messages through MQTT. This should have been made only with Arduino but not having a WiFi antenna module dificults this and I don't quite understand how to do it by using Processing. It is ALMOST working but the messages-recieved function is not working completely.  </p>
<p><strong>morse_sketch_no_ino.pde</strong> works. Just not with Arduino. Does effectively pass messages from one end to another. 
