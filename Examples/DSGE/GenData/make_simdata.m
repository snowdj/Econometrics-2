% generates a sample of size 160 from the simple DSGE model
system("ln -s ../Common/TEMPLATEMODFILE* ./")
outfile = "simdata.design";
reps = 1;  % total replications

parameters; % load information from common, to sync with ASBIL
model_params0 = lb_param_ub(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% you do not need to alter anything below this line %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
model_params = model_params0;
% break into pieces
alpha = model_params(1,:);
beta  = model_params(2,:);
delta = model_params(3,:);
gam   = model_params(4,:);
rho1   = model_params(5,:);
sigma1 = model_params(6,:);
rho2   = model_params(7,:);
sigma2 = model_params(8,:);
nss   = model_params(9,:);

% the psi implied by other parameters
c1 = ((1/beta + delta - 1)/alpha)^(1/(1-alpha));
kss = nss/c1;
css = kss * (c1^(1-alpha) - delta);
c2 = (css)^(-gam/alpha);
psi = (1-alpha)*((c1/c2)^(-alpha));

save parameterfile  alpha beta delta gam rho1 sigma1 rho2 sigma2 nss;

% get the RNG state on this node, to re-establish separate
% states on nodes after running Dynare, which synchronizes them
%RNGstate = rand('state');

dynare TEMPLATEMODFILE noclearall;
% get a simulation of length 160 and compute aux. statistic
data = [y c n MPK MPL];
data = data(101:260,:);
save -ascii dsgedata data;
system("./cleanup"); % remove Dynare leftovers
