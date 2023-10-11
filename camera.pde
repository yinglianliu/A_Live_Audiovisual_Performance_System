/* 
https://processing.org/tutorials/video */


void liveCam() {
    //dotSize2 = map(myAudioData[0],0,myAudioMax*micSen,dotSizeMax,1);
    dotSize2 = map(myAudioData[dim],0,myAudioMax*micSen,2,dotSizeMax);

    //float b = map(myAudioData[0],0,myAudioMax*micSen,127,255);
    red22 = map(myAudioData[1],0,myAudioMax*micSen,0,255);
    green22 = map(myAudioData[3],0,myAudioMax*micSen,0,255);
    blue22 = map(myAudioData[2],0,myAudioMax*micSen,0,255);
    //gray2 = map(myAudioData[0],0,myAudioMax*micSen,127,255);
    
    diffRed = red22 - red2;
    red2+= diffRed * easingCam;
  
    diffGreen = green22 - green2;
    green2+= diffGreen * easingCam;
    
    diffBlue = blue22 - blue2;
    blue2+= diffBlue * easingCam;
    
    diffDotSize = dotSize2 - dotSize;
    dotSize += diffDotSize * easingCam;
    
    //diffGray = gray2 - gray;
    //gray += diffGray * easing*10;
    
    cameraV.beginDraw();
    
    cameraV.fill(red2*redOSC,green2*greenOSC,blue2*blueOSC,transparencyCam);
    cameraV.noStroke();
    cameraV.rect(0,0,cameraV.width*videoScale,cameraV.height*videoScale);
    
    cameraV.blendMode(DIFFERENCE);
  //background(red2,green2,blue2);
    video.loadPixels();
  // Begin loop for columns
  for (int i = 0; i < cols; i+=2) {
    for (int j = 0; j < rows; j+=2) {
      
      x = i*videoScale;
      y = j*videoScale;
      loc = (video.width - i-2) + j * video.width;
      c = video.pixels[loc];
      sz = (cameraV.brightness(c)/255) * videoScale * dotSize;

      //cameraV.rectMode(CENTER);
      //cameraV.fill(255-red2*redOSC,255-green2*greenOSC,blue2*blueOSC,transparencyCam);
      cameraV.fill(255,transparencyCam);

      //cameraV.fill(0,b-100,b*0.5,b*0.4);
       //fill(255);
      cameraV.noStroke();
      cameraV.ellipse(x + videoScale, y + videoScale, sz, sz);
      //cameraV.rect(x , y , sz, sz);
    }
  }

  cameraV.endDraw();
}
