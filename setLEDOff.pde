void setLEDOff () {

  for(int i=43; i<228; i++) {
   
    dmxOutput.set(i,0);
     
  }

}
