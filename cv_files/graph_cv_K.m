function graph_cv_K()

y=[0.1807,0.1761,0.1713,0.1692,0.168401312705];
x=[5,8,10,15,20];
plot(x,y,'-*r');
ylabel('Cross Validation Error');
title('Cross Validation Error per Number of Topics');
xlabel('Number of Topics Used to Represent Each Bill');
grid on;

saveas(gcf, 'cv_K.fig');

close all;


end