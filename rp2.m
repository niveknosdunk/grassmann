fid=fopen('rp2r4_5000.txt','w');
formatSpec = '%f %f %f %f\n';
for i=1:5000
    X=randn(1,3);
    X=X/norm(X);
    Y=[X(1,1)*X(1,2) X(1,1)*X(1,3) X(1,2)^2-X(1,3)^2 2*X(1,2)*X(1,3)];
    fprintf(fid,formatSpec,Y);
end
fclose(fid);