import edu.stanford.math.plex4.*

fid=fopen('g24_5000norm.txt','w');
formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';
M=zeros(5000,16);

for i=1:5000
   v = randn(4,1);
   v = v/norm(v);
   w = randn(4,1);
   c = dot(w,v)*v;
   u = w - c;
   u = u/norm(u);
   A = zeros(4,2);
   A(:,1) = v;
   A(:,2) = u;
   B = A*A';
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

num_landmark_points = 300;
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