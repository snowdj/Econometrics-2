%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clear all
tic;
global M_ oo_ options_ ys0_ ex0_ estimation_info
options_ = [];
M_.fname = 'junk';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('junk.log');
M_.exo_names = 'e1';
M_.exo_names_tex = 'e1';
M_.exo_names_long = 'e1';
M_.exo_names = char(M_.exo_names, 'e2');
M_.exo_names_tex = char(M_.exo_names_tex, 'e2');
M_.exo_names_long = char(M_.exo_names_long, 'e2');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names_long = char(M_.endo_names_long, 'n');
M_.endo_names = char(M_.endo_names, 'invest');
M_.endo_names_tex = char(M_.endo_names_tex, 'invest');
M_.endo_names_long = char(M_.endo_names_long, 'invest');
M_.endo_names = char(M_.endo_names, 'z1');
M_.endo_names_tex = char(M_.endo_names_tex, 'z1');
M_.endo_names_long = char(M_.endo_names_long, 'z1');
M_.endo_names = char(M_.endo_names, 'z2');
M_.endo_names_tex = char(M_.endo_names_tex, 'z2');
M_.endo_names_long = char(M_.endo_names_long, 'z2');
M_.endo_names = char(M_.endo_names, 'MUC');
M_.endo_names_tex = char(M_.endo_names_tex, 'MUC');
M_.endo_names_long = char(M_.endo_names_long, 'MUC');
M_.endo_names = char(M_.endo_names, 'MUL');
M_.endo_names_tex = char(M_.endo_names_tex, 'MUL');
M_.endo_names_long = char(M_.endo_names_long, 'MUL');
M_.endo_names = char(M_.endo_names, 'MPK');
M_.endo_names_tex = char(M_.endo_names_tex, 'MPK');
M_.endo_names_long = char(M_.endo_names_long, 'MPK');
M_.endo_names = char(M_.endo_names, 'MPL');
M_.endo_names_tex = char(M_.endo_names_tex, 'MPL');
M_.endo_names_long = char(M_.endo_names_long, 'MPL');
M_.param_names = 'alppha';
M_.param_names_tex = 'alppha';
M_.param_names_long = 'alppha';
M_.param_names = char(M_.param_names, 'betta');
M_.param_names_tex = char(M_.param_names_tex, 'betta');
M_.param_names_long = char(M_.param_names_long, 'betta');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'gam');
M_.param_names_tex = char(M_.param_names_tex, 'gam');
M_.param_names_long = char(M_.param_names_long, 'gam');
M_.param_names = char(M_.param_names, 'nss');
M_.param_names_tex = char(M_.param_names_tex, 'nss');
M_.param_names_long = char(M_.param_names_long, 'nss');
M_.param_names = char(M_.param_names, 'rho1');
M_.param_names_tex = char(M_.param_names_tex, 'rho1');
M_.param_names_long = char(M_.param_names_long, 'rho1');
M_.param_names = char(M_.param_names, 'sigma1');
M_.param_names_tex = char(M_.param_names_tex, 'sigma1');
M_.param_names_long = char(M_.param_names_long, 'sigma1');
M_.param_names = char(M_.param_names, 'rho2');
M_.param_names_tex = char(M_.param_names_tex, 'rho2');
M_.param_names_long = char(M_.param_names_long, 'rho2');
M_.param_names = char(M_.param_names, 'sigma2');
M_.param_names_tex = char(M_.param_names_tex, 'sigma2');
M_.param_names_long = char(M_.param_names_long, 'sigma2');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names_long = char(M_.param_names_long, 'psi');
M_.param_names = char(M_.param_names, 'c1');
M_.param_names_tex = char(M_.param_names_tex, 'c1');
M_.param_names_long = char(M_.param_names_long, 'c1');
M_.param_names = char(M_.param_names, 'iss');
M_.param_names_tex = char(M_.param_names_tex, 'iss');
M_.param_names_long = char(M_.param_names_long, 'iss');
M_.param_names = char(M_.param_names, 'yss');
M_.param_names_tex = char(M_.param_names_tex, 'yss');
M_.param_names_long = char(M_.param_names_long, 'yss');
M_.param_names = char(M_.param_names, 'kss');
M_.param_names_tex = char(M_.param_names_tex, 'kss');
M_.param_names_long = char(M_.param_names_long, 'kss');
M_.param_names = char(M_.param_names, 'css');
M_.param_names_tex = char(M_.param_names_tex, 'css');
M_.param_names_long = char(M_.param_names_long, 'css');
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 11;
M_.param_nbr = 15;
M_.orig_endo_nbr = 11;
M_.aux_vars = [];
options_.varobs = [];
options_.varobs = 'c';
options_.varobs = char(options_.varobs, 'n');
options_.varobs_id = [ 2 4  ];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('junk_static');
erase_compiled_function('junk_dynamic');
M_.lead_lag_incidence = [
 0 4 0;
 0 5 0;
 1 6 0;
 0 7 0;
 0 8 0;
 2 9 0;
 3 10 0;
 0 11 15;
 0 12 0;
 0 13 16;
 0 14 0;]';
M_.nstatic = 6;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 3;
M_.ndynamic   = 5;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(11, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(15, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 34;
M_.NNZDerivatives(2) = 34;
M_.NNZDerivatives(3) = 87;
close all;
load parameterfile;
set_param_value('alppha',alpha)
set_param_value('betta',beta)
set_param_value('delta',delta)
set_param_value('gam',gam)
set_param_value('rho1',rho1)
set_param_value('sigma1',sigma1)
set_param_value('rho2',rho2)
set_param_value('sigma2',sigma2)
set_param_value('nss',nss)
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 1;
M_.Sigma_e(2, 2) = 1;
global estim_params_
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 5, NaN, NaN, 0.3, 0.4, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 5, NaN, NaN, 0.0, 5.0, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 5, NaN, NaN, 0.0, 1.0, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 5, NaN, NaN, 0.0, 0.1, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 5, NaN, NaN, 0.0, 1.0, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 5, NaN, NaN, 0.0, 0.1, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 5, NaN, NaN, 0.25, 0.375, NaN ];
options_.irf = 40;
options_.mh_init_scale = 5;
options_.mh_jscale = 0.8;
options_.mh_nblck = 1;
options_.mh_replic = 1000;
options_.order = 2;
options_.datafile = 'dsgedata';
options_.nobs = 160;
options_.particle.status = 1;
var_list_=[];
var_list_ = 'y';
var_list_ = char(var_list_, 'c');
var_list_ = char(var_list_, 'n');
var_list_ = char(var_list_, 'MPK');
var_list_ = char(var_list_, 'MPL');
dynare_estimation(var_list_);
options_.irf = 30;
options_.order = 3;
options_.periods = 260;
var_list_=[];
var_list_ = 'y';
var_list_ = char(var_list_, 'c');
var_list_ = char(var_list_, 'n');
var_list_ = char(var_list_, 'MPK');
var_list_ = char(var_list_, 'MPL');
info = stoch_simul(var_list_);
save('junk_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('junk_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('junk_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('junk_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('junk_results.mat', 'estimation_info', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
