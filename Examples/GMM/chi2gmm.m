% GMM estimation for a sample from Chi^2(theta)
% compare to two method of moments estimators (see chi2mm.m)
n = 30;
theta = 3;
data = chi2rnd(theta, n, 1);

% MM 1
thetahat = mean(data);
fprintf('MM, v1: %f\n', thetahat);

% MM2
thetahat = 0.5*var(data);
fprintf('MM, v2: %f\n', thetahat);

% GMM
W = eye(2);
thetahat = fminunc(@(theta) [theta-mean(data); theta-0.5*var(data)]'*[theta-mean(data); theta-0.5*var(data)], 0);
fprintf('GMM: %f\n', thetahat);

