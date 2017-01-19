void setup() {
  size(700,700);
}

float n = 0;
void draw() {
  background(#111111);
  translate(width/2, height/2);
  fill(0,0);
  float angleStepSize = 2*PI / 12;
  
  for (float radius = 50, angleOffset = 0, index = 0; radius <= 250; radius += (25 + 0), angleOffset += angleStepSize / 2, index++) {
    float currentStroke = (index < 2) ? 0.0 : guassian(index, 7, 10);
    float nextStroke = guassian(index + 2, 7, 10);
    float stroke = max(0.0, easeInOutExponent(n, currentStroke, nextStroke - currentStroke, 100.0));
    float rx = easeInOutExponent(n, radius, 50, 100.0);
    float currentRad = 20 + index * 2.0;
    float circleRad = easeInOutExponent(n, currentRad, 4.0, 100.0);
    
    for (float angle = angleOffset; angle < 2*PI + angleOffset; angle += angleStepSize) {
      if (stroke > 0.3) {
        stroke(#dddddd);
      } else {
        stroke(#111111);
      }
      strokeWeight(stroke);
      float x = (rx) * cos(angle);
      float y = (rx) * sin(angle);
      
      ellipse(x, y, circleRad, circleRad);
    }
  }
  
  n += 1.0;
  
  saveFrame("f####.gif");
  if (n > 100) {
    n = 0.0;
    exit();
  }
}

float easeInOutExponent(float t, float beginningPosition, float change, float timeToCompletePeriod) {
  t /= timeToCompletePeriod/2.0;
  if (t < 1) {
    return change/2.0 * pow(2.0, 5.0 * (t - 1.0)) + beginningPosition;
  }
  
  t--;
  return change/2.0 * (-pow(2.0, -5.0 * t) + 2.0) + beginningPosition;
}

float guassian(float t, float timeToCompletePeriod, float maxVal) {
  t /= timeToCompletePeriod / 2;
  t -= 1.0;
  return maxVal * (2.0 * pow(2.0, -pow(t, 2.0)) - 1.0);
}