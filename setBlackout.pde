void setBlackout() {
  for(int i=1; i<40; i+=10){
  dmxOutput.set(i,0);
  }
}
