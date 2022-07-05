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
# *  Thomas Lobig
# ********************************************************************************
bool isValid
LinearPiecewiseFunction3d centerline                #s->x,y,z
LinearPiecewiseFunction2d centerNormal              #s->nx,ny
LinearPiecewiseFunction1d leftDistance              #s->dl
LinearPiecewiseFunction1d rightDistance             #s->dr
LinearPiecewiseFunction1d centerCurvature           #s->kappa
LinearPiecewiseFunction1d centerCurvatureDerivative #s->dkappa/ds
LinearPiecewiseFunction1d navigationCost            #s->c
LinearPiecewiseFunction1d speedLimit                #s->v
LinearPiecewiseFunction1d leftIndicatorHint         #s->indicator left
LinearPiecewiseFunction1d rightIndicatorHint        #s->indicator right

#speedLimit
#speedRecommendation (has -> bool, get -> double)
#get Heading -> double
#get Curvature