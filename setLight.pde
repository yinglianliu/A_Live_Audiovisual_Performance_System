void setLight() {
  // Guard against invalid map() range when micSen is very low
  float shutterMax = max(myAudioMax * micSen, shutterCloseMin + 1);

///////////////////////////////Light 1(FrontLeft)//////////////////////////////////////////////
    dmxOutput.set(shutter,     int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(4,           255); //gobo swing, slow to fast
    dmxOutput.set(10,          250); //effect fast to slow
    dmxOutput.set(colorAdd,    int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));

///////////////////////////////Light 2(FrontRight)///////////////////////////////////////////
    dmxOutput.set(shutter+10,  int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(4+10,        255);
    dmxOutput.set(10+10,       250);
    dmxOutput.set(colorAdd+10, int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));

/////////////////////////////////Light 3(BackRight)///////////////////////////////////////////
    dmxOutput.set(shutter+20,  int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(4+20,        255); //gobo swing, slow to fast
    dmxOutput.set(10+20,       250); //effect fast to slow
    dmxOutput.set(colorAdd+20, int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));

//////////////////////////////Light 4(BackLeft)////////////////////////////////////////////////
    dmxOutput.set(shutter+30,  int(map(myAudioData[dim],   shutterCloseMin, shutterMax, 0, 38)));
    dmxOutput.set(4+30,        255); //gobo swing, slow to fast
    dmxOutput.set(10+30,       250); //effect fast to slow
    dmxOutput.set(colorAdd+30, int(map(myAudioData[dim+1], 0, myAudioMax*micSen, colorMin, colorMax)));
}
