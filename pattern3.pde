void pattern3() {

    l00 = map(myAudioData[dim], 0, myAudioMax*micSen, 100,height/3);
    l11 = map(myAudioData[1],0,myAudioMax*micSen,20,diam);
    amount13 = map(myAudioData[0],0,myAudioMax*micSen,density,round(density/2));
   // stroketr11 = map(myAudioData[0],0,myAudioMax*micSen,0,255);
    red22 = map(myAudioData[1],0,myAudioMax*micSen,0,255);
    green22 = map(myAudioData[3],0,myAudioMax*micSen,0,255);
    blue22 = map(myAudioData[2],0,myAudioMax*micSen,0,255);
    
    diff0 = l00 - l0;
    l0+= diff0* easing;
    
    diff1 = l11 - l1;
    l1+= diff1 * easing;
    
    diffamount3 = amount13 - amount3;
    amount3 += diffamount3 * easing;
    
    //diffstroketr = stroketr11 - stroketr1;
    //stroketr1 += diffstroketr * easing;
    
    diffRed = red22 - red2;
    red2+= diffRed * easing;
  
    diffGreen = green22 - green2;
    green2+= diffGreen * easing;
    
    diffBlue = blue22 - blue2;
    blue2+= diffBlue * easing;
    
  pa3.beginDraw();
    
    //pa3.blendMode(EXCLUSION);
    pa3.background (255,127);
    //fill(red2,green2,blue2,10);
    pa3.fill(red2*redOSC,green2*greenOSC,blue2*blueOSC);
     //fill(gray,5);
    pa3.rect(0,0,width,height);
   // pa3.stroke(255,stroketr1);
    
    pa3.blendMode(DIFFERENCE);
    pa3.translate(width/2, height/2);
    pa3.rotate(angle);   
      for( int i = 0; i<8; i++) {
        pa3.push();
        pa3.rotate(i*TWO_PI /8);
        pa3.translate(0,l0);
        //pa3.strokeWeight(20);
        pa3.ellipse(0,0,l0,l0);
                pa3.rotate(angle);
              //float amount = map(myAudioData[5],0,myAudioMax,6,12);
              for(int j = 1; j<amount3; j++) {
                pa3.push();
                pa3.rotate(j*TWO_PI/amount3);
                pa3.translate(0,l1);
               // pa3.strokeWeight(2);
                pa3.ellipse(0,0,l1,l1);
                pa3.pop();
              } 
         pa3.pop();
         
    }
  pa3.endDraw();
  
  angle +=speed;
 
  }
