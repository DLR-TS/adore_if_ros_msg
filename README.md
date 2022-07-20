<!--
********************************************************************************
* Copyright (C) 2017-2020 German Aerospace Center (DLR). 
* Eclipse ADORe, Automated Driving Open Research https://eclipse.org/adore
*
* This program and the accompanying materials are made available under the 
* terms of the Eclipse Public License 2.0 which is available at
* http://www.eclipse.org/legal/epl-2.0.
*
* SPDX-License-Identifier: EPL-2.0 
*
* Contributors: 
*   Daniel Heß - initial API and implementation
********************************************************************************
-->
# ADORe ROS Message Repository
ADORe is an open source toolkit for automated vehicle control and decision making, with the main repository [eclipse/adore](https://github.com/eclipse/adore).
ADORe can be coupled with ROS. This repository defines ROS messages used for interaction with ADORe through ROS.
A detailed list of ROS messages and the typical topics can be found in the subfolder.

## Structure
On this level the repository is a docker and make wrapper for the actual content in the module subfolder.

## Getting Started

### Prerequsits
This project requires **docker** and **make** installed and configured for your user.

### Building
To build adore_if_ros_msg run the following on the top level of the repository:
```bash 
make
```

### Build Artifacts

To consume this module you must:
1. Install the module with one of the provided methods
2. Add adore_if_ros_msg to your CMakeLists.txt with find_package and catkin_package

Once build via make this project offers the multiple options for 
consuming/installing the module via the **adore_if_ros_msg/build** directory.

#### Raw message header files
After running make raw message files will be located at 
**adore_if_ros_msg/build/devel/include/adore_if_ros_msg**

#### Installation: Debian archive
After running make a debian archive will be located in **adore_if_ros_msg/build** 
which can be installed via dpkg:
```bash
dpkg -i adore_if_ros_msg/build/*.deb
```

#### Installation: System context
You can directly install the adore_if_ros_msg module into your system context 
with cmake:
```bash
cd adore_if_ros_msg/build cmake .. > /dev/null 2>&1 || true cmake --install . ```

#### Sourceing via cmake install context
A Cmake install context is provided upon build which can be added during cmake 
configure to your prefix path. When configuring a build add 
**adore_if_ros_msg/build/install** to your CMAKE_PREFIX_PATH:
```bash
...
cmake .. -DCMAKE_PREFIX_PATH=$(realpath adore_if_ros_msg/build/install)
...
```

#### Adding adore_if_ros_msg to your CMakeLists.txt
Once installed or sourced via the previously described methods you can consume
the adore_if_ros_msg module with CMake by:
1. Using find_package in your CMakeLists.txt to include adore_if_ros_msg
```cmake
find_package(catkin REQUIRED COMPONENTS
  ...
  adore_if_ros_msg
  ...
)
```
2. Adding adore_if_ros_msg to catkin_package in your CMakeLists.txt:
```cmake
catkin_package(
  CATKIN_DEPENDS 
    adore_if_ros_msg 
    ...
)
```

