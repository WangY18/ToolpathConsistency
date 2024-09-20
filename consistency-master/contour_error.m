% contour error between two fold-paths, i.e., d_infty
% Xs1(:,i) and Xs2(:,j) are the end-points
function dinf = contour_error(Xs1,Xs2)
    dinf = 0;
    for i = 1:size(Xs1,2)
        dinf = max(dinf,dis_Point2Curve(Xs1(:,i),Xs2));
    end
    for i = 1:size(Xs2,2)
        dinf = max(dinf,dis_Point2Curve(Xs2(:,i),Xs1));
    end
end