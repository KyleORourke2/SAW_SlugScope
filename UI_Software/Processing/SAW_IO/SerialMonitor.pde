// Serial Monitor class:
// Location of serial I/O readout. Should be at bottom of the screen

// Written by Kyle O'Rourke
// ktorourk@ucsc.edu
// Latest change: 5/27/2019


class SerialMonitor {
  int xpos;
  int ypos;
  int Height = SerialMonitorHeight; // Thickness of the header.
  int Width = width-1; // should span entire width.
  String[] serialBuffer = {}; // Need to init one value for some reason...
  
  SerialMonitor(int x, int y){
    xpos = x;
    ypos = y;
  }
  
  void display(String newSerial){
    
    // Bounding box:
    stroke(SerialMonitorBorder);
    strokeWeight(2);
    fill(SerialMonitorFill);
    rect(xpos, ypos, Width, Height);
    fill(SerialMonitorBorder);
    rect(xpos, ypos - (Height/2)+10, Width, 30);

    // Upper Information text bar:
    fill(255);
    textSize(20);
    textAlign(RIGHT, CENTER);
    text(serialPort, xpos + (Width/2)-5, ypos - (Height/2)+8);
    textAlign(LEFT, CENTER);
    text("Serial Monitor", xpos - (Width/2)+5, ypos - (Height/2)+8);    
    
    
    // EVERYTHING TO DO WITH 'FAKE' SERIAL PORT:
    
    // Get new value and add to buffer array:
    if(newSerial != null){
      serialBuffer = reverse(serialBuffer); // Flips the data since append only puts it on the end.
      serialBuffer = append(serialBuffer, newSerial);
      serialBuffer = reverse(serialBuffer);
    }
    
    // Print the values in our serial terminal box in ascending order.
    for(int i = 0; i < serialBuffer.length && i < 8; i++){
      text(serialBuffer[i], xpos - (Width/2)+5, ypos + ((Height/2)-17) - 21*i);
    }
    
    // Delete values from serialBuffer to keep memory usage low:
    if(serialBuffer.length >= 9){
      serialBuffer = shorten(serialBuffer);
    }
    
    textAlign(CENTER, CENTER);
  }

  // Serial port grab incomming data:
  // THIS FUNCTION IS BAD SINCE IT CAN MISS INCOMMING DATA! (I think?)
  // However, It is not used in the graphing function and only really is for
  // displaying that data is comming in. :D
  String getSerial(){
    if(bioPort.available() > 0){
      String inBuffer = bioPort.readStringUntil('\n');  // Read until newline.
      if(inBuffer != null){
        return inBuffer;
      }
      else{
        return null;
      }
    }
    else{
      return null;
    }
  }


  // Check if a click is in the header box.
  boolean wasClicked(int mx, int my){
    if(mx >= xpos && mx <= xpos + Width){
      if(my >= ypos && my <= ypos + Height){
        return true;
      }
    }
    return false; // Didn't meet both conditions
  }
  
  // Check if the was clicked location has an action
  private void click(int mx, int my){

  }
  
}
