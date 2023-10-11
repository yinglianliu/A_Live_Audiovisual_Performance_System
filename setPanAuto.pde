void setPanAuto() {
  //float a = map(myAudioData[2],0,myAudioMax,0,1);
  //panAngle = constrain(round(sin(radians(frameCount*0.1))*degree),128,255);
  //panAngle = abs(round(tan(radians(frameCount*0.5))*150));
    
       //autoPanMin = floor(map(autoPanMinOSC,0,1,0,255));
       //autoPanMax = floor(map(autoPanMaxOSC,0,1,0,255));
       //degree = map(myAudioData[dim],myAudioMax-30,myAudioMax,250,400);
       
  //panAngle = constrain(round(sin(radians(frameCount*0.01))*degree),autoPanMin,autoPanMax);
  panAngle = constrain(round(sin(radians(map(myAudioData[dim+2],60,myAudioMax,0,360)))*degree),autoPanMin,autoPanMax);

  dmxOutput.set(pan, int(panAngle));
  dmxOutput.set(pan+10, int(panAngle));
  dmxOutput.set(pan+20, int(panAngle));
  dmxOutput.set(pan+30, int(panAngle));
  
  //println("AutoPan: " + panAngle *(540/255));
  println("AutoPan: " + panAngle);

}
