function [residual, g1, g2, g3] = junk_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(11, 1);
T28 = params(1)*exp(y(9))*y(1)^(params(1)-1);
T31 = y(7)^(1-params(1));
T36 = y(1)^params(1);
T39 = y(7)^(-params(1));
lhs =y(11);
rhs =y(5)^(-params(4));
residual(1)= lhs-rhs;
lhs =y(12);
rhs =params(10)*exp(y(10));
residual(2)= lhs-rhs;
lhs =y(13);
rhs =T28*T31;
residual(3)= lhs-rhs;
lhs =y(14);
rhs =exp(y(9))*(1-params(1))*T36*T39;
residual(4)= lhs-rhs;
lhs =y(11);
rhs =params(2)*y(15)*(1+y(16)-params(3));
residual(5)= lhs-rhs;
lhs =y(12)/y(11);
rhs =y(14);
residual(6)= lhs-rhs;
lhs =y(9);
rhs =params(6)*y(2)+params(7)*x(it_, 1);
residual(7)= lhs-rhs;
lhs =y(10);
rhs =params(8)*y(3)+params(9)*x(it_, 2);
residual(8)= lhs-rhs;
lhs =y(4);
rhs =T31*exp(y(9))*T36;
residual(9)= lhs-rhs;
lhs =y(8);
rhs =y(4)-y(5);
residual(10)= lhs-rhs;
lhs =y(6);
rhs =y(8)+y(1)*(1-params(3));
residual(11)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(11, 18);

  %
  % Jacobian matrix
  %

T87 = getPowerDeriv(y(1),params(1),1);
T95 = getPowerDeriv(y(7),1-params(1),1);
  g1(1,5)=(-(getPowerDeriv(y(5),(-params(4)),1)));
  g1(1,11)=1;
  g1(2,10)=(-(params(10)*exp(y(10))));
  g1(2,12)=1;
  g1(3,1)=(-(T31*params(1)*exp(y(9))*getPowerDeriv(y(1),params(1)-1,1)));
  g1(3,7)=(-(T28*T95));
  g1(3,9)=(-(T28*T31));
  g1(3,13)=1;
  g1(4,1)=(-(T39*exp(y(9))*(1-params(1))*T87));
  g1(4,7)=(-(exp(y(9))*(1-params(1))*T36*getPowerDeriv(y(7),(-params(1)),1)));
  g1(4,9)=(-(exp(y(9))*(1-params(1))*T36*T39));
  g1(4,14)=1;
  g1(5,11)=1;
  g1(5,15)=(-(params(2)*(1+y(16)-params(3))));
  g1(5,16)=(-(params(2)*y(15)));
  g1(6,11)=(-y(12))/(y(11)*y(11));
  g1(6,12)=1/y(11);
  g1(6,14)=(-1);
  g1(7,2)=(-params(6));
  g1(7,9)=1;
  g1(7,17)=(-params(7));
  g1(8,3)=(-params(8));
  g1(8,10)=1;
  g1(8,18)=(-params(9));
  g1(9,4)=1;
  g1(9,1)=(-(T31*exp(y(9))*T87));
  g1(9,7)=(-(exp(y(9))*T36*T95));
  g1(9,9)=(-(T31*exp(y(9))*T36));
  g1(10,4)=(-1);
  g1(10,5)=1;
  g1(10,8)=1;
  g1(11,1)=(-(1-params(3)));
  g1(11,6)=1;
  g1(11,8)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],11,324);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],11,5832);
end
end
end
end
