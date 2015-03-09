function graph_cv()

cv = dlmread('./c_v_split.txt', ',');

x = cv(:,2);
y = cv(:,1);
% set of \tau parameters 

% close curent opening figures
%close all;

% plotting test errors versus different tau parameters
plot(x, y, '-*r');
ylabel('Cross Validation Error');
title('Cross Validation Error for Each Split Size');
xlabel('Number of features considered at each split');
axis([min(x)-1 max(x)+1 min(y)-0.01 max(y)+0.01]);
grid on;

saveas(gcf, 'cv_split.fig');

%close all;

cv = dlmread('./c_v_depth.txt', ',');

x = cv(:,2);
y = cv(:,1);
% set of \tau parameters 

% close curent opening figures
%close all;

% plotting test errors versus different tau parameters
plot(x, y, '-*r');
ylabel('Cross Validation Error');
title('Cross Validation Error for Each Depth');
xlabel('Depth of Tree');
axis([min(x)-1 max(x)+1 min(y)-0.01 max(y)+0.01]);
grid on;

saveas(gcf, 'cv_depth.fig');

cv = dlmread('./c_v_K.txt', ',');

x = cv(:,2);
y = cv(:,1);

%close all;

% plotting test errors versus different tau parameters
plot(x, y, '-*r');
ylabel('Cross Validation Error');
title('Cross Validation Error per Number of Topics');
xlabel('Number of Topics');
axis([min(x)-1 max(x)+1 min(y)-0.01 max(y)+0.01]);
grid on;

saveas(gcf, 'cv_K.fig');



end