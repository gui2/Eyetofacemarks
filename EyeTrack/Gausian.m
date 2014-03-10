addpath sc

MU = [1 2;2 4];
SIGMA = cat(3,[2 0;0 .5],[1 0;0 1]);
p = ones(1,2)/2;
obj = gmdistribution(MU,SIGMA,p);
figure
ezcontour(@(x,y)pdf(obj,[x y]),[-10 10],[-10 10])

A = sc(cat(3, SIGMA), 'prob');
imshow(A);


