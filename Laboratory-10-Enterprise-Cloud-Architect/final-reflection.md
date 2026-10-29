
# Final Reflection: Mission 1 to Mission 10

> DRAFT SKELETON. Rewrite every section in your own words (your instructor checks authorship).
> Delete the prompts in italics once you have written your own text.

## Where I started (Mission 1)

*What could you do at the start? What were the first Linux commands you learned? How did it feel?*

[write here]

## The middle missions (Missions 2 to 9)

*Pick 3 or 4 missions that mattered most. For each: what you built, what clicked, what you got wrong.*

- Mission [ ]: [write here]
- Mission [ ]: [write here]
- Mission [ ]: [write here]
- Mission 9 (automation / self-healing): [write here]

## Mission 10: what we actually faced

Real events from this build you can talk about (add your own feelings and what you learned):

- The VM got no IP address on Bridged. We had to learn about DHCP, subnets, gateways, and netplan, and we set a static IP. A wrong subnet (`/26` instead of `/24`) caused the internet problem.
- Pasting long commands into a console that was waiting for a sudo password scrambled them. We learned to use SSH and paste one block at a time.
- The Docker repository had no release for the newest Ubuntu, so we installed `docker.io` from Ubuntu's own packages.
- We enabled UFW with default deny, and our first allow rules did not apply because of a messy paste, which could have locked us out of SSH. We fixed it from the live session.
- The restore test failed the first time because we typed `XXXX` instead of the real backup file name.

*Which of these taught you the most, and why?*

[write here]

## Technical lessons

*In your own words, explain: why volumes keep data after a reboot, why MySQL has no published port, why UFW default deny matters, and why backups need a schedule.*

[write here]

## What I would do differently

[write here]

## Closing

*How do you see yourself now compared to Mission 1?*

[write here]
