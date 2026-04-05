void pattern2() {
  // Audio bands: dim=circle size, dim+1=inner radius, 1=red, 2=blue, 3=green
  outerRadiusTarget = map(myAudioData[dim],   0, myAudioMax*micSen, 100, height/3-16*3);
  innerRadiusTarget = map(myAudioData[dim+1], 0, myAudioMax*micSen, 10, diam);
  amount11          = map(myAudioData[dim],   0, myAudioMax*micSen, density, round(density/2));
  strokeAlphaTarget = map(myAudioData[dim],   0, myAudioMax*micSen, 0, 127);
  colorRTarget      = map(myAudioData[1],     0, myAudioMax*micSen, 0, 255);
  colorGTarget      = map(myAudioData[3],     0, myAudioMax*micSen, 0, 255);
  colorBTarget      = map(myAudioData[2],     0, myAudioMax*micSen, 0, 255);

  // Ease all values
  diff0         = outerRadiusTarget - outerRadius; outerRadius += diff0 * easing;
  diff1         = innerRadiusTarget - innerRadius; innerRadius += diff1 * easing;
  diffamount    = amount11 - amount1;              amount1 += diffamount * easing;
  diffStrokeAlpha = strokeAlphaTarget - strokeAlpha; strokeAlpha += diffStrokeAlpha * easing;
  diffColorR    = colorRTarget - colorR;           colorR += diffColorR * easing;
  diffColorG    = colorGTarget - colorG;           colorG += diffColorG * easing;
  diffColorB    = colorBTarget - colorB;           colorB += diffColorB * easing;

  pa2.beginDraw();
  pa2.fill(colorR*redOSC, colorG*greenOSC, colorB*blueOSC, transparency);
  pa2.noStroke();
  pa2.rect(0, 0, width, height);
  pa2.blendMode(DIFFERENCE);
  pa2.translate(width/2, height/2);
  pa2.rotate(angle);
  pa2.stroke(255, strokeAlpha);

  for(int i = 0; i < 8; i++) {
    pa2.push();
    pa2.rotate(i * TWO_PI / 8);
    pa2.translate(0, outerRadius);
    pa2.strokeWeight(16);
    pa2.ellipse(0, 0, outerRadius, outerRadius);
    pa2.rotate(angle);
    for(int j = 0; j < amount1; j++) {
      pa2.push();
      pa2.rotate(j * TWO_PI/density - amount1);
      pa2.translate(0, innerRadius);
      pa2.strokeWeight(1);
      pa2.ellipse(0, 0, innerRadius, innerRadius);
      pa2.pop();
    }
    pa2.pop();
  }
  pa2.endDraw();
  angle += speed;
}
