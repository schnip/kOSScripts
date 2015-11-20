// rendezvous.ks - Perform rendezvous to target.
// Copyright © 2015 jacob berkman
// This file is distributed under the terms of the MIT license.

@lazyglobal off.

run manoeuvre.
run navball.

print "Waiting to rendezvous until altitude: " + body:atm:height.
wait until altitude > body:atm:height.
wait 1.

lock targetHeading to mod(compassForVec(ship, target:direction:vector) + 180, 360).
lock targetPitch to -pitchForVec(ship, target:direction:vector).

lock relativeVelocity to target:velocity:orbit - ship:velocity:orbit.
lock relativeHeading to compassForVec(ship, relativeVelocity).
lock relativePitch to pitchForVec(ship, relativeVelocity).

print "target heading: " + round(targetHeading) + " pitch: " + round(targetPitch).
print "relative velocity heading: " + round(relativeHeading) + " pitch: " + round(relativePitch).

lock rendezvousHeading to 3 * relativeHeading - 2 * targetHeading.
lock rendezvousPitch to 3 * relativePitch - 2 * targetPitch.
local rendezvousRoll is roll_for(ship).

lock steering to r(0, 0, rendezvousRoll) + heading(rendezvousHeading, rendezvousPitch).

lock goalVelocity to target:distance / 100.

print "Waiting until relative velocity > " + goalVelocity.
wait until relativeVelocity:mag > goalVelocity.

global rendezvousPID to PIDLoop(1, 0, 0, 0, 1).
lock throttle to rendezvousPID:update(time:seconds, goalVelocity - relativeVelocity:mag).

wait until target:distance < 100.

lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
unlock steering.

print "Rendezvous complete.".