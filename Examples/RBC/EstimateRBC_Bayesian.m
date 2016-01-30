%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clear all
tic;
global M_ oo_ options_ ys0_ ex0_ estimation_info
options_ = [];
M_.fname = 'EstimateRBC_Bayesian';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('EstimateRBC_Bayesian.log');
M_.exo_names = 'e';
M_.exo_names_tex = 'e';
M_.exo_names_long = 'e';
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names_long = char(M_.endo_names_long, 'n');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.param_names = 'alpha';
M_.param_names_tex = 'alpha';
M_.param_names_long = 'alpha';
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names_long = char(M_.param_names_long, 'psi');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names_long = char(M_.param_names_long, 'rho');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'nss');
M_.param_names_tex = char(M_.param_names_tex, 'nss');
M_.param_names_long = char(M_.param_names_long, 'nss');
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 6;
M_.param_nbr = 7;
M_.orig_endo_nbr = 6;
M_.aux_vars = [];
options_.varobs = [];
options_.varobs = 'c';
options_.varobs_id = [ 2  ];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('EstimateRBC_Bayesian_static');
erase_compiled_function('EstimateRBC_Bayesian_dynamic');
M_.lead_lag_incidence = [
 0 3 0;
 0 4 9;
 1 5 0;
 0 6 0;
 0 7 10;
 2 8 11;]';
M_.nstatic = 2;
M_.nfwrd   = 2;
M_.npred   = 1;
M_.nboth   = 1;
M_.nsfwrd   = 3;
M_.nspred   = 2;
M_.ndynamic   = 4;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(7, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 22;
M_.NNZDerivatives(2) = 37;
M_.NNZDerivatives(3) = -1;
close all;
M_.params( 1 ) = 0.33;
alpha = M_.params( 1 );
M_.params( 2 ) = 0.99;
beta = M_.params( 2 );
M_.params( 3 ) = 0.023;
delta = M_.params( 3 );
M_.params( 5 ) = 0.95;
rho = M_.params( 5 );
M_.params( 6 ) = 0.010606;
sigma = M_.params( 6 );
M_.params( 7 ) = 0.3333333333333333;
nss = M_.params( 7 );
phi = ((1/alpha)*(1/beta -1 + delta)) ^ (1/(1-alpha));
omega = phi^(1-alpha) - delta;
kss = nss/phi;
css = omega*kss;
yss = kss^alpha * nss^(1-alpha);
M_.params( 4 ) = (1-M_.params(7))/css*(1-M_.params(1))*kss^M_.params(1)*M_.params(7)^(-M_.params(1));
psi = M_.params( 4 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = kss;
oo_.steady_state( 2 ) = css;
oo_.steady_state( 5 ) = M_.params(7);
oo_.steady_state( 1 ) = yss;
oo_.steady_state( 6 ) = 0;
oo_.exo_steady_state( 1 ) = 0;
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 1;
steady;
global estim_params_
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 1, 0.3, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, NaN, (-Inf), Inf, 1, 0.95, 0.03, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, NaN, (-Inf), Inf, 1, 0.03, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.9, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, 0.010606, (-Inf), Inf, 4, 0.015, Inf, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 1, 0.3, 0.05, NaN, NaN, NaN ];
options_.mh_nblck = 1;
options_.mh_replic = 500;
options_.order = 2;
options_.datafile = 'c';
options_.nobs = 160;
options_.particle.status = 1;
var_list_=[];
var_list_ = 'y';
var_list_ = char(var_list_, 'c');
var_list_ = char(var_list_, 'k');
var_list_ = char(var_list_, 'i');
var_list_ = char(var_list_, 'n');
dynare_estimation(var_list_);
save('EstimateRBC_Bayesian_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('EstimateRBC_Bayesian_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('EstimateRBC_Bayesian_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('EstimateRBC_Bayesian_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('EstimateRBC_Bayesian_results.mat', 'estimation_info', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
