data=readtable('n90pol.csv');
datano=size(data,1);
pdata= table2array(data);
pdata=(pdata(:,1:2));
min_data = min(pdata,[],1); 
max_data = max(pdata,[],1); 
nbin = 20;
sbin = (max_data - min_data) ./ nbin; 
boundary = [min_data(1):sbin(1):max_data(1); min_data(2):sbin(2):max_data(2)];
myhist1 = zeros(nbin, nbin);
for i = 1:datano
    which_bin1 = max(find(pdata(i,1) > boundary(1,:)));
    which_bin2 = max(find(pdata(i,2) > boundary(2,:)));
    myhist1(which_bin1, which_bin2) = myhist1(which_bin1, which_bin2) + 1; 
end
myhist1 = myhist1 * nbin ./ datano; 
figure; 
bar3(myhist1);

gridno = 30; 
inc1 = (max_data(1) - min_data(1)) / gridno; 
inc2 = (max_data(2) - min_data(2)) / gridno; 
[gridx,gridy] = meshgrid(min_data(1):inc1:max_data(1), min_data(2):inc2:max_data(2)); 

gridall = [gridx(:), gridy(:)];     
gridallno = size(gridall, 1); 
bandwidth=0.01;
norm_pdata = sum(pdata.^2, 2); 
norm_gridall = sum(gridall.^2, 2); 
cross = pdata * gridall'; 

dist1 = (repmat(norm_pdata, 1, gridallno) + repmat(norm_gridall', datano, 1) - 2 * cross);
kernelvalue= (1/sqrt(2*pi))*exp(-0.5*(dist1./bandwidth.^2));
mkde = sum(kernelvalue, 1)./datano;
mkde = reshape(mkde, gridno+1, gridno+1); 

figure; 
surf(gridx, gridy, mkde); 




