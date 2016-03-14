#{
This script allows you to play around with GMM
esimation of the simple DSGE model. You can
experiment with different moments and different
start values. This should convince you that 
simply getting the GMM estimates can be quite 
difficult.

SA plus start at true values give optimized
function = 0, when exactly identified, so
there is a solution
#}

load dsgedata;
parameters; % load true parameter values
theta0 = lb_param_ub(:,2); 

function m = dsgemoments(theta, data, momentargs)
    e = GetErrors(theta', data);
    e(:,2) = 10*e(:,2); % the other errors have variance = 1
    e(:,5) = 10*e(:,5); % at the true values, this puts these
                        % two on the same scale  
   
    % finish selecting your moments here,
    % one way or another
    % ============ OPTION 1 ========================
    % this option gives exact identification, and works
    % if the start values are the true parameters
    m0 = [e e(:,1).^2 - 1 e(:,3).^2-1 e(:,4).^2 - 1]; % dim is 8 at this point
    m = [m0 m0(:,1).*m0(:,3)]; 
    % ============ END OPTION 1 ====================

    % ============ OPTION 2 ========================
    % this option is overidentifying, crossing 
    % errors with variables, in the typical way
    #{
    m0 = [e e(:,1).^2 - 1 e(:,3).^2-1 e(:,4).^2 - 1]; % dim is 8 at this point
    g0 = size(m0,2);
    k = size(data,2);
    m = zeros(size(m0,1), g0*k);
    data = data(3:end,:);
    for i = 1:k
            m(:,i*g0-g0+1:i*g0) = m0.*data(:,i);
    endfor
    m = [m0 m];
    #}
endfunction

m = dsgemoments(theta0, dsgedata, {});
weight = eye(size(m,2));
lb = lb_param_ub(:,1);
ub = lb_param_ub(:,3);
%thetastart = (ub+lb)/2; % prior mean as start
thetastart = theta0;    % true values as start
% options for simulated annealing
#{
nt = 5;
ns = 3;
rt = 0.75; # careful - this is too low for many problems
maxevals = 1e10;
neps = 5;
functol = 1e-10;
paramtol = 1e-3;
verbosity = 2; # only final results. Inc
minarg = 1;
control = { lb, ub, nt, ns, rt, maxevals, neps, functol, paramtol, verbosity, 1};
#}
% options for bfgs
control = {Inf, 2};
[thetahat, obj_value, convergence] = gmm_estimate(thetastart, dsgedata, weight, "dsgemoments", {}, control);
thetahat 
