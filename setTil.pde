void setTil() {
  
  //til start at 180

  //tilAngle = floor(map(tilOSC,0,1,0,255));

  dmxOutput.set(til, int(tilAngle));
  dmxOutput.set(til+10, int(tilAngle));
  dmxOutput.set(til+20, int(tilAngle));
  dmxOutput.set(til+30, int(tilAngle));
  
  //println("Mannul Til: " + tilAngle * (270/255));
  println("Mannul Til: " + tilAngle);

}
