% rho_1 between two fold-paths
% Xs1(:,i) and Xs2(:,j) are the end-points
function dis_rho1 = rho1(Xs1,Xs2)
    %%
    dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    id_remove1 = dL1==0;
    Xs1(:,id_remove1) = [];
    dL1 = vecnorm(Xs1(:,2:end)-Xs1(:,1:end-1),2,1);
    
    dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);
    id_remove2 = dL2==0;
    Xs2(:,id_remove2) = [];
    dL2 = vecnorm(Xs2(:,2:end)-Xs2(:,1:end-1),2,1);
    %% 
    T1 = (Xs1(:,2:end)-Xs1(:,1:end-1))./dL1;
    T2 = (Xs2(:,2:end)-Xs2(:,1:end-1))./dL2;
    us1 = cumsum([0,dL1])/sum(dL1);
    us2 = cumsum([0,dL2])/sum(dL2);
    us1(end) = 1;
    us2(end) = 1;
    id1 = 1; % from us1(id1) to us1(id1+1)
    id2 = 1; % from us2(id2) to us2(id2+1)
    dis_rho1 = 0;
    while id1<length(us1) || id2<length(us2)
        if id1==length(us1)-1
            for j = id2:length(us2)-1
                uleft = max(us1(id1),us2(j));
                uright = us2(j+1);
                dis_rho1 = dis_rho1 + norm(T1(:,id1)-T2(:,j))*(uright-uleft);
            end
            break;
        end
        if id2==length(us2)-1
            for j = id1:length(us1)-1
                uleft = max(us1(j),us2(id2));
                uright = us1(j+1);
                dis_rho1 = dis_rho1 + norm(T1(:,j)-T2(:,id2))*(uright-uleft);
            end
            break;
        end
        uleft = max(us1(id1),us2(id2));
        uright = min(us1(id1+1),us2(id2+1));
        dis_rho1 = dis_rho1 + norm(T1(:,id1)-T2(:,id2))*(uright-uleft);
        if uright==us1(id1+1)
            id1 = id1 + 1;
        end
        if uright==us2(id2+1)
            id2 = id2 + 1;
        end
    end
end