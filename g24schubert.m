import edu.stanford.math.plex4.*

fid=fopen('g24_5000schubert.txt','w');
formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';
M=zeros(5000,16);

for i=1:250
   v = eye(4,1);
   %v = v/norm(v);
   w = [randn; randn; 1; 0];
   c = dot(w,v)*v;
   u = w - c;
   u = u/norm(u);
   A = zeros(4,2);
   A(:,1) = v;
   A(:,2) = u;
   X = RandOrthMat(4);
   B = X*A*A'*X';
   R = [B(1,:),B(2,:),B(3,:),B(4,:)];
    fprintf(fid,formatSpec,R);
   M(i,:) = R; 
end

for i=251:1000
   v = eye(4,1);
   %v = v/norm(v);
   w = [randn; randn; randn; 1];
   c = dot(w,v)*v;
   u = w - c;
   u = u/norm(u);
   A = zeros(4,2);
   A(:,1) = v;
   A(:,2) = u;
   X = RandOrthMat(4);
   B = X*A*A'*X';
   R = [B(1,:),B(2,:),B(3,:),B(4,:)];
    fprintf(fid,formatSpec,R);
   M(i,:) = R; 
end

for i=1001:1750
   v = [randn; 1; 0; 0];
   v = v/norm(v);
   w = [randn; randn; 1; 0];
   c = dot(w,v)*v;
   u = w - c;
   u = u/norm(u);
   A = zeros(4,2);
   A(:,1) = v;
   A(:,2) = u;
   X = RandOrthMat(4);
   B = X*A*A'*X';
   R = [B(1,:),B(2,:),B(3,:),B(4,:)];
    fprintf(fid,formatSpec,R);
   M(i,:) = R; 
end

for i=1751:3000
   v = [randn; 1; 0; 0];
   v = v/norm(v);
   w = [randn; randn; randn; 1];
   c = dot(w,v)*v;
   u = w - c;
   u = u/norm(u);
   A = zeros(4,2);
   A(:,1) = v;
   A(:,2) = u;
   X = RandOrthMat(4);
   B = X*A*A'*X';
   R = [B(1,:),B(2,:),B(3,:),B(4,:)];
    fprintf(fid,formatSpec,R);
   M(i,:) = R; 
end

for i=3001:5000
   v = [randn; randn; 1; 0];
   v = v/norm(v);
   w = [randn; randn; randn; 1];
   c = dot(w,v)*v;
   u = w - c;
   u = u/norm(u);
   A = zeros(4,2);
   A(:,1) = v;
   A(:,2) = u;
   X = RandOrthMat(4);
   B = X*A*A'*X';
   R = [B(1,:),B(2,:),B(3,:),B(4,:)];
    fprintf(fid,formatSpec,R);
   M(i,:) = R; 
end

fclose(fid);

max_dimension = 5;
num_divisions = 20;
point_cloud = M;

%max_filtration_value = 1.5;
%stream = api.Plex4.createVietorisRipsStream(point_cloud, max_dimension, max_filtration_value, num_divisions);

num_landmark_points = 100;
%landmark_selector = api.Plex4.createRandomSelector(point_cloud, num_landmark_points);
landmark_selector = api.Plex4.createMaxMinSelector(point_cloud, num_landmark_points);
S = landmark_selector.getMaxDistanceFromPointsToLandmarks();
max_filtration_value = S / 6;
stream = api.Plex4.createWitnessStream(landmark_selector, max_dimension, max_filtration_value, num_divisions);
num_simplices = stream.getSize()

persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);
intervals = persistence.computeIntervals(stream);

options.filename = 'g24';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(intervals, options);

fid=fopen('g24_landmarks.txt','w');
formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';
D=zeros(num_landmark_points,16);
C = landmark_selector.getLandmarkPoints();
for i=1:num_landmark_points
    D(i,:) = M(C(i,1),:);
    fprintf(fid,formatSpec,D(i,:));
end

fclose(fid);

function N=RandOrthMat(n, tol)
% M = RANDORTHMAT(n)
% generates a random n x n orthogonal real matrix.
%
% M = RANDORTHMAT(n,tol)
% explicitly specifies a thresh value that measures linear dependence
% of a newly formed column with the existing columns. Defaults to 1e-6.
%
% In this version the generated matrix distribution *is* uniform over the manifold
% O(n) w.r.t. the induced R^(n^2) Lebesgue measure, at a slight computational 
% overhead (randn + normalization, as opposed to rand ). 
% 
% (c) Ofek Shilon , 2006.


    if nargin==1
	  tol=1e-6;
    end
    
    N = zeros(n); % prealloc
    
    % gram-schmidt on random column vectors
    
    vi = randn(n,1);  
    % the n-dimensional normal distribution has spherical symmetry, which implies
    % that after normalization the drawn vectors would be uniformly distributed on the
    % n-dimensional unit sphere.

    N(:,1) = vi ./ norm(vi);
    
    for i=2:n
	  nrm = 0;
	  while nrm<tol
		vi = randn(n,1);
		vi = vi -  N(:,1:i-1)  * ( N(:,1:i-1).' * vi )  ;
		nrm = norm(vi);
	  end
	  N(:,i) = vi ./ nrm;

    end %i
        
end  % RandOrthMat