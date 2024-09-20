%% Read the Benchmark
load("BenchmarksInput.mat","Xs_SwWN") % or Xs_SwSN
Xs_input = Xs_SwWN;
%% Reference
Xs0_output = [0,0;40,0];
kappa0_output = [0,0];
%% Path smoothing and trajectory planning
N_curve = length(Xs_input);
Xs_output = cell([1,N_curve]);
kappa_output = cell([1,N_curve]); % Optional
for i = 1:N_curve
    fprintf("%d/%d\n",i,N_curve)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Please smooth Xs_input{i} or plan trajectory here
    % Assume that you get kappa_output here, i.e., the distribution of curvature along toolpaths
    % TODO
    % Output: Xs_output{i} and kappa_output{i}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%% Computation the consistency (For example, the weak consistency w.r.t. curvature direction)
addpath("consistency-master\")
ds_curvature = zeros([N_curve,1]); % d_kappa
errors_contour = zeros([N_curve,1]); % d_infty, i.e., contour error between the input Xs
rho1s = zeros([N_curve,1]); % rho_1
rhos_curvature = zeros([N_curve,1]); % rho_kappa

for i = 1:N_curve
    errors_contour(i) = contour_error(Xs{i}(:,1:2)',Xs0(:,1:2)');
    ds_curvature(i) = d_V(Xs_output{i}(:,1:2)',abs(kappa_output{i}'),Xs0_output(:,1:2)',abs(kappa0_output)');
    rho1s(i) = rho1(Xs{i}',Xs0');
    rhos_curvature(i) = rho_V(Xs_output{i}(:,1:2)',abs(kappa_output{i}'),Xs0_output(:,1:2)',abs(kappa0_output)');
end
%% Results
weak_consistency_curvature = mean(rhos_curvature./rho1s) % weak consistency w.r.t. curvature
strong_consistency_curvature = max(ds_curvature./errors_contour) % strong consistency w.r.t. curvature