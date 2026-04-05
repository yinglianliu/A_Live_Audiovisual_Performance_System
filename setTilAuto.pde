void setTilAuto() {
  tilAngle = constrain(
    round(sin(radians(map(myAudioData[dim+1], 60, myAudioMax, 0, 360))) * degree),
    autoTilMin, autoTilMax
  );
  for(int i = 0; i < 4; i++) dmxOutput.set(til + i*FIXTURE_STRIDE, int(tilAngle));
  if(debug) println("AutoTil: " + tilAngle);
}
