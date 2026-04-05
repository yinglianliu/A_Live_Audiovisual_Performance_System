// DMX channel offsets within each fixture block (10 channels per fixture)
final int FIXTURE_STRIDE = 10;
final int GOBO_OFFSET    = 3;  // gobo channel   = shutter + 3  (ch4, 14, 24, 34)
final int EFFECT_OFFSET  = 9;  // effects channel = shutter + 9  (ch10, 20, 30, 40)

void setLight() {
  // Guard against invalid map() range when micSen is very low
  float shutterMax = max(myAudioMax * micSen, shutterCloseMin + 1);

///////////////////////////////Light 1(FrontLeft)//////////////////////////////////////////////
    dmxOutput.set(shutter,                                int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(shutter + GOBO_OFFSET,                  255); //gobo swing, slow to fast
    dmxOutput.set(shutter + EFFECT_OFFSET,                250); //effect fast to slow
    dmxOutput.set(colorAdd,                               int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));

///////////////////////////////Light 2(FrontRight)///////////////////////////////////////////
    dmxOutput.set(shutter + FIXTURE_STRIDE,               int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(shutter + GOBO_OFFSET   + FIXTURE_STRIDE, 255);
    dmxOutput.set(shutter + EFFECT_OFFSET + FIXTURE_STRIDE, 250);
    dmxOutput.set(colorAdd                + FIXTURE_STRIDE, int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));

/////////////////////////////////Light 3(BackRight)///////////////////////////////////////////
    dmxOutput.set(shutter + 2*FIXTURE_STRIDE,               int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(shutter + GOBO_OFFSET   + 2*FIXTURE_STRIDE, 255);
    dmxOutput.set(shutter + EFFECT_OFFSET + 2*FIXTURE_STRIDE, 250);
    dmxOutput.set(colorAdd                + 2*FIXTURE_STRIDE, int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));

//////////////////////////////Light 4(BackLeft)////////////////////////////////////////////////
    dmxOutput.set(shutter + 3*FIXTURE_STRIDE,               int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(shutter + GOBO_OFFSET   + 3*FIXTURE_STRIDE, 255);
    dmxOutput.set(shutter + EFFECT_OFFSET + 3*FIXTURE_STRIDE, 250);
    dmxOutput.set(colorAdd                + 3*FIXTURE_STRIDE, int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));
}
