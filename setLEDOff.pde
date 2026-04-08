void setLEDOff() {
  for(int i = ledStartChannel; i <= ledEndChannel; i++) dmxOutput.set(i, 0);
}
