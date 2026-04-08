void moirePattern() {
  pa1.beginDraw();

  // Audio bands: 1=red, 2=blue, 3=green (consistent across all patterns)
  colorR = map(myAudioData[1], 0, myAudioMax*micSen, 0, 255);
  colorG = map(myAudioData[3], 0, myAudioMax*micSen, 0, 255);
  colorB = map(myAudioData[2], 0, myAudioMax*micSen, 0, 255);

  pa1.strokeWeight(yStep/2);
  pa1.background(int(colorR*redOSC), int(colorG*greenOSC), int(colorB*blueOSC));
  pa1.blendMode(DIFFERENCE);

  for(int n=0; n<1; n++) {
    for(int y = mY; y <= height - mY; y += yStep) {
      pa1.line(mX, y, width-mX, y);
      pa1.bezier(mX, y, width/2-n1, y-n2, 2*width/3+n3, y+n3, width-mX+n2, y);

      n1off += map(myAudioData[1], 0, myAudioMax*micSen, 0.0, n1offMax);
      n2off += map(myAudioData[2], 0, myAudioMax*micSen, 0.0, n2offMax);
      n3off += map(myAudioData[3], 0, myAudioMax*micSen, 0.0, n3offMax);

      n1 = noise(n1off) * noiseScale;
      n2 = noise(n2off) * noiseScale;
      n3 = noise(n3off) * noiseScale;
    }
  }
  pa1.endDraw();
}
