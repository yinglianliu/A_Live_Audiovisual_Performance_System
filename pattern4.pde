void pattern4() {
  // Audio bands: dim=outer radius/gray, dim+1=inner radius (consistent with patterns 2/3), 0=ring count/stroke
  outerRadiusTarget = map(myAudioData[dim],   0, myAudioMax*micSen, 100, height/3);
  innerRadiusTarget = map(myAudioData[dim+1], 0, myAudioMax*micSen, 10, diam); // was hardcoded [1], now uses dim+1
  amount14          = map(myAudioData[0],     0, myAudioMax*micSen, density, round(density/2));
  strokeAlphaTarget = map(myAudioData[0],     0, myAudioMax*micSen, 0, 255);
  grayTarget        = map(myAudioData[dim],   0, myAudioMax*micSen, 72, 127);

  // Ease all values
  diff0         = outerRadiusTarget - outerRadius; outerRadius += diff0 * easing;
  diff1         = innerRadiusTarget - innerRadius; innerRadius += diff1 * easing;
  diffamount4   = amount14 - amount4;              amount4 += diffamount4 * easing;
  diffStrokeAlpha = strokeAlphaTarget - strokeAlpha; strokeAlpha += diffStrokeAlpha * easing;
  diffGray      = grayTarget - gray;               gray += diffGray * easing;

  pa4.beginDraw();
  pa4.fill(gray, transparency);
  pa4.noStroke();
  pa4.rect(0, 0, width, height);
  pa4.blendMode(DIFFERENCE);
  pa4.translate(width/2, height/2);
  pa4.rotate(angle);
  pa4.stroke(255, strokeAlpha);

  for(int i = 0; i < 8; i++) {
    pa4.push();
    pa4.rotate(i * TWO_PI / 8);
    pa4.translate(0, outerRadius);
    pa4.strokeWeight(16);
    pa4.ellipse(0, 0, outerRadius, outerRadius);
    pa4.rotate(angle);
    for(int j = 0; j < amount4; j++) {
      pa4.push();
      pa4.rotate(j * TWO_PI / amount4);
      pa4.translate(0, innerRadius);
      pa4.strokeWeight(1);
      pa4.ellipse(0, 0, innerRadius, innerRadius);
      pa4.pop();
    }
    pa4.pop();
  }
  pa4.endDraw();
  angle += speed;
}
