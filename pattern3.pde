void pattern3() {
  // Audio bands: dim=outer radius, dim+1=inner radius (consistent with pattern2), 1=red, 2=blue, 3=green
  outerRadiusTarget = map(myAudioData[dim],   0, myAudioMax*micSen, 100, height/3);
  innerRadiusTarget = map(myAudioData[dim+1], 0, myAudioMax*micSen, 20, diam); // was hardcoded [1], now uses dim+1
  amount13          = map(myAudioData[0],     0, myAudioMax*micSen, density, round(density/2));
  colorRTarget      = map(myAudioData[1],     0, myAudioMax*micSen, 0, 255);
  colorGTarget      = map(myAudioData[3],     0, myAudioMax*micSen, 0, 255);
  colorBTarget      = map(myAudioData[2],     0, myAudioMax*micSen, 0, 255);

  // Ease all values
  diff0      = outerRadiusTarget - outerRadius; outerRadius += diff0 * easing;
  diff1      = innerRadiusTarget - innerRadius; innerRadius += diff1 * easing;
  diffamount3 = amount13 - amount3;            amount3 += diffamount3 * easing;
  diffColorR = colorRTarget - colorR;          colorR += diffColorR * easing;
  diffColorG = colorGTarget - colorG;          colorG += diffColorG * easing;
  diffColorB = colorBTarget - colorB;          colorB += diffColorB * easing;

  pa3.beginDraw();
  pa3.background(255, 127);
  pa3.fill(colorR*redOSC, colorG*greenOSC, colorB*blueOSC);
  pa3.rect(0, 0, width, height);
  pa3.blendMode(DIFFERENCE);
  pa3.translate(width/2, height/2);
  pa3.rotate(angle);

  for(int i = 0; i < 8; i++) {
    pa3.push();
    pa3.rotate(i * TWO_PI / 8);
    pa3.translate(0, outerRadius);
    pa3.ellipse(0, 0, outerRadius, outerRadius);
    pa3.rotate(angle);
    for(int j = 1; j < amount3; j++) {
      pa3.push();
      pa3.rotate(j * TWO_PI / amount3);
      pa3.translate(0, innerRadius);
      pa3.ellipse(0, 0, innerRadius, innerRadius);
      pa3.pop();
    }
    pa3.pop();
  }
  pa3.endDraw();
  angle += speed;
}
