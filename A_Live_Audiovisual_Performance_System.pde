/* v14
Add list of functions into TouchOSC
1. limit some pan and tilt range.
2. add Auto til and auto pan min and max values
3. add three more options to triger the shutter on and off(default index is 0)
    (That being said, I can use one of 4 freq bands which are 0,1,2,3 index of FFT array to control the shutter on or off)
    (This is a better solution that I came up with to control songs with different tempos without manule changing the code).
*/
/* v13
1. add pan and til auto and manuly
*/
/* v12
1. add window selection
2. add more parameters of camera into TouchOSC

*/

/* v11
1. add camera
2. add receive port 12000 be able to receive the message from Processing to TouchOSC
3. set the reset button in TouchOSC

*/

/*v10 

1.Try different values of FFT 
2.Change the universeSize=512
3.Add some value change via TouchOSC
4.Adjust some values.

*/

import dmxP512.*;
import processing.serial.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.net.*;
import oscP5.*;
import netP5.*;

import processing.video.*;

OscP5 oscP5;
OscMessage theMessage;
NetAddress receiveAddr;
//make a array to store the OSC addresses of faders and buttons, TouchOSC be able to receive the message from Processing///////
String[] oscAddr = {"/red","/green","/blue","/NoiseScale","/n1","/n2","/n3","/frameRate","/Easing","/diamMax","/transparency","/density",
                     "/pattern1","/pattern2","/pattern3","/pattern4","/liveCam","/patternOff","/MicSen","/redLED","/greenLED","/blueLED","/ledBar","/MiniMac",
                     "/Til","/Pan","/FrontL","/FrontR","/BackL","/BackR","/dotSizeMax","/cameraSpeed","/transparencyCam","/minimacSpeed","/ledSpeed","/til","/pan",
                     "/tilButtonAuto","/panButtonAuto","/dim0","/dim1","/dim2","/AutoTilMin","/AutoTilMax","/AutoPanMin","/AutoPanMax","/colorMin","/colorMax","/speed","/reloadConfig"};

// Config variables — loaded from config.json at startup
String cfgTouchoscIP     = "10.2.196.170";
int    cfgOscSendPort    = 9100;
int    cfgOscReceivePort = 12000;
String cfgCameraName     = "Yinglian Camera";
int    ledStartChannel   = 43;
int    ledEndChannel     = 227;
boolean configError      = false;
String  configErrorMsg   = "";

DmxP512 dmxOutput;
int universeSize = 512;
boolean DMXPRO = false;
String DMXPRO_PORT = "/dev/tty.usbserial-ENP08WE9";
int DMXPRO_BAUDRATE = 115000;

Minim minim;
AudioInput myAudio;
FFT myAudioFFT;
//AudioPlayer myAudio;


int myAudioRange = 7;
int myAudioMax = 100;
float myAudioAmp = 30;
float myAudioIndex = 0.5;
float myAudioIndexAmp = myAudioIndex;
float myAudioIndexStep = 0.75;
float[] myAudioData = new float[myAudioRange];

//different parameter for the moirePattern
float n1off, n2off,n3off, n1,n2,n3,n1offOSC,n2offOSC,n3offOSC,n1offMax,n2offMax,n3offMax;
float frameR, frameROSC;
float yStep = 2;
float noiseScale; //40 and 60
int mX = 0;
int mY = 0;

//for pattern2 & 3
float angle = 0.0;
float speed = 0.005;
float speedOSC = 0.25; // default maps to speed 0.005
float l0;
float l1;
float l00;
float l11;
float amount1;
float amount3;
float amount4;
float amount11;
float amount13;
float amount14;
float stroketr1;
float stroketr11;
float easing;
float diam;
float transparency;
float density;
float diff0, diff1,diffamount,diffamount3, diffamount4, 
diffstroketr,diffRed,diffGreen,diffBlue, diffGray;
float red2,green2,blue2,red22,green22,blue22,gray,gray2;

/////////////for the miniMAC ////////////////////////////////////
//dmx address of the first light
int til = 7;
int pan = 5;
int colorAdd = 2;
int shutter = 1;
int shutterCloseMin = 20;

//index of audio data array
int dim = 0;

float panAngle,tilAngle;

//////////////////////for TouchOSC//////////////////////////////
float redLED, greenLED, blueLED;
float redLEDOSC,greenLEDOSC,blueLEDOSC;

float redOSC;
float greenOSC;
float blueOSC;
float pattern1Button;
float pattern2Button;
float pattern3Button;
float pattern4Button;
float liveCamButton;
float patternOffButton;
float MiniMac;
float ledButton;
float tilOSC;
float panOSC;
float noiseScaleOSC;
float easingOSC;
float diamOSC;
float transparencyOSC;
float densityOSC;
float resetB;

float micSen;
float micSenOSC;

float tilAutoButton,panAutoButton;
float minimacSpeedOSC,ledSpeedOSC,minimacSpeed,ledSpeed;

/////////////////////////////////////for camera//////////////////////////////////////////////////////
int videoScale =4;
int cols, rows;
Capture video;
int x,y,loc;
color c;
float sz;
float dotSize, dotSize2, diffDotSize,dotSizeMaxOSC,transparencyCam,transparencyCamOSC,easingCam,easingCamOSC;
float dotSizeMax = 10.0;

float degree;
float autoTilMin, autoTilMax, autoPanMin, autoPanMax;
float autoTilMinOSC, autoTilMaxOSC, autoPanMinOSC, autoPanMaxOSC;

float dim0Button,dim1Button,dim2Button;

float colorMin = 84;
float colorMax = 131;
float colorMinOSC,colorMaxOSC;

boolean debug = false;  //set to true to enable console debug output

PGraphics pa1;  //draw the pattern1(moirePattern)
PGraphics pa2;  //draw the pattern2
PGraphics pa3;  //draw the pattern3
PGraphics pa4;  //draw the pattern4(Same as pattern2 but gray scale)
PGraphics paOff;  //draw black background
PGraphics cameraV;  //call the camera


void setup() {
  fullScreen(2);
  loadConfig();

  background(0);
  noCursor();
  pa1 = createGraphics(width,height);
  pa2 = createGraphics(width,height);
  pa3 = createGraphics(width,height);
  pa4 = createGraphics(width,height);
  paOff = createGraphics(width,height);
  cameraV = createGraphics(width,height);
  
  minim = new Minim(this);
  myAudio = minim.getLineIn(Minim.MONO);
  myAudioFFT = new FFT(myAudio.bufferSize(), myAudio.sampleRate());
  myAudioFFT.linAverages(myAudioRange);
  myAudioFFT.window(FFT.NONE);
  
  //DMX
  dmxOutput=new DmxP512(this,universeSize,true);
  
  if(DMXPRO){
    dmxOutput.setupDmxPro(DMXPRO_PORT,DMXPRO_BAUDRATE);
  }
  
  // Init moving lights: shutter closed, pan/til at default position
  for(int i=shutter; i<shutter+40; i+=10) dmxOutput.set(i, 0);
  for(int i=pan;     i<pan+40;     i+=10) dmxOutput.set(i, 150);
  for(int i=til;     i<til+40;     i+=10) dmxOutput.set(i, 180);

  // Init LED bars off
  for(int i=ledStartChannel; i<=ledEndChannel; i++) dmxOutput.set(i, 0);
  
  noFill();
  stroke(255);
  strokeCap(CORNER);

  // OSC — ports and IP loaded from config.json
  oscP5 = new OscP5(this, cfgOscSendPort);
  receiveAddr = new NetAddress(cfgTouchoscIP, cfgOscReceivePort);

  // Camera — device name loaded from config.json
  cols = width / videoScale;
  rows = height / videoScale;
  video = new Capture(this, cfgCameraName);
  video.start();
  
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
    myAudioFFT.forward(myAudio.mix);
    myAudioDataUpdate(); 
    
  //mapping the value of faders from TouchOSC
    micSen = map(micSenOSC,0,1,1.0,0.001);
    
    noiseScale = map(noiseScaleOSC,0,1,20,100);    
    n1offMax = map(n1offOSC,0.0,1.0,0.0001,0.01);
    n2offMax = map(n2offOSC,0.0,1.0,0.0001,0.01);
    n3offMax = map(n3offOSC,0.0,1.0,0.0001,0.01);
    frameR = int(floor(map(frameROSC,0.0,1.0,31,2)));
    
    speed = map(speedOSC,0,1,0.0005,0.02);
    easing = map(easingOSC,0,1,0.001,0.1);
    diam = map(diamOSC,0.0,1.0,11,width/5*3);
    transparency = map(transparencyOSC,0,1,0,255);
    density = map(densityOSC,0,1,6,20);
    
    dotSizeMax = map(dotSizeMaxOSC,0,1,2,20);
    easingCam = map(easingCamOSC,0,1,0.001,0.3);
    transparencyCam = map(transparencyCamOSC,0,1,0,255);
    
    minimacSpeed = int(floor(map(minimacSpeedOSC,0.0,1.0,31,2)));
    ledSpeed = int(floor(map(ledSpeedOSC,0.0,1.0,31,2)));
    
////////////Using fader to select color in TouchOSC(But need to know the range number!!!)///
    colorMin = int(floor(map(colorMinOSC,0,1,24,150)));
    colorMax = int(floor(map(colorMaxOSC,0,1,24,150)));
       
//////////////Til and pan function in TouchOSC////////////////////////
       panAngle = floor(map(panOSC,0,1,151,255));
       tilAngle = floor(map(tilOSC,0,1,181,255));
       
       autoTilMin = floor(map(autoTilMinOSC,0,1,0,128));
       autoTilMax = floor(map(autoTilMaxOSC,0,1,129,255));
       
       autoPanMin = floor(map(autoPanMinOSC,0,1,0,128));
       autoPanMax = floor(map(autoPanMaxOSC,0,1,129,255));
       
       degree = map(myAudioData[dim+1],60,myAudioMax,250,2000);

       
       
       if(panAutoButton ==1) {
         setPanAuto();
       }
       
       if(tilAutoButton ==1) {
         setTilAuto();
       }
       
       if(panAngle >150 && panAutoButton ==0){
         setPan();     
       }
       
       if(tilAngle >180 && tilAutoButton ==0) {
         setTil();
       }
       

////////////////Using the TouchOSC Buttons to Switch the patterns//////////////////            
       if (pattern1Button ==1
           && pattern2Button ==0 
           && pattern3Button ==0 
           && pattern4Button ==0
           && patternOffButton ==0){
             if(frameCount % frameR == 0){
                moirePattern();
            }
                image(pa1,0,0);
       } 
     
       if (pattern2Button == 1 
           && pattern4Button == 0 
           && pattern3Button == 0 
           && pattern1Button == 0
           && patternOffButton == 0){
             pattern2();
             image(pa2,0,0);
       } 
     
     if(pattern3Button == 1 
        && pattern4Button == 0 
        && pattern2Button == 0 
        && pattern1Button == 0
        && patternOffButton == 0) {
          pattern3();
          image(pa3,0,0);
       } 
       
     if(pattern4Button == 1 
        && pattern3Button == 0 
        && pattern2Button == 0 
        && pattern1Button == 0
        && patternOffButton == 0) {   
          pattern4();
          image(pa4,0,0);
       } 
       
      if(liveCamButton == 1 
        && pattern3Button == 0 
        && pattern2Button == 0 
        && pattern1Button == 0
        && patternOffButton == 0) {   
         liveCam();
         image(cameraV,0,0);
       } 
       
      if(patternOffButton == 1 ) {   
          paOff.beginDraw();
          //clear();
          paOff.background(0);
          //fill(0);
          //rect(0,0,paOff.width,paOff.height);
          paOff.endDraw();
          image(paOff,0,0);
       } 
       
     if(MiniMac == 1 ) { 
       if(frameCount % minimacSpeed == 0){
        setLight();
         }
         
       }else {
        setBlackout();
       }
       
     if(ledButton == 1 ) { 
       
       if(frameCount % ledSpeed == 0) {
        setLEDs();
         }
         
      }else {
        setLEDOff ();
       }
     //////If the Reset button in TouchOSC is pressed(momentary),set all the value back to 0//////
     if(resetB == 1) {
       for(int i=0; i<oscAddr.length;i++){
        OscMessage myMessage = new OscMessage(oscAddr[i]);
        myMessage.add(0.0);
        oscP5.send(myMessage, receiveAddr);
       }
       
     }
     
     // Show config error on screen if config.json failed to load
     if(configError) {
       fill(255, 0, 0);
       textSize(28);
       textAlign(CENTER, CENTER);
       text(configErrorMsg, width/2, height/2);
       noFill();
     }

     //Using the buttions in TouchOSC to select which band in FFT array will be used as a trigger to drive the dimmer or visuals//////
     if(dim0Button == 1 && dim1Button == 0 && dim2Button == 0) {
       dim = 1;
     }else if(dim1Button == 1 && dim0Button == 0 && dim2Button == 0) {
       dim = 2;
     }else if(dim2Button == 1 && dim0Button == 0 && dim1Button == 0) {
       dim = 3;
     } else{
       dim = 0;
     }
}  


void stop() {
  myAudio.close();
  minim.stop();
  super.stop();
}

//////////////////////Set up different faders, buttons, and radials in TouchOSC///////////////////////////////////////////////
/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  if(debug) {
    print("### received an osc message.");
    print(" addrpattern: "+theOscMessage.addrPattern());
    println(" typetag: "+theOscMessage.typetag());
  }

  // Method 1: Using a switch to isolate and assign the values through the addrPattern
  switch(theOscMessage.addrPattern()){
    case "/red": //radial red in touchOSC
      redOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Red: "+ redOSC);
      break;

    case "/blue": //radial blue in touchOSC
      blueOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Blue: " + blueOSC);
      break;

    case "/green": //radial green in touchOSC
      greenOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Green: " + greenOSC);
      break;

     case "/redLED": //radial redLED in touchOSC
      redLEDOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Red LED :" + redLEDOSC);
      break;

    case "/blueLED": //radial blueLED in touchOSC
      blueLEDOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Blue LED: " + blueLEDOSC);
      break;

    case "/greenLED": //radial greenLED in touchOSC
      greenLEDOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Green LED: " + greenLEDOSC);
      break;

    case "/til": //fader Til in touchOSC
      tilOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Til: " + tilAngle);
      break;

    case "/pan": //fader Pan in touchOSC
      panOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Pan: " + panAngle);
      break;

    case "/Easing": //fader Easing in touchOSC
      easingOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Easing: " + easing);
      break;

    case "/NoiseScale": //fader NoiseScale in touchOSC
      noiseScaleOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Noise Scale: " + noiseScale);
      break;

    case "/MicSen": //fader MicSen in touchOSC
      micSenOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Mic Sen: " + micSen);
      break;

    case "/n1": //fader n1 in touchOSC
      n1offOSC = theOscMessage.get(0).floatValue();
      if(debug) println("N1 noise: " + n1offMax);
      break;

    case "/n2": //fader n2 in touchOSC
      n2offOSC = theOscMessage.get(0).floatValue();
      if(debug) println("N2 noise: " + n2offMax);
      break;

    case "/n3": //fader n3 in touchOSC
      n3offOSC = theOscMessage.get(0).floatValue();
      if(debug) println("N3 noise: " + n3offMax);
      break;

    case "/frameRate": //fader frameRate in touchOSC
      frameROSC = theOscMessage.get(0).floatValue();
      if(debug) println("Frame Rate: " + 60/int(frameR));
      break;

    case "/diamMax": //fader diamMax in touchOSC
      diamOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The max diam: " + diam);
      break;

    case "/transparency": //fader transparency in touchOSC
      transparencyOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The transparency: " + transparency);
      break;

    case "/density": //fader density in touchOSC
      densityOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The density: " + density);
      break;

    case "/dotSizeMax": //fader dotSizeMax in touchOSC
      dotSizeMaxOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The max dot size: " + dotSizeMax);
      break;

    case "/cameraSpeed": //fader cameraSpeed in touchOSC
      easingCamOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The easing of camera: " + easingCam);
      break;

    case "/transparencyCam": //fader transparencyCam in touchOSC
      transparencyCamOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The transparency of camera: " + transparencyCam);
      break;

    case "/minimacSpeed": //fader minimacSpeed in touchOSC
      minimacSpeedOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The speed of miniMac : " + int(60/minimacSpeed));
      break;

    case "/ledSpeed": //fader ledSpeed in touchOSC
      ledSpeedOSC = theOscMessage.get(0).floatValue();
      if(debug) println("The speed of LED Bars : " + int(60/ledSpeed));
      break;

///////////////////////////////////////////////
    case "/AutoTilMin": //fader AutoTilMin in touchOSC
      autoTilMinOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Auto Tilt Min number : " + autoTilMin);
      break;

    case "/AutoTilMax": //fader AutoTilMax in touchOSC
      autoTilMaxOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Auto Tilt Max number : " + autoTilMax);
      break;

    case "/AutoPanMin": //fader AutoPanMin in touchOSC
      autoPanMinOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Auto Pan Min number : " + autoPanMin);
      break;

    case "/AutoPanMax": //fader AutoPanMax in touchOSC
      autoPanMaxOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Auto Pan Max number : " + autoPanMax);
      break;

    case "/colorMin": //fader colorMin in touchOSC
      colorMinOSC = theOscMessage.get(0).floatValue();
      break;

    case "/colorMax": //fader colorMax in touchOSC
      colorMaxOSC = theOscMessage.get(0).floatValue();
      break;

    case "/speed": //fader speed in touchOSC
      speedOSC = theOscMessage.get(0).floatValue();
      if(debug) println("Pattern speed: " + speed);
      break;

    case "/reloadConfig": //button reloadConfig in touchOSC
      if(theOscMessage.get(0).floatValue() == 1) {
        loadConfig();
        // Note: network/camera/FFT changes require a restart to take effect
        if(debug) println("Config reloaded.");
      }
      break;

    default:
      println("No type tags!");
      break;
      
  }

  // Method 2: Using if statements // checkAddrPattern returns a boolean
  
  //button pattern1 in TouchOSC
  if(theOscMessage.checkAddrPattern("/pattern1") == true){
    pattern1Button = theOscMessage.get(0).floatValue();
    if(debug && pattern1Button == 1) println("pattern1 is on.");
  }

  if(theOscMessage.checkAddrPattern("/pattern2") == true){
    pattern2Button = theOscMessage.get(0).floatValue();
    if(debug && pattern2Button == 1) println("pattern2 is on.");
  }

  if(theOscMessage.checkAddrPattern("/pattern3") == true){
    pattern3Button = theOscMessage.get(0).floatValue();
    if(debug && pattern3Button == 1) println("pattern3 is on.");
  }

  if(theOscMessage.checkAddrPattern("/pattern4") == true){
    pattern4Button = theOscMessage.get(0).floatValue();
    if(debug && pattern4Button == 1) println("pattern4 is on.");
  }

  if(theOscMessage.checkAddrPattern("/liveCam") == true){
    liveCamButton = theOscMessage.get(0).floatValue();
    if(debug && liveCamButton == 1) println("Live Camera is on.");
  }

  if(theOscMessage.checkAddrPattern("/patternOff") == true){
    patternOffButton = theOscMessage.get(0).floatValue();
    if(debug && patternOffButton == 1) println("pattern is off.");
  }

  if(theOscMessage.checkAddrPattern("/MiniMac") == true){
    MiniMac = theOscMessage.get(0).floatValue();
    if(debug && MiniMac == 1) println("MiniMac is on.");
  }

  if(theOscMessage.checkAddrPattern("/ledBar") == true){
    ledButton = theOscMessage.get(0).floatValue();
    if(debug && ledButton == 1) println("LEDs is on.");
  }

  if(theOscMessage.checkAddrPattern("/resetButton") == true){
    resetB = theOscMessage.get(0).floatValue();
    if(debug && resetB == 1) println("Reset triggered.");
  }

  if(theOscMessage.checkAddrPattern("/tilButtonAuto") == true){
    tilAutoButton = theOscMessage.get(0).floatValue();
    if(debug && tilAutoButton == 1) println("Til auto function is on.");
  }

  if(theOscMessage.checkAddrPattern("/panButtonAuto") == true){
    panAutoButton = theOscMessage.get(0).floatValue();
    if(debug && panAutoButton == 1) println("Pan auto function is on.");
  }

  if(theOscMessage.checkAddrPattern("/dim0") == true){
    dim0Button = theOscMessage.get(0).floatValue();
    if(debug && dim0Button == 1) println("Using myAudioData[0] for shutter trigger.");
  }

  if(theOscMessage.checkAddrPattern("/dim1") == true){
    dim1Button = theOscMessage.get(0).floatValue();
    if(debug && dim1Button == 1) println("Using myAudioData[1] for shutter trigger.");
  }

  if(theOscMessage.checkAddrPattern("/dim2") == true){
    dim2Button = theOscMessage.get(0).floatValue();
    if(debug && dim2Button == 1) println("Using myAudioData[2] for shutter trigger.");
  }
    
 }
 
