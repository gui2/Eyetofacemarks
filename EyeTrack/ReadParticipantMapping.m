clear all
close all

fname ='subjects.csv';
load mapping.mat;
inputs = repmat('%s',1,13);
[A B	C   D   E   F  G  H  I  J  K  L  O ]	= ...     
  textread(fname,inputs,'delimiter',',','emptyvalue',NaN,'headerlines',1);

for ( i=1:length(C))
    for ( j=1:length(wwd(:,4)))
    if (strcmp(C(i),wwd{j,4}))
        wwd{j,5}=B(i)
        wwd{j,6}=K(i)
        wwd{j,7}=L(i)
    end;
end;
end;