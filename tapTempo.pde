// Tap-tempo BPM calculator
// Usage: send /tap 1 from TouchOSC each beat. Enable /bpmSync to lock lights to BPM.

int[]   tapHistory  = new int[8]; // millis() timestamps of last 8 taps
int     tapIdx      = 0;
float   bpm         = 120.0;
boolean bpmSyncEnabled = false;

void recordTap() {
  tapHistory[tapIdx % tapHistory.length] = millis();
  tapIdx++;

  if(tapIdx < 2) return; // need at least 2 taps

  // Average interval across all stored taps
  int n        = min(tapIdx, tapHistory.length);
  int newest   = tapHistory[(tapIdx - 1) % tapHistory.length];
  int oldest   = tapHistory[(tapIdx - n) % tapHistory.length];
  float avgMs  = float(newest - oldest) / max(n - 1, 1);

  if(avgMs > 150) { // ignore if faster than 400 BPM (likely accidental double-tap)
    bpm = constrain(60000.0 / avgMs, 40, 240);
  }
  if(debug) println("BPM: " + nf(bpm, 0, 1));
}

// Called from draw() when bpmSyncEnabled — overrides TouchOSC fader values
void applyBPMSync() {
  // Frames per beat at current frame rate (Processing default ~60fps)
  int framesPerBeat = max(1, round(60.0 * 60.0 / bpm));
  minimacSpeed = framesPerBeat;
  ledSpeed     = framesPerBeat;
}
