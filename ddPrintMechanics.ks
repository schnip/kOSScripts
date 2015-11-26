// printMechanics.ks
// Copyright © 2015 jacob berkman
// This file is distributed under the terms of the MIT license.

@lazyglobal off.

run libDunaDirect.

function stringWithTime {
  parameter t.

  local seconds is mod(t, 60).
  local minutes is mod(floor(t / 60), 60).
  local hours is mod(floor(t / 60 / 60), 6).
  local days is floor(t / 6 / 60 / 60).

  return days + "d " + hours + "h " + minutes + "m " + seconds + "s".
}

print "velocity: " + velocityOfOrbital(ship).
print "eccentric anomaly: " + eccentricAnomalyOfOrbit(obt).
print "mean anomaly: " + meanAnomalyOfOrbit(obt).
print "mean motion: " + meanMotionOfOrbit(obt).
print "time to periapsis: " + stringWithTime(timeToPeriapsisOfOrbit(obt)).
print "time to apoapsis: " +  stringWithTime(timeToApoapsisOfOrbit(obt)).
