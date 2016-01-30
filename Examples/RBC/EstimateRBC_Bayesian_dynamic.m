function [residual, g1, g2, g3] = EstimateRBC_Bayesian_dynamic(y, x, params, steady_state, it_)
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
T24 = (exp(y(11))*y(10))^(1-params(1));
T28 = 1+T18*T24-params(3);
T37 = y(1)^params(1);
T41 = exp(y(8))^(1-params(1));
T42 = (1-params(1))*T37*T41;
T44 = y(7)^(-params(1));
T52 = (y(7)*exp(y(8)))^(1-params(1));
T72 = params(2)*(-1)/(y(9)*y(9));
T75 = getPowerDeriv(y(1),params(1),1);
T84 = params(1)*getPowerDeriv(y(5),params(1)-1,1);
T85 = T24*T84;
T91 = getPowerDeriv(y(7),(-params(1)),1);
T95 = exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),1);
T99 = exp(y(11))*getPowerDeriv(exp(y(11))*y(10),1-params(1),1);
T100 = T18*T99;
T105 = exp(y(8))*getPowerDeriv(exp(y(8)),1-params(1),1);
T106 = (1-params(1))*T37*T105;
T109 = y(7)*exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),1);
T112 = exp(y(11))*y(10)*getPowerDeriv(exp(y(11))*y(10),1-params(1),1);
T113 = T18*T112;
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
rhs =T37*T52;
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
  g1(1,9)=(-(T28*T72));
  g1(1,5)=(-(T13*T85));
  g1(1,10)=(-(T13*T100));
  g1(1,11)=(-(T13*T113));
  g1(2,4)=params(4)/(1-y(7));
  g1(2,1)=(-(T44*T41*(1-params(1))*T75));
  g1(2,7)=y(4)*params(4)/((1-y(7))*(1-y(7)))-T42*T91;
  g1(2,8)=(-(T44*T106));
  g1(3,3)=(-1);
  g1(3,4)=1;
  g1(3,6)=1;
  g1(4,3)=1;
  g1(4,1)=(-(T52*T75));
  g1(4,7)=(-(T37*T95));
  g1(4,8)=(-(T37*T109));
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

  v2 = zeros(37,3);
  v2(1,1)=1;
  v2(1,2)=40;
  v2(1,3)=(y(4)+y(4))/(y(4)*y(4)*y(4)*y(4));
  v2(2,1)=1;
  v2(2,2)=105;
  v2(2,3)=(-(T28*params(2)*(y(9)+y(9))/(y(9)*y(9)*y(9)*y(9))));
  v2(3,1)=1;
  v2(3,2)=57;
  v2(3,3)=(-(T72*T85));
  v2(4,1)=1;
  v2(4,2)=101;
  v2(4,3)=  v2(3,3);
  v2(5,1)=1;
  v2(5,2)=53;
  v2(5,3)=(-(T13*T24*params(1)*getPowerDeriv(y(5),params(1)-1,2)));
  v2(6,1)=1;
  v2(6,2)=117;
  v2(6,3)=(-(T72*T100));
  v2(7,1)=1;
  v2(7,2)=106;
  v2(7,3)=  v2(6,3);
  v2(8,1)=1;
  v2(8,2)=113;
  v2(8,3)=(-(T13*T84*T99));
  v2(9,1)=1;
  v2(9,2)=58;
  v2(9,3)=  v2(8,3);
  v2(10,1)=1;
  v2(10,2)=118;
  v2(10,3)=(-(T13*T18*exp(y(11))*exp(y(11))*getPowerDeriv(exp(y(11))*y(10),1-params(1),2)));
  v2(11,1)=1;
  v2(11,2)=129;
  v2(11,3)=(-(T72*T113));
  v2(12,1)=1;
  v2(12,2)=107;
  v2(12,3)=  v2(11,3);
  v2(13,1)=1;
  v2(13,2)=125;
  v2(13,3)=(-(T13*T84*T112));
  v2(14,1)=1;
  v2(14,2)=59;
  v2(14,3)=  v2(13,3);
  v2(15,1)=1;
  v2(15,2)=130;
  v2(15,3)=(-(T13*T18*(T99+exp(y(11))*y(10)*exp(y(11))*getPowerDeriv(exp(y(11))*y(10),1-params(1),2))));
  v2(16,1)=1;
  v2(16,2)=119;
  v2(16,3)=  v2(15,3);
  v2(17,1)=1;
  v2(17,2)=131;
  v2(17,3)=(-(T13*T18*(T112+exp(y(11))*y(10)*exp(y(11))*y(10)*getPowerDeriv(exp(y(11))*y(10),1-params(1),2))));
  v2(18,1)=2;
  v2(18,2)=1;
  v2(18,3)=(-(T44*T41*(1-params(1))*getPowerDeriv(y(1),params(1),2)));
  v2(19,1)=2;
  v2(19,2)=76;
  v2(19,3)=params(4)/((1-y(7))*(1-y(7)));
  v2(20,1)=2;
  v2(20,2)=43;
  v2(20,3)=  v2(19,3);
  v2(21,1)=2;
  v2(21,2)=73;
  v2(21,3)=(-(T41*(1-params(1))*T75*T91));
  v2(22,1)=2;
  v2(22,2)=7;
  v2(22,3)=  v2(21,3);
  v2(23,1)=2;
  v2(23,2)=79;
  v2(23,3)=(-(y(4)*params(4)*((-(1-y(7)))-(1-y(7)))))/((1-y(7))*(1-y(7))*(1-y(7))*(1-y(7)))-T42*getPowerDeriv(y(7),(-params(1)),2);
  v2(24,1)=2;
  v2(24,2)=85;
  v2(24,3)=(-(T44*(1-params(1))*T75*T105));
  v2(25,1)=2;
  v2(25,2)=8;
  v2(25,3)=  v2(24,3);
  v2(26,1)=2;
  v2(26,2)=91;
  v2(26,3)=(-(T91*T106));
  v2(27,1)=2;
  v2(27,2)=80;
  v2(27,3)=  v2(26,3);
  v2(28,1)=2;
  v2(28,2)=92;
  v2(28,3)=(-(T44*(1-params(1))*T37*(T105+exp(y(8))*exp(y(8))*getPowerDeriv(exp(y(8)),1-params(1),2))));
  v2(29,1)=4;
  v2(29,2)=1;
  v2(29,3)=(-(T52*getPowerDeriv(y(1),params(1),2)));
  v2(30,1)=4;
  v2(30,2)=73;
  v2(30,3)=(-(T75*T95));
  v2(31,1)=4;
  v2(31,2)=7;
  v2(31,3)=  v2(30,3);
  v2(32,1)=4;
  v2(32,2)=79;
  v2(32,3)=(-(T37*exp(y(8))*exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),2)));
  v2(33,1)=4;
  v2(33,2)=85;
  v2(33,3)=(-(T75*T109));
  v2(34,1)=4;
  v2(34,2)=8;
  v2(34,3)=  v2(33,3);
  v2(35,1)=4;
  v2(35,2)=91;
  v2(35,3)=(-(T37*(T95+y(7)*exp(y(8))*exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),2))));
  v2(36,1)=4;
  v2(36,2)=80;
  v2(36,3)=  v2(35,3);
  v2(37,1)=4;
  v2(37,2)=92;
  v2(37,3)=(-(T37*(T109+y(7)*exp(y(8))*y(7)*exp(y(8))*getPowerDeriv(y(7)*exp(y(8)),1-params(1),2))));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),6,144);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,1728);
end
end
