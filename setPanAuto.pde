void setPanAuto() {
  panAngle = constrain(
    round(sin(radians(map(myAudioData[dim+2], 60, myAudioMax, 0, 360))) * degree),
    autoPanMin, autoPanMax
  );
  for(int i = 0; i < 4; i++) dmxOutput.set(pan + i*FIXTURE_STRIDE, int(panAngle));
  if(debug) println("AutoPan: " + panAngle);
}
