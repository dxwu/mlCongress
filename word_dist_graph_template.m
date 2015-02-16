pos = get(gca,'Position');
set(gca,'Position',[pos(1), .2, pos(3) .65])
Xt = 1:1:50;
Xl = [0 51];
set(gca,'XTick',Xt,'XLim',Xl);
ax = axis; 
axis(axis); 
Yl = ax(3:4); 

t = text(Xt,Yl(1)*ones(1,length(Xt)),xlabels(1:1:50,:));
set(t,'HorizontalAlignment','right','VerticalAlignment','top', ...
      'Rotation',45);

set(gca,'XTickLabel','')

for i = 1:length(t)
  ext(i,:) = get(t(i),'Extent');
end

LowYPoint = min(ext(:,2));

XMidPoint = Xl(1)+abs(diff(Xl))/2;
tl = text(XMidPoint,LowYPoint,'Top 50 Words Overall', ...
          'VerticalAlignment','top', ...
          'HorizontalAlignment','center');
