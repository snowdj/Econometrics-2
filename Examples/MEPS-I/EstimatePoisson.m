# This does simple Poisson estimation using the meps1996.data 

# The MEPS data

# Define dep and expl vbls
# 
# 	The dep. vbls, in corresponding column
# 	Office based doctor visits	1
# 	Outpatient doctor visits	2
# 	Emergency room visits		3
# 	Inpatient visits		4
# 	Dental visits			5
# 	Prescriptions			6
# 	

which_dep = 1;
if (which_dep == 1) dep = "OBDV";   endif
if (which_dep == 2) dep = "OPV";    endif
if (which_dep == 3) dep = "IPV";    endif
if (which_dep == 4) dep = "ERV";    endif
if (which_dep == 5) dep = "DV";     endif
if (which_dep == 6) dep = "PRESCR"; endif
load meps1996.data;
y = data(:,which_dep);
x = data(:,7:12);
n = rows(x);
x = [ones(n,1) x];
%x(:,end) = x(:,end)/1000; # put income in thousands
% choose one of the next 2 lines to see the effects of scaling the data
[x scale] = scale_data(x); # scale the data
%scale = 0; # don't scale the data
data = [y x ];
names = char("constant","pub. ins.","priv. ins.", "sex", "age","edu","inc");
model = "Poisson";
modelargs = "";
theta = zeros(columns(x),1);
title = sprintf("Poisson model, %s, MEPS 1996 full data set", dep);
control = {Inf, 3, 1, 1, 5};
[thetahat junk logL] = mle_results(theta, data, model, modelargs, names, title, scale, control);

