void moirePattern() {
  //yStep = int(map(myAudioData[0],0,myAudioMax,8,2));
  pa1.beginDraw();
  //pa1.clear();
  red2 = map(myAudioData[1],0,myAudioMax*micSen,0,255);
  green2 = map(myAudioData[3],0,myAudioMax*micSen,0,255);
  blue2 = map(myAudioData[2],0,myAudioMax*micSen,0,255);
  pa1.strokeWeight(yStep/2);
  
 // blendMode(SCREEN);
 //pa1.blendMode(EXCLUSION);

  pa1.background(int(red2*redOSC),int(green2*greenOSC),int(blue2*blueOSC));
  pa1.blendMode(DIFFERENCE);
  
      for(int n=0; n<1; n++){
          for( int y = mY; y<=height - mY; y+=yStep) {
            pa1.line(mX,y,width-mX,y);
            //bezier(mX, y+n2,width/2-n1,y-n2, 2*width/3+n2, y+n1, width-mX, y-n1);
           //bezier(mX, y,width/2-n1,y-2*n2, 2*width/3+n2, y+n1, width-mX, y);
            
            //good
            pa1.bezier(mX, y,width/2-n1,y-n2, 2*width/3+n3, y+n3, width-mX+n2, y);
            
            //bezier(mX, y,width/2-n2,y-n1, 2*width/3+n1, y+n3, width-mX+n2, y);
            //bezier(mX, y,width/2+n3,y+n1, 2*width/3+n2, y-n1, width-mX, y);
           //bezier(mX, y,width/3-n2,y+n3, 2*width/3+n2, y-n3, width-mX, y);
             
             //two sides
             //pa1.bezier(mX, y,width/3-n2,y+n3, 2*width/3+n2, y-n3, width-mX, y);
          
            
            //n1off += map(myAudioData[1],0,myAudioMax*micSen,0.009,0.0);
            n1off += map(myAudioData[1],0,myAudioMax*micSen,0.0,n1offMax);

             //n2off += map(myAudioData[0],0,myAudioMax,0,0.005);
            n2off += map(myAudioData[2],0,myAudioMax*micSen,0.0,n2offMax);
            n3off += map(myAudioData[3],0,myAudioMax*micSen,0.0,n3offMax);
            
           //n1 = (noise(map((sin(radians(frameCount*0.003))),-1,1,0,1))+noise(n1off))*noiseScale;
           //n2 = (noise(map((sin(radians(frameCount*0.003))),-1,1,0,1))+noise(n2off))*noiseScale;
           //n3 = (noise(map((sin(radians(frameCount*0.003))),-1,1,0,1))+noise(n3off))*noiseScale;
           
            n1 = noise(n1off)*noiseScale;
            n2 = noise(n2off)*noiseScale;
            n3 = noise(n3off)*noiseScale;
            
            //n1 = map(sin(radians(frameCount*noise(n1off))),0,0.3,-20,20);
            //n2 = map(cos(radians(frameCount*noise(n2off))),0,0.3,-30,30);
            //n3 = map(sin(radians(frameCount*noise(n3off))),0,0.3,-20,20);
            
       
          }
      }
      pa1.endDraw();
      //image(pa1,0,0);
}
