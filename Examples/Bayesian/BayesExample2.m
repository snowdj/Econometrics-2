% Example of Bayesian estimation by MCMC
% sampling from exponential(theta) distribution
% lognormal prior

% Shows how MCMC can be used to get posterior mean

% explore different sample sizes, different true thetas


function BayesExample2
	close all;
	n = 30;    % sample size. NOTE: likelihood is computed directly, below. When sample size grows, 
                % IT DISAPPEARS! So, keep <= 2000
	truetheta = 3; % true theta
	y = exprnd(ones(n,1)*truetheta); % sample from exponential(theta)

	S = 5000;
	theta = 2.8; % start value for theta
	tuning = 0.7; % tunes the acceptance rate. Lowering increases acceptance 
                % try to get acceptance rate to be about 0.25 or so
	thetas = zeros(S,1);
	accepts = zeros(S,1);
	for s = 1:S
		thetastar =  proposal(theta, tuning);
		num = likelihood(y, thetastar)*prior(thetastar)*proposal_density(theta, thetastar, tuning);
		den = likelihood(y, theta)*prior(theta)*proposal_density(thetastar, theta, tuning);
		crit = num / den;
		accept = crit > rand(1,1);
		if accept
			theta = thetastar;
		end
		thetas(s,:) = theta;
		accepts(s,:) = accept;
	end
	plot(thetas);
	hold on;
	pm = mean(thetas(500:S,:));
	ps = std(thetas(500:S,:));
	plot([0; S], [pm; pm], 'g');
	plot([0; S], [truetheta; truetheta], 'r');
	legend('chain', 'posterior mean', 'true theta');
	fprintf('posterior mean %f\n', pm);
	fprintf('posterior std. dev.  %f\n', ps);
	fprintf('acceptance rate %f\n', mean(accepts));
	%print -dpng BayesExample2.png;
end


% the prior is lognormal
function p = prior(theta)
	p = lognpdf(theta, 1, 1);
end

% the likelihood function
function dens = likelihood(y, theta)
	% scale is used to try keep the likelihood from going to zero
    % as the sample size increases. Professional software would do
    % this better.
    % it cancels out of the acceptance formula
    scale = 1/0.165;
    dens = scale*(1./theta).*exp(-y./theta);
    dens = prod(dens); % independent obsn
end

% the proposal density: random walk lognormal
function f = proposal_density(thetastar, theta, tuning)
	f = lognpdf(thetastar, log(theta), tuning);
end
% the proposal: random walk lognormal
function thetastar = proposal(theta, tuning)
	thetastar = lognrnd(log(theta), tuning);
end


