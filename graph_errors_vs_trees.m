function graph_errors_vs_trees()

y20=[0.477165610271,0.38517796197,0.286851942142,0.416544774907,0.359661953519,0.301316431009,0.325532260686,0.318218755079,0.417032341947,0.297090849992];
y15=[0.233869657078,0.233382090037,0.231106777182,0.233382090037,0.233869657078,0.23224443361,0.233057045344,0.23224443361,0.232406955956,0.232406955956];
x=[10,20,30,40,50,60,70,80,90,100];
plot(x,y15,'-*r');
hold on;
plot(x,y20,'-*g');
hold on;
legend_labels={'K=15', 'K=20'};
legend(legend_labels,'FontSize',12,'FontWeight','bold');
ylabel('Cross Validation Error');
title('Cross Validation Error per Number of Topics');
xlabel('Number of Topics Used to Represent Each Bill');
grid on;

saveas(gcf, 'errorsvstrees.fig');

close all;


end
