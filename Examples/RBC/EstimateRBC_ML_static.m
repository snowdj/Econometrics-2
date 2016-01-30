function [residual, g1, g2] = EstimateRBC_ML_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                     columns: variables in declaration order
%                                                     rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 6, 1);

%
% Model equations
%

T11 = 1/y(2)*params(2);
T16 = params(1)*y(3)^(params(1)-1);
T22 = (exp(y(6))*y(5))^(1-params(1));
T26 = 1+T16*T22-params(3);
T33 = y(3)^params(1);
T36 = (1-params(1))*T33*exp(y(6))^(1-params(1));
T38 = y(5)^(-params(1));
T91 = exp(y(6))*y(5)*getPowerDeriv(exp(y(6))*y(5),1-params(1),1);
lhs =1/y(2);
rhs =T11*T26;
residual(1)= lhs-rhs;
lhs =y(2)*params(4)/(1-y(5));
rhs =T36*T38;
residual(2)= lhs-rhs;
lhs =y(2)+y(4);
rhs =y(1);
residual(3)= lhs-rhs;
lhs =y(1);
rhs =T22*T33;
residual(4)= lhs-rhs;
lhs =y(4);
rhs =y(3)-y(3)*(1-params(3));
residual(5)= lhs-rhs;
lhs =y(6);
rhs =y(6)*params(5)+params(6)*x(1);
residual(6)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(6, 6);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-1)/(y(2)*y(2))-T26*params(2)*(-1)/(y(2)*y(2));
  g1(1,3)=(-(T11*T22*params(1)*getPowerDeriv(y(3),params(1)-1,1)));
  g1(1,5)=(-(T11*T16*exp(y(6))*getPowerDeriv(exp(y(6))*y(5),1-params(1),1)));
  g1(1,6)=(-(T11*T16*T91));
  g1(2,2)=params(4)/(1-y(5));
  g1(2,3)=(-(T38*exp(y(6))^(1-params(1))*(1-params(1))*getPowerDeriv(y(3),params(1),1)));
  g1(2,5)=y(2)*params(4)/((1-y(5))*(1-y(5)))-T36*getPowerDeriv(y(5),(-params(1)),1);
  g1(2,6)=(-(T38*(1-params(1))*T33*exp(y(6))*getPowerDeriv(exp(y(6)),1-params(1),1)));
  g1(3,1)=(-1);
  g1(3,2)=1;
  g1(3,4)=1;
  g1(4,1)=1;
  g1(4,3)=(-(T22*getPowerDeriv(y(3),params(1),1)));
  g1(4,5)=(-(T33*exp(y(6))*getPowerDeriv(exp(y(6))*y(5),1-params(1),1)));
  g1(4,6)=(-(T33*T91));
  g1(5,3)=(-(1-(1-params(3))));
  g1(5,4)=1;
  g1(6,6)=1-params(5);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,36);
end
end
