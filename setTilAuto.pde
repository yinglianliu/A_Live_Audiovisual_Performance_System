void setTilAuto() {
  //tilAngle = constrain(round(cos(radians(frameCount*0.1))*degree),72,180);
  //tilAngle = abs(round(tan(radians(frameCount*0.5))*180));
  
  //tilAngle = constrain(round(sin(radians(frameCount*0.2))*degree),autoTilMin,autoTilMax);
  
    //degree = map(myAudioData[dim+1],60,myAudioMax,250,2000);
    tilAngle = constrain(round(sin(radians(map(myAudioData[dim+1],60,myAudioMax,0,360)))*degree),autoTilMin,autoTilMax);
    //tilAngle = constrain(round(sin(radians(map(myAudioData[dim+1],60,myAudioMax,90,180)))*degree),autoTilMin,autoTilMax);

    //tilAngle = map((sin(radians(frameCount))*degree),0,degree,autoTilMin,autoTilMax);

  dmxOutput.set(til, int(tilAngle));
  dmxOutput.set(til+10, int(tilAngle));
  dmxOutput.set(til+20, int(tilAngle));
  dmxOutput.set(til+30, int(tilAngle));
  
  //println("AutoTil: " + tilAngle*(270/255));
  println("AutoTil: " + tilAngle);

}
