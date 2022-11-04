# PathRequest is a set-trajectory format alternative to SetPointRequest
# The trajectory is formulated as piecewise-cubic splines in x,y,s and t, 
# where breaks for the spline are selected arbitrarily
float64[] spline_breaks
float64[] spline_x_coef #X_utm spline
float64[] spline_y_coef #Y_utm spline
float64[] spline_s_coef #path integral
float64[] spline_t_coef #timing
