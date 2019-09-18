##	Overview

In Lesson 1, you're going to build a "Zombie Factory" to build an army of zombies.

*	Our factory will maintain a database of all zombies in our army

*	Our factory will have a function for creating new zombies

*	Each zombie will have a random and unique appearance

##	How Zombie DNA Works

*	The zombie's appearance will be based on its "Zombie DNA". Zombie DNA is simple — it's a 16-digit integer, like:

	```
	8356281049284737
	```

	也就是说，本教程所说的 16 位的 DNA, 指的是 16 个十进制数，而不是 16 个 bit。这么做估计是方便初学者理解

*	Just like real DNA, different parts of this number will map to different traits. The `first 2 digits` map to the zombie's `head type`, the `second 2 digits` to the zombie's `eyes`, etc.

