void loadConfig() {
  JSONObject config = loadJSONObject("config.json");
  if (config == null) {
    configError = true;
    configErrorMsg = "ERROR: config.json not found — edit config.json and restart.";
    return;
  }

  // Network
  JSONObject net = config.getJSONObject("network");
  cfgTouchoscIP     = net.getString("touchoscIP");
  cfgOscSendPort    = net.getInt("oscSendPort");
  cfgOscReceivePort = net.getInt("oscReceivePort");

  // DMX
  JSONObject dmx = config.getJSONObject("dmx");
  DMXPRO          = dmx.getBoolean("dmxproEnabled");
  DMXPRO_PORT     = dmx.getString("dmxproPort");
  DMXPRO_BAUDRATE = dmx.getInt("dmxproBaudrate");
  shutter         = dmx.getInt("shutterChannel");
  pan             = dmx.getInt("panChannel");
  til             = dmx.getInt("tilChannel");
  colorAdd        = dmx.getInt("colorChannel");
  shutterCloseMin = dmx.getInt("shutterCloseMin");
  ledStartChannel = dmx.getInt("ledStartChannel");
  ledEndChannel   = dmx.getInt("ledEndChannel");

  // Audio
  JSONObject audio = config.getJSONObject("audio");
  myAudioRange    = audio.getInt("range");
  myAudioMax      = audio.getInt("max");
  myAudioAmp      = audio.getFloat("amp");
  myAudioIndex    = audio.getFloat("index");
  myAudioIndexStep = audio.getFloat("indexStep");
  myAudioIndexAmp = myAudioIndex;
  myAudioData     = new float[myAudioRange];

  // Camera
  JSONObject cam = config.getJSONObject("camera");
  cfgCameraName = cam.getString("deviceName");
  videoScale    = cam.getInt("videoScale");

  // Lighting defaults
  JSONObject lighting = config.getJSONObject("lighting");
  colorMin = lighting.getFloat("colorMin");
  colorMax = lighting.getFloat("colorMax");

  configError = false;
  configErrorMsg = "";
  if (debug) println("config.json loaded successfully.");
}
