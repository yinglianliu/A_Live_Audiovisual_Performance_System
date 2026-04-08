/* https://processing.org/tutorials/video */

void liveCam() {
  dotSize2 = map(myAudioData[dim], 0, myAudioMax*micSen, 2, dotSizeMax);

  // Audio bands: 1=red, 2=blue, 3=green (consistent with all patterns)
  colorRTarget = map(myAudioData[1], 0, myAudioMax*micSen, 0, 255);
  colorGTarget = map(myAudioData[3], 0, myAudioMax*micSen, 0, 255);
  colorBTarget = map(myAudioData[2], 0, myAudioMax*micSen, 0, 255);

  diffColorR  = colorRTarget - colorR;  colorR  += diffColorR  * easingCam;
  diffColorG  = colorGTarget - colorG;  colorG  += diffColorG  * easingCam;
  diffColorB  = colorBTarget - colorB;  colorB  += diffColorB  * easingCam;
  diffDotSize = dotSize2 - dotSize;     dotSize += diffDotSize * easingCam;

  cameraV.beginDraw();
  cameraV.fill(colorR*redOSC, colorG*greenOSC, colorB*blueOSC, transparencyCam);
  cameraV.noStroke();
  cameraV.rect(0, 0, cameraV.width*videoScale, cameraV.height*videoScale);
  cameraV.blendMode(DIFFERENCE);

  video.loadPixels();
  for(int i = 0; i < cols; i += 2) {
    for(int j = 0; j < rows; j += 2) {
      x   = i * videoScale;
      y   = j * videoScale;
      loc = (video.width - i - 2) + j * video.width;
      c   = video.pixels[loc];
      sz  = (cameraV.brightness(c) / 255) * videoScale * dotSize;
      cameraV.fill(255, transparencyCam);
      cameraV.noStroke();
      cameraV.ellipse(x + videoScale, y + videoScale, sz, sz);
    }
  }
  cameraV.endDraw();
}
