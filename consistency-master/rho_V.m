% rho_V between two fold-paths. V is an invicator
% Xs1(:,i) and Xs2(:,j) are the end-points
% Vs1(:,i) and Vs2(:,i) is the V on Xs1(:,i) and Xs2(:,j)
% Linear interpolation is applied to the distribution of V
% L_interp is the interpolation length
function rhoV = rho_V(Xs1,Vs1,Xs2,Vs2,L_interp)
    dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    id_remove1 = dL1<1e-6;
    Xs1(:,id_remove1) = [];
    Vs1(:,id_remove1) = [];
    dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    if nargin>=5 && ~isempty(L_interp) && L_interp<max(dL1)
        PointsNum = ceil(dL1/L_interp);
        Xs1_new = zeros([size(Xs1,1),1+sum(PointsNum)]);
        Vs1_new = zeros([size(Vs1,1),1+sum(PointsNum)]);
        Xs1_new(:,1) = Xs1(:,1);
        Vs1_new(:,1) = Vs1(:,1);
        IDnow = 1;
        for i = 1:length(dL1)
            Xs1_new(:,IDnow:IDnow+PointsNum(i)) = Xs1(:,i) + (Xs1(:,i+1)-Xs1(:,i)).*linspace(0,1,PointsNum(i)+1);
            Vs1_new(:,IDnow:IDnow+PointsNum(i)) = Vs1(:,i) + (Vs1(:,i+1)-Vs1(:,i)).*linspace(0,1,PointsNum(i)+1);
            IDnow = IDnow + PointsNum(i);
        end
        Xs1 = Xs1_new;
        Vs1 = Vs1_new;
        dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    end

    dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);
    id_remove2 = dL2<1e-6;
    Xs2(:,id_remove2) = [];
    Vs2(:,id_remove2) = [];
    dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);
    if nargin>=5 && ~isempty(L_interp) && L_interp<max(dL2)
        PointsNum = ceil(dL2/L_interp);
        Xs2_new = zeros([size(Xs2,1),1+sum(PointsNum)]);
        Vs2_new = zeros([size(Vs2,1),1+sum(PointsNum)]);
        Xs2_new(:,1) = Xs2(:,1);
        Vs2_new(:,1) = Vs2(:,1);
        IDnow = 1;
        for i = 1:length(dL2)
            Xs2_new(:,IDnow:IDnow+PointsNum(i)) = Xs2(:,i) + (Xs2(:,i+1)-Xs2(:,i)).*linspace(0,1,PointsNum(i)+1);
            Vs2_new(:,IDnow:IDnow+PointsNum(i)) = Vs2(:,i) + (Vs2(:,i+1)-Vs2(:,i)).*linspace(0,1,PointsNum(i)+1);
            IDnow = IDnow + PointsNum(i);
        end
        Xs2 = Xs2_new;
        Vs2 = Vs2_new;
        dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);
    end

    us1 = cumsum([0,dL1])/sum(dL1);
    us2 = cumsum([0,dL2])/sum(dL2);
    us = sort(unique([us1,us2]));
    Vs1_interp = zeros([size(Vs1,1),length(us)]);
    Vs2_interp = zeros([size(Vs1,1),length(us)]);
    for j = 1:size(Vs1,1)
        Vs1_interp(j,:) = [Vs1(j,1),interp1(us1,Vs1(j,:),us(2:end-1)),Vs1(j,end)];
        Vs2_interp(j,:) = [Vs2(j,1),interp1(us2,Vs2(j,:),us(2:end-1)),Vs2(j,end)];
    end

    V_interp = vecnorm(Vs1_interp-Vs2_interp,2,1);
    rhoV = trapz(us,V_interp);
end