void pattern4() {
  
    l00 = map(myAudioData[dim], 0, myAudioMax*micSen, 100,height/3);
    l11 = map(myAudioData[1],0,myAudioMax*micSen,10,diam);
    amount14 = map(myAudioData[0],0,myAudioMax*micSen,density,round(density/2));
    stroketr11 = map(myAudioData[0],0,myAudioMax*micSen,0,255);
    gray2 = map(myAudioData[dim],0,myAudioMax*micSen,72,127);
    
    diff0 = l00 - l0;
    l0+= diff0* easing;
    
    diff1 = l11 - l1;
    l1+= diff1 * easing;
    
    diffamount4 = amount14 - amount4;
    amount4 += diffamount4 * easing;
    
    diffstroketr = stroketr11 - stroketr1;
    stroketr1 += diffstroketr * easing;
    
    diffGray = gray2 - gray;
    gray += diffGray * easing;
    

  pa4.beginDraw();
  
  //pa4.blendMode(EXCLUSION);

  //pa4.fill(red2*redOSC,green2*greenOSC,blue2*blueOSC,8);
  pa4.fill(gray,transparency);
  pa4.noStroke();
  pa4.rect(0,0,width,height);
  pa4.blendMode(DIFFERENCE);
  pa4.translate(width/2, height/2);
  pa4.rotate(angle);
  
  
  pa4.stroke(255,stroketr1);
  
    for( int i = 0; i<8; i++) {
      pa4.push();
      
      pa4.rotate(i*TWO_PI /8);
      pa4.translate(0,l0);
      pa4.strokeWeight(16);
      pa4.ellipse(0,0,l0,l0);
      
      pa4.rotate(angle);
          //float amount = map(myAudioData[5],0,myAudioMax,6,12);
          for(int j = 0; j<amount4; j++) {
            pa4.push();
            
            pa4.rotate(j*TWO_PI/amount4);
            pa4.translate(0,l1);
            pa4.strokeWeight(1);
            pa4.ellipse(0,0,l1,l1);
            
            pa4.pop();
          } 
          
      pa4.pop();
     
  }
  pa4.endDraw(); 
  angle +=speed;
}
