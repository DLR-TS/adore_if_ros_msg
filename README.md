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

## Setup
This repository may be used on a system, which fulfills a set of requirements [adore_setup](https://github.com/dlr-ts/adore_setup).
After checkout, enter make in the top level of the repository in order to build.