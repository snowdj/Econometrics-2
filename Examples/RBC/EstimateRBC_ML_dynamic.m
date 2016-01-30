function [residual, g1, g2, g3] = EstimateRBC_ML_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [M_.exo_nbr by nperiods] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(6, 1);
T13 = params(2)*1/y(9);
T18 = params(1)*y(5)^(params(1)-1);
T28 = 1+T18*(exp(y(11))*y(10))^(1-params(1))-params(3);
T37 = y(1)^params(1);
T42 = (1-params(1))*T37*exp(y(8))^(1-params(1));
T44 = y(7)^(-params(1));
lhs =1/y(4);
rhs =T13*T28;
residual(1)= lhs-rhs;
lhs =y(4)*params(4)/(1-y(7));
rhs =T42*T44;
residual(2)= lhs-rhs;
lhs =y(4)+y(6);
rhs =y(3);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =T37*(y(7)*exp(y(8)))^(1-params(1));
residual(4)= lhs-rhs;
lhs =y(6);
rhs =y(5)-y(1)*(1-params(3));
residual(5)= lhs-rhs;
lhs =y(8);
rhs =params(5)*y(2)+params(6)*x(it_, 1);
residual(6)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(6, 12);

  %
  % Jacobian matrix
  %

  g1(1,4)=(-1)/(y(4)*y(4));
  g1(1,9)=(-(T28*params(2)*(-1)/(y(9)*y(9))));
  g1(1,5)=(-(T13*(exp(y(11))*y(10))^(1-params(1))*params(1)*getPowerDeriv(y(5),params(1)-1,1)));
  g1(1,10)=(-(T13*T18*exp(y(11))*getPowerDeriv(exp(y(11))*y(10),1-params(1),1)));
  g1(1,11)=(-(T13*T18*exp(y(11))*y(10)*getPowerDeriv(exp(y(11))*y(10),1-params(1),1)));
  g1(2,4)=params(4)/(1-y(7));
  g1(2,1)=(-(T44*exp(y(8))^(1-params(1))*(1-params(1))*getPowerDeriv(y(1),params(1),1)));
  g1(2,7)=y(4)*params(4)/((1-y(7))*(1-y(7)))-T42*getPowerDeriv(y(7),(-params(1)),1);
  g1(2,8)=(-(T44*(1-params(1))*T37*exp(y(8))*getPowerDeriv(exp(y(8)),1-params(1),1)));
  g1(3,3)=(-1);
  g1(3,4)=1;
  g1(3,6)=1;
  g1(4,3)=1;
  g1(4,1)=(-((y(7)*exp(y(8)))^(1-params(1))*getPowerDeriv(y(1),params(1),1)));
  g1(4,7)=(-(T37*exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),1)));
  g1(4,8)=(-(T37*y(7)*exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),1)));
  g1(5,1)=1-params(3);
  g1(5,5)=(-1);
  g1(5,6)=1;
  g1(6,2)=(-params(5));
  g1(6,8)=1;
  g1(6,12)=(-params(6));
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,144);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,1728);
end
end
