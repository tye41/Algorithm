function [err_train, err_test]= KNN15(train, test)
d = size(train,2);

xtrain = double(train(:, 1: d-1));
ytrain = double(train(:, d));

xtest = double(test(:, 1: d-1));
ytest = double(test(:, d));

test_dist=pdist2(xtest,xtrain);
tran_dist=squareform(pdist(xtrain));

[~,label_test]=mink(test_dist,15,2);
[~,label_train]=mink(tran_dist,16,2);

ytest_label=mode(ytrain(label_test),2);
ytrain_label=mode(ytrain(label_train(:,2:16)),2);

err_train = sum(abs(ytrain_label - ytrain))/length(ytrain);
err_test= sum(abs(ytest_label - ytest))/length(ytest);


end