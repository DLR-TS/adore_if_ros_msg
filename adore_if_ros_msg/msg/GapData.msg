# *******************************************************************************
# * Copyright (C) 2017-2020 German Aerospace Center (DLR). 
# * Eclipse ADORe, Automated Driving Open Research https://eclipse.org/adore
# *
# * This program and the accompanying materials are made available under the 
# * terms of the Eclipse Public License 2.0 which is available at
# * http://www.eclipse.org/legal/epl-2.0.
# *
# * SPDX-License-Identifier: EPL-2.0 
# *
# * Contributors: 
# *  Daniel Heß
# ********************************************************************************

float64 rating# rating of gap: 0 is best, high is bad
bool feasible# can be set to by rating algorithm
float64 anchor_X# gap anchor X coordinate
float64 anchor_Y# gap anchor Y coordinate
float64 anchor_Z# gap anchor Z coordinate
float64 anchor_dX# gap anchor X velocity component
float64 anchor_dY# gap anchor Y velocity component
float64 anchor_dZ# gap anchor Z velocity component
float64 anchor_vt# gap tangential anchor velocity
float64 t_obs# observation time
bool lead_exists# true if a lead vehicle exists
bool chase_exists# true if a chase vehicle exists
float64 s_lead# distance from anchor to lead vehicle rear end along lane at t_obs
float64 s_chase# distance from anchor to chase vehicle front end at t_obs
float64 v_lead# lead vehicle velocity
float64 v_chase# lead vehicle velocity
float64 s_anchor# s value of anchor, relative to lane view
float64 s_gate_opening# distance from anchor to gate opening, negative if gate opening is behind
float64 s_gate_closure# distance from anchor to gate closure, negative if gate closure is behind
