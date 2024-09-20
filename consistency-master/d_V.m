% d_V between two fold-paths. V is an invicator
% Xs1(:,i) and Xs2(:,j) are the end-points
% Vs1(:,i) and Vs2(:,i) is the V on Xs1(:,i) and Xs2(:,j)
% Linear interpolation is applied to the distribution of V
function disV = d_V(Xs1,Vs1,Xs2,Vs2)
    dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    id_remove1 = dL1<1e-6;
    Xs1(:,id_remove1) = [];
    Vs1(:,id_remove1) = [];
    dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);
    id_remove2 = dL2<1e-6;
    Xs2(:,id_remove2) = [];
    Vs2(:,id_remove2) = [];
    dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);

    us1 = cumsum([0,dL1])/sum(dL1);
    us2 = cumsum([0,dL2])/sum(dL2);
    us = sort(unique([us1,us2]));
    Vs1_interp = zeros([size(Vs1,1),length(us)]);
    Vs2_interp = zeros([size(Vs1,1),length(us)]);
    for j = 1:size(Vs1,1)
        Vs1_interp(j,:) = interp1(us1,Vs1(j,:),us);
        Vs2_interp(j,:) = interp1(us2,Vs2(j,:),us);
    end
    disV = max(vecnorm(Vs1_interp-Vs2_interp,2,1));
end