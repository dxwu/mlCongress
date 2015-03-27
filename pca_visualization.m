%graphs the data points in 3-D space, each point colored with the corresponding class

function [ ] = pca_visualization()

k_vals = [5,8,10,15,20];
for k_ind = 1:5
    k = k_vals(k_ind);
    features = dlmread(strcat('./k',int2str(k),'_pca_passed.txt'),',');
    scatter3(features(:,1),features(:,2),features(:,3),ones(length(features(:,1)),1)*55,'r');
    hold on;
    features = dlmread(strcat('./k',int2str(k),'_pca_failed.txt'),',');
    scatter3(features(:,1),features(:,2),features(:,3),ones(length(features(:,1)),1)*55,'b');
    legend_labels = {'Passed', 'Failed'};
    legend(legend_labels,'FontSize',12,'FontWeight','bold');
    title(strcat('Visualization of Passed and Failed Bills for K=',int2str(k)));
    saveas(gcf, strcat('pca_k',int2str(k),'.fig'));
    close all;
end