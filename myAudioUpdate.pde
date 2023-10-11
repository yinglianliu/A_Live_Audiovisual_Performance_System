void myAudioDataUpdate() {
    for(int i=0; i< myAudioRange; i++){
      float tempIndexAvg = (myAudioFFT.getAvg(i) )* myAudioAmp * myAudioIndexAmp;
      float tempIndexCon = constrain(tempIndexAvg, 0 , myAudioMax);
      myAudioData[i] = tempIndexCon;
      myAudioIndexAmp += myAudioIndexStep;
  }
      myAudioIndexAmp = myAudioIndex;
      println(myAudioData);
  
}
