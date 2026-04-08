void setBlackout() {
  for(int i = 0; i < 4; i++) dmxOutput.set(shutter + i*FIXTURE_STRIDE, 0);
}
