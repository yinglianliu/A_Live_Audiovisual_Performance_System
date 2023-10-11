//for the miniMAC
//int til = 7;
//int pan = 5;
//int colorAdd = 2;
//int shutter = 1;

//int dim = 0; //use into myAudioData[dim],3 options(index 0,1,2), select in TouchOSC

void setLight() {
  
///////////////////////////////Light 1(FrontLeft)//////////////////////////////////////////////
    dmxOutput.set(shutter,int(map(myAudioData[dim],shutterCloseMin,myAudioMax*micSen,0,38)));//fade
    //dmxOutput.set(shutter,int(map(myAudioData[1],30,myAudioMax,38,12)));//fade

    dmxOutput.set(4,255); //gobo swing, slow to fast
    dmxOutput.set(10,250); //effect fast to slow
    //dmxOutput.set(til,180); 
    //dmxOutput.set(pan,150); 
    //color wheel, pink,red,green,cyan,yellow
    //dmxOutput.set(colorAdd,int(map(myAudioData[1],0,myAudioMax*micSen,84,131))); 
    dmxOutput.set(colorAdd,int(map(myAudioData[dim+1],0,myAudioMax*micSen,colorMin,colorMax))); 

    //dmxOutput.set(colorAdd,int(map(myAudioData[3],0,myAudioMax,200,203))); 
    //dmxOutput.set(3,50);
    //dmxOutput.set(3,1);

    
///////////////////////////////Light 2(FrontRight)///////////////////////////////////////////
    dmxOutput.set(shutter+10,int(map(myAudioData[dim],shutterCloseMin,myAudioMax*micSen,0,38))); 
    //dmxOutput.set(shutter+10,int(map(myAudioData[1],30,myAudioMax,38,12)));    

    dmxOutput.set(4+10,255);
    dmxOutput.set(10+10,250);
    //dmxOutput.set(til+10,180); 
    //dmxOutput.set(pan+10,150); 
    //color wheel,megenta,blue,green,purple
    //dmxOutput.set(colorAdd+10,int(map(myAudioData[1],0,myAudioMax*micSen,84,131)));
    dmxOutput.set(colorAdd+10,int(map(myAudioData[dim+1],0,myAudioMax*micSen,colorMin,colorMax)));    
      
/////////////////////////////////Light 3(BackRight)///////////////////////////////////////////
    dmxOutput.set(shutter+20,int(map(myAudioData[dim],shutterCloseMin,myAudioMax*micSen,0,38)));
    // dmxOutput.set(shutter+20,int(map(myAudioData[1],30,myAudioMax,38,12)));

    dmxOutput.set(4+20,255); //gobo swing, slow to fast
    dmxOutput.set(10+20,250); //effect fast to slow
    dmxOutput.set(4+20,255);
    dmxOutput.set(10+20,250);
    //dmxOutput.set(til+20,180); 
    //dmxOutput.set(pan+20,150); 
    //dmxOutput.set(colorAdd+20,int(map(myAudioData[4],0,myAudioMax*micSen,84,131)));
    dmxOutput.set(colorAdd+20,int(map(myAudioData[dim+1],0,myAudioMax*micSen,colorMin,colorMax)));
   
   
//////////////////////////////Light 4(BackLeft)////////////////////////////////////////////////
    dmxOutput.set(shutter+30,int(map(myAudioData[dim],shutterCloseMin,myAudioMax*micSen,0,38)));
    //dmxOutput.set(shutter+30,int(map(myAudioData[1],30,myAudioMax,38,12)));

    dmxOutput.set(4+30,255); //gobo swing, slow to fast
    dmxOutput.set(10+30,250); //effect fast to slow
    dmxOutput.set(4+30,255);
    dmxOutput.set(10+30,250);
    //dmxOutput.set(til+30,180); 
    //dmxOutput.set(pan+30,150);  
    //dmxOutput.set(colorAdd+30,int(map(myAudioData[4],0,myAudioMax*micSen,84,131)));
    dmxOutput.set(colorAdd+30,int(map(myAudioData[dim+1],0,myAudioMax*micSen,colorMin,colorMax)));
}
