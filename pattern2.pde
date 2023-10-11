void pattern2() {
  
    l00 = map(myAudioData[dim], 0, myAudioMax*micSen, 100,height/3-16*3);
    l11 = map(myAudioData[dim+1],0,myAudioMax*micSen,10,diam);
    amount11 = map(myAudioData[dim],0,myAudioMax*micSen,density,round(density/2));
    stroketr11 = map(myAudioData[dim],0,myAudioMax*micSen,0,127);
    red22 = map(myAudioData[1],0,myAudioMax*micSen,0,255);
    green22 = map(myAudioData[3],0,myAudioMax*micSen,0,255);
    blue22 = map(myAudioData[2],0,myAudioMax*micSen,0,255);
    
    diff0 = l00 - l0;
    l0+= diff0* easing;
    
    diff1 = l11 - l1;
    l1+= diff1 * easing;
    
    diffamount = amount11 - amount1;
    amount1 += diffamount * easing;
    
    diffstroketr = stroketr11 - stroketr1;
    stroketr1 += diffstroketr * easing;
    
    diffRed = red22 - red2;
    red2+= diffRed * easing;
  
    diffGreen = green22 - green2;
    green2+= diffGreen * easing;
    
    diffBlue = blue22 - blue2;
    blue2+= diffBlue * easing;
  
  pa2.beginDraw();
 
  //pa2.blendMode(EXCLUSION);

  pa2.fill(red2*redOSC,green2*greenOSC,blue2*blueOSC,transparency);
  //pa2.fill(gray,5);
  pa2.noStroke();
  pa2.rect(0,0,width,height);
  
  pa2.blendMode(DIFFERENCE);
  pa2.translate(width/2, height/2);
  pa2.rotate(angle);
  
  
  pa2.stroke(255,stroketr1);
  //pa2.stroke(255);
  
    for( int i = 0; i<8; i++) {
      pa2.push();
      
      pa2.rotate(i*TWO_PI /8);
      pa2.translate(0,l0);
      pa2.strokeWeight(16);
      pa2.ellipse(0,0,l0,l0);
      
      pa2.rotate(angle);
          //float amount = map(myAudioData[5],0,myAudioMax,6,12);
          for(int j = 0; j<amount1; j++) {
            pa2.push();
            
            pa2.rotate(j*TWO_PI/density-amount1);
            pa2.translate(0,l1);
            //pa2.stroke(255,stroketr1);
            pa2.strokeWeight(1);
            pa2.ellipse(0,0,l1,l1);
            
            pa2.pop();
          } 
          
      pa2.pop();
     
  }
  pa2.endDraw(); 
  angle +=speed;
}
