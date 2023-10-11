void setPan() {
  //float panAngle = (sin(frameCount))*255;
  //float panAngleRe = (cos(frameCount))*255;
  //dmxOutput.set(pan+20, int(panAngle));
  //dmxOutput.set(pan+30, int(panAngleRe));
  //println(panAngle);
  //println(panAngleRe);
  
  //pan start at 150
  //panAngle = floor(map(panOSC,0,1,0,255));
    
  dmxOutput.set(pan, int(panAngle));
  dmxOutput.set(pan+10, int(panAngle));
  dmxOutput.set(pan+20, int(panAngle));
  dmxOutput.set(pan+30, int(panAngle));
  
  //println("Mannul Pan: " + panAngle * (540/255));
  println("Mannul Pan: " + panAngle);

}
