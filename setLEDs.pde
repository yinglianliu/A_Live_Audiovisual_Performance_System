//6 LED Bars.

void setLEDs() {
    redLED = int(map(myAudioData[1],30,myAudioMax*micSen,0,255));
    greenLED = int(map(myAudioData[3],30,myAudioMax*micSen,0,255));
    blueLED = int(map(myAudioData[2],30,myAudioMax*micSen,0,255));
    
   //int redLED = int(map(myAudioData[1],0,myAudioMax,0,255));
   //int greenLED = int(map(myAudioData[3],0,myAudioMax,0,255));
   //int blueLED = int(map(myAudioData[2],0,myAudioMax,0,255));
   
   ////red LED
   // for(int i=43; i<85; i+=3){
   //   dmxOutput.set(i,redLED);
   // }
    
   // //green LED
   // for(int i=44; i<86; i+=3){
   //   dmxOutput.set(i,greenLED);
   // }
    
   // //blue LED
   // for(int i=45; i<87; i+=3){
   //   dmxOutput.set(i,blueLED);
   // }
    
   //    //red LED
   // for(int i=88; i<111-2; i+=3){
   //   dmxOutput.set(i,redLED);
   // }
    
   // //green LED
   // for(int i=89; i<111-1; i+=3){
   //   dmxOutput.set(i,greenLED);
   // }
    
   // //blue LED
   // for(int i=90; i<111; i+=3){
   //   dmxOutput.set(i,blueLED);
   // }
    
       //red LED
    for(int i=43; i<226; i+=3){
      dmxOutput.set(i,int(redLED*redLEDOSC));
    }
    
    ////green LED for TouchOSC
    //for(int i=44; i<86; i+=3){
    //  dmxOutput.set(i,int(greenLEDOSC));
    //}
    
    //green LED
    for(int i=44; i<227; i+=3){
      dmxOutput.set(i,int(greenLED*greenLEDOSC));
    }
    
    //blue LED
    for(int i=45; i<228; i+=3){
      dmxOutput.set(i,int(blueLED*blueLEDOSC));
    }
    
    //println(redLED);
}
