// Scene / Cue system
// Saves and restores the full parameter state to cue_N.json in the sketch folder.
// Cue slot is selected via /cueSlot OSC address (1–8).
// /saveCue 1 → writes current state
// /loadCue 1 → restores state and pushes values back to TouchOSC

int cueSlot = 1; // currently selected cue slot (set via /cueSlot OSC)

void saveCue(int slot) {
  JSONObject cue = new JSONObject();

  // Visual pattern
  cue.setInt("activePattern",     activePattern);
  cue.setFloat("speedOSC",        speedOSC);
  cue.setFloat("frameROSC",       frameROSC);

  // Pattern colors
  cue.setFloat("redOSC",          redOSC);
  cue.setFloat("greenOSC",        greenOSC);
  cue.setFloat("blueOSC",         blueOSC);

  // Pattern parameters
  cue.setFloat("noiseScaleOSC",   noiseScaleOSC);
  cue.setFloat("n1offOSC",        n1offOSC);
  cue.setFloat("n2offOSC",        n2offOSC);
  cue.setFloat("n3offOSC",        n3offOSC);
  cue.setFloat("easingOSC",       easingOSC);
  cue.setFloat("diamOSC",         diamOSC);
  cue.setFloat("transparencyOSC", transparencyOSC);
  cue.setFloat("densityOSC",      densityOSC);

  // Camera
  cue.setFloat("dotSizeMaxOSC",      dotSizeMaxOSC);
  cue.setFloat("easingCamOSC",       easingCamOSC);
  cue.setFloat("transparencyCamOSC", transparencyCamOSC);

  // Audio sensitivity
  cue.setFloat("micSenOSC",       micSenOSC);
  cue.setFloat("dim0Button",      dim0Button);
  cue.setFloat("dim1Button",      dim1Button);
  cue.setFloat("dim2Button",      dim2Button);

  // DMX lights
  cue.setFloat("MiniMac",         MiniMac);
  cue.setFloat("minimacSpeedOSC", minimacSpeedOSC);
  cue.setFloat("colorMinOSC",     colorMinOSC);
  cue.setFloat("colorMaxOSC",     colorMaxOSC);
  cue.setFloat("tilAutoButton",   tilAutoButton);
  cue.setFloat("panAutoButton",   panAutoButton);
  cue.setFloat("autoTilMinOSC",   autoTilMinOSC);
  cue.setFloat("autoTilMaxOSC",   autoTilMaxOSC);
  cue.setFloat("autoPanMinOSC",   autoPanMinOSC);
  cue.setFloat("autoPanMaxOSC",   autoPanMaxOSC);

  // LEDs
  cue.setFloat("ledButton",       ledButton);
  cue.setFloat("ledSpeedOSC",     ledSpeedOSC);
  cue.setFloat("redLEDOSC",       redLEDOSC);
  cue.setFloat("greenLEDOSC",     greenLEDOSC);
  cue.setFloat("blueLEDOSC",      blueLEDOSC);

  // BPM
  cue.setFloat("bpm",             bpm);
  cue.setBoolean("bpmSyncEnabled", bpmSyncEnabled);

  saveJSONObject(cue, "cue_" + slot + ".json");
  if(debug) println("Cue " + slot + " saved.");
}

void loadCue(int slot) {
  JSONObject cue = loadJSONObject("cue_" + slot + ".json");
  if(cue == null) {
    if(debug) println("Cue " + slot + " not found.");
    return;
  }

  activePattern    = cue.getInt("activePattern",     activePattern);
  speedOSC         = cue.getFloat("speedOSC",        speedOSC);
  frameROSC        = cue.getFloat("frameROSC",       frameROSC);

  redOSC           = cue.getFloat("redOSC",          redOSC);
  greenOSC         = cue.getFloat("greenOSC",        greenOSC);
  blueOSC          = cue.getFloat("blueOSC",         blueOSC);

  noiseScaleOSC    = cue.getFloat("noiseScaleOSC",   noiseScaleOSC);
  n1offOSC         = cue.getFloat("n1offOSC",        n1offOSC);
  n2offOSC         = cue.getFloat("n2offOSC",        n2offOSC);
  n3offOSC         = cue.getFloat("n3offOSC",        n3offOSC);
  easingOSC        = cue.getFloat("easingOSC",       easingOSC);
  diamOSC          = cue.getFloat("diamOSC",         diamOSC);
  transparencyOSC  = cue.getFloat("transparencyOSC", transparencyOSC);
  densityOSC       = cue.getFloat("densityOSC",      densityOSC);

  dotSizeMaxOSC      = cue.getFloat("dotSizeMaxOSC",      dotSizeMaxOSC);
  easingCamOSC       = cue.getFloat("easingCamOSC",       easingCamOSC);
  transparencyCamOSC = cue.getFloat("transparencyCamOSC", transparencyCamOSC);

  micSenOSC        = cue.getFloat("micSenOSC",       micSenOSC);
  dim0Button       = cue.getFloat("dim0Button",      dim0Button);
  dim1Button       = cue.getFloat("dim1Button",      dim1Button);
  dim2Button       = cue.getFloat("dim2Button",      dim2Button);

  MiniMac          = cue.getFloat("MiniMac",         MiniMac);
  minimacSpeedOSC  = cue.getFloat("minimacSpeedOSC", minimacSpeedOSC);
  colorMinOSC      = cue.getFloat("colorMinOSC",     colorMinOSC);
  colorMaxOSC      = cue.getFloat("colorMaxOSC",     colorMaxOSC);
  tilAutoButton    = cue.getFloat("tilAutoButton",   tilAutoButton);
  panAutoButton    = cue.getFloat("panAutoButton",   panAutoButton);
  autoTilMinOSC    = cue.getFloat("autoTilMinOSC",   autoTilMinOSC);
  autoTilMaxOSC    = cue.getFloat("autoTilMaxOSC",   autoTilMaxOSC);
  autoPanMinOSC    = cue.getFloat("autoPanMinOSC",   autoPanMinOSC);
  autoPanMaxOSC    = cue.getFloat("autoPanMaxOSC",   autoPanMaxOSC);

  ledButton        = cue.getFloat("ledButton",       ledButton);
  ledSpeedOSC      = cue.getFloat("ledSpeedOSC",     ledSpeedOSC);
  redLEDOSC        = cue.getFloat("redLEDOSC",       redLEDOSC);
  greenLEDOSC      = cue.getFloat("greenLEDOSC",     greenLEDOSC);
  blueLEDOSC       = cue.getFloat("blueLEDOSC",      blueLEDOSC);

  bpm              = cue.getFloat("bpm",             bpm);
  bpmSyncEnabled   = cue.getBoolean("bpmSyncEnabled", bpmSyncEnabled);

  // Push loaded values back to TouchOSC so the UI reflects the cue
  pushCueToTouchOSC();
  if(debug) println("Cue " + slot + " loaded.");
}

// Send key cue values back to TouchOSC faders/buttons so the UI stays in sync
void pushCueToTouchOSC() {
  String[][] updates = {
    {"/speed",          str(speedOSC)},
    {"/frameRate",      str(frameROSC)},
    {"/red",            str(redOSC)},
    {"/green",          str(greenOSC)},
    {"/blue",           str(blueOSC)},
    {"/NoiseScale",     str(noiseScaleOSC)},
    {"/Easing",         str(easingOSC)},
    {"/diamMax",        str(diamOSC)},
    {"/transparency",   str(transparencyOSC)},
    {"/density",        str(densityOSC)},
    {"/MicSen",         str(micSenOSC)},
    {"/MiniMac",        str(MiniMac)},
    {"/ledBar",         str(ledButton)},
    {"/redLED",         str(redLEDOSC)},
    {"/greenLED",       str(greenLEDOSC)},
    {"/blueLED",        str(blueLEDOSC)},
    {"/colorMin",       str(colorMinOSC)},
    {"/colorMax",       str(colorMaxOSC)},
  };
  for(String[] pair : updates) {
    OscMessage msg = new OscMessage(pair[0]);
    msg.add(float(pair[1]));
    oscP5.send(msg, receiveAddr);
  }
}
