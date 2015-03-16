function plot_RF_and_benchmarks()

ymin = 1000;
ymax = -1000;

m = dlmread('benchmarks.txt',',');
x=[5,8,10,15,20];
colors = ['-*r';'-*g';'-*b';'-*c';'-*m';'-*y';'-*k';'-*w'];
colors_err = ['rx';'gx';'bx';'cx';'mx';'yx';'kx';'wx'];

err_bars = {};
legend_labels = {'Sci-Kit Learn: Random Forest', 'Sci-Kit Learn: Logistic Regression', 'Random Forest with Optimal Hyperparameters'};
col_ind = 1;
for i = 1:2:size(m,1)
    plot(x,m(i,:),colors(col_ind,:));
    ymin = min(min(m(i,:)),ymin);
    ymax = max(max(m(i,:)),ymax);
    hold on;
    err_bars{length(err_bars)+1} = {x,m(i,:),m(i+1,:),colors_err(col_ind,:)};
    col_ind = mod(col_ind+1,size(colors,1));
end

legend(legend_labels,'FontSize',12,'FontWeight','bold');

for i = 1:length(err_bars)
    errorbar(err_bars{i}{1},err_bars{i}{2},err_bars{i}{3},err_bars{i}{4});
end

ylabel('Misclassification Error');
title('Misclassification Error vs. Number of Topics for 3 Classifiers');
xlabel('Number of Topics');
axis([4 22 ymin-0.02 ymax+0.06]);
grid on;

saveas(gcf, './benchmark.fig');

end