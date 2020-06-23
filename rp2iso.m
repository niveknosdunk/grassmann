fid=fopen('rp2iso_5000.txt','w');
formatSpec = '%f %f %f %f %f\n';
m = 1/(2*sqrt(3));
for i=1:5000
    X=randn(1,3);
    X=X/norm(X);
    Y=[X(1,2)*X(1,3) X(1,1)*X(1,3) X(1,1)*X(1,2) (1/2)*(X(1,1)^2 - X(1,2)^2) m*(X(1,1)^2 + X(1,2)^2 - 2*X(1,3)^2)];
    fprintf(fid,formatSpec,Y);
end
fclose(fid);