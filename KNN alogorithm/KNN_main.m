clear all;


%Repeat the experiments for 100 times
N = 100;

err_KNN5 = zeros(N,2);
err_KNN10 = zeros(N,2);
err_KNN15 = zeros(N,2);
err_KNN30 = zeros(N,2);
%Let p change from 0.1, 0.2, 0.5, 0.8, 0.9 to compare the performance of each classifier
p = 0.9;

for i = 1 : N
	
	[train, test] = SplitData(p);
	
	[err_train, err_test] = KNN5(train, test);
	err_KNN5(i,:) = [err_train, err_test];
	
	[err_train, err_test] = KNN10(train, test);
    err_KNN10(i,:) = [err_train, err_test];
	
	[err_train, err_test] = KNN15(train, test);
	err_KNN15(i,:) = [err_train, err_test];
	
	[err_train, err_test] = KNN30(train, test);
	err_KNN30(i,:) = [err_train, err_test];
end

mean_KNN5 = mean(err_KNN5);
mean_KNN10 = mean(err_KNN10);
mean_KNN15 = mean(err_KNN15);
mean_KNN30 = mean(err_KNN30);


fprintf('err_KNN5 : %g, %g\n', mean_KNN5(1), mean_KNN5(2));
fprintf('err_KNN10 : %g, %g\n', mean_KNN10(1), mean_KNN10(2));
fprintf('err_KNN15: %g, %g\n', mean_KNN15(1), mean_KNN15(2));
fprintf('err_KNN30 : %g, %g\n', mean_KNN30(1), mean_KNN30(2));