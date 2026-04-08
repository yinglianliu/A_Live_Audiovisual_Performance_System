// 6 LED bars — RGB channels start at ledStartChannel, stride 3 (R, G, B, R, G, B, ...)
void setLEDs() {
    redLED   = int(map(myAudioData[1], 30, myAudioMax*micSen, 0, 255));
    greenLED = int(map(myAudioData[3], 30, myAudioMax*micSen, 0, 255));
    blueLED  = int(map(myAudioData[2], 30, myAudioMax*micSen, 0, 255));

    for(int i = ledStartChannel;     i < ledEndChannel - 1; i += 3) dmxOutput.set(i, int(redLED   * redLEDOSC));
    for(int i = ledStartChannel + 1; i < ledEndChannel;     i += 3) dmxOutput.set(i, int(greenLED * greenLEDOSC));
    for(int i = ledStartChannel + 2; i <= ledEndChannel;    i += 3) dmxOutput.set(i, int(blueLED  * blueLEDOSC));
}
