# Autonomous Mobile Robot Navigation using the iRobot Roomba
Master thesis of Kevin Denis, under supervision of Professor Slaets and Professor Vandeurzen. 

## Abstract
This thesis offers a description on how to select and implement different algorithms which gives an existing robot the ability to localize itself, plan a path to a destination and follow this path in a multi-floor building while avoiding obstacles.

The purpose of this Autonomous Mobile Robot (AMR) is to guide visitors of our university campus to a desired room. To get information about the environment, the iRobot Roomba, the selected robot platform, has been equipped with a LIDAR sensor. The measurements gathered from the LIDAR are used for the Vector Polar Histogram algorithm which is selected as obstacle avoidance navigation method, as well as the Monte Carlo Particle filter which is used to localize the robot in its environment. Other inputs for the localization are the map of the building in which the robot has to function and the data from the onboard odometry sensor measurements. A Voronoi diagram is used to determine the possible paths to the destination and Dijkstra’s algorithm is used to select the most optimal path.

Combining all these methods results in a robust and accessible AMR, which is able to navigate in our university campus. The methods developed for autonomous navigation are however not specifically based on our campus or robot, which creates the opportunity for future uses.

## Repository  organization

### adm (Administration)
Here, all the administrative matter for this thesis is stored.

### cad (Computer-aided design)
Here, all the files related to the design of the AMR platform and the maps of our university campus are available.

### src (Source code)
Here, all the source code used for this thesis is presented.

### ppr (Paper)
Here, the word document for the final master's thesis paper the and pdf's will be available.

### prs	(Presentation)
Here, the powerpoint presentation shown during the thesis defence is available.