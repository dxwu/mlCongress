function graph_perp(nIter, perp)

% set of \tau parameters 
iter = 1:nIter; 

% close curent opening figures
close all;

% plotting test errors versus different tau parameters
plot(iter, perp, '-*r');
ylabel('Perplexity');
title('Perplexity per iteration of LDA');
xlabel('Iteration Number');
grid on;

saveas(gcf, 'perplexity.fig');

end