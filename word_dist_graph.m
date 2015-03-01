figure
x = 1:1:50;
y = [ 0.070246 0.0048335 0.012424 0.022571 0.0034427 0.0023112 0.0016748 0.012718 0.0087464 0.013508 0.0067428 0.0020873 0.0033131 0.0062242 0.0059178 0.013814 4.8323e-05 0.005576 0.0015216 0.0073675 0.0018634 0.0032777 0.00092049 0.0064599 0.011269 0.011882 0.0010148 0.006401 0.0018162 0.0013566 0.007061 0.0016984 7.1895e-05 0.0079568 0.0023112 0.0060592 0.0018987 0.00087335 0.001168 0.0021698 0.00043726 0.001333 0.0012269 0.0098425 0.0015687 0.0028298 0.002382 0.0017219 0.003702 0.0021934 ];
h = bar(x,y, 'r');
title('Topic 0');
xlabels =  [ '              a  ';
'          state  ';
'            act  ';
'              b  ';
'         united  ';
'      secretary  ';
'             mr  ';
'     subsection  ';
'            sec  ';
'           year  ';
'              u  ';
'       congress  ';
'        service  ';
'        federal  ';
'          title  ';
'      paragraph  ';
'         health  ';
'           term  ';
'          house  ';
'        purpose  ';
'           bill  ';
'           fund  ';
'        program  ';
'        general  ';
'         amount  ';
'        amended  ';
'            law  ';
'           date  ';
'           plan  ';
'       national  ';
'     individual  ';
'      committee  ';
'           land  ';
'             ii  ';
'         office  ';
'           made  ';
'     government  ';
' representative  ';
'         senate  ';
'           area  ';
'         public  ';
'       provided  ';
'      including  ';
'      inserting  ';
'        provide  ';
'              h  ';
'         agency  ';
'             ha  ';
'      provision  ';
'    requirement  ';
];
ylabel('Probability(Word | Topic 0)')
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



figure
x = 1:1:50;
y = [ 0.04534 0.010889 0.014212 0.0080849 0.0049509 0.017982 2.3564e-06 0.0061291 0.0044089 0.0037255 0.0063647 0.0019582 0.00094493 0.0086505 0.0036077 0.0015105 2.3564e-06 0.0062233 2.3564e-06 0.0036784 0.00035582 0.0022881 0.00030869 0.002618 0.00028513 0.00047364 0.0035134 0.0039376 0.0037255 0.010253 0.0008978 0.0005679 0.020079 0.0022645 2.3564e-06 0.00019087 0.00070929 0.00033226 0.00012018 0.011761 0.0025473 0.00080354 0.0036548 2.3564e-06 0.0023588 0.001322 0.00012018 0.00077998 0.0016047 0.00054434 ];
h = bar(x,y, 'r');
title('Topic 1');
xlabels =  [ '              a  ';
'          state  ';
'            act  ';
'              b  ';
'         united  ';
'      secretary  ';
'             mr  ';
'     subsection  ';
'            sec  ';
'           year  ';
'              u  ';
'       congress  ';
'        service  ';
'        federal  ';
'          title  ';
'      paragraph  ';
'         health  ';
'           term  ';
'          house  ';
'        purpose  ';
'           bill  ';
'           fund  ';
'        program  ';
'        general  ';
'         amount  ';
'        amended  ';
'            law  ';
'           date  ';
'           plan  ';
'       national  ';
'     individual  ';
'      committee  ';
'           land  ';
'             ii  ';
'         office  ';
'           made  ';
'     government  ';
' representative  ';
'         senate  ';
'           area  ';
'         public  ';
'       provided  ';
'      including  ';
'      inserting  ';
'        provide  ';
'              h  ';
'         agency  ';
'             ha  ';
'      provision  ';
'    requirement  ';
];
ylabel('Probability(Word | Topic 1)')
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



figure
x = 1:1:50;
y = [ 0.072319 0.011005 0.0097733 0.012524 0.00054174 0.011714 0.0033939 0.0077313 0.0060605 0.0034108 0.0023982 0.0019763 0.013672 0.00072739 0.0057398 0.006263 0.02687 0.0049803 0.0007949 0.0034614 0.0015544 0.00040673 0.007765 0.0042209 0.0015037 0.0028032 0.0012337 0.0035627 0.016592 0.00052487 0.0094696 0.0023813 1.6877e-06 0.0044572 0.0024995 0.0023813 0.0011324 0.0017231 0.0011831 0.0024319 0.0042378 0.0028876 0.003107 0.0020269 0.0075794 0.00071051 0.001875 0.002972 0.0026176 0.0063305 ];
h = bar(x,y, 'r');
title('Topic 2');
xlabels =  [ '              a  ';
'          state  ';
'            act  ';
'              b  ';
'         united  ';
'      secretary  ';
'             mr  ';
'     subsection  ';
'            sec  ';
'           year  ';
'              u  ';
'       congress  ';
'        service  ';
'        federal  ';
'          title  ';
'      paragraph  ';
'         health  ';
'           term  ';
'          house  ';
'        purpose  ';
'           bill  ';
'           fund  ';
'        program  ';
'        general  ';
'         amount  ';
'        amended  ';
'            law  ';
'           date  ';
'           plan  ';
'       national  ';
'     individual  ';
'      committee  ';
'           land  ';
'             ii  ';
'         office  ';
'           made  ';
'     government  ';
' representative  ';
'         senate  ';
'           area  ';
'         public  ';
'       provided  ';
'      including  ';
'      inserting  ';
'        provide  ';
'              h  ';
'         agency  ';
'             ha  ';
'      provision  ';
'    requirement  ';
];
ylabel('Probability(Word | Topic 2)')
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



figure
x = 1:1:50;
y = [ 0.072761 0.018786 0.018527 0.012471 0.0070318 0.0044539 0.0024064 0.0084502 0.0071058 0.0003836 0.0046759 0.0011977 0.0024064 0.0088942 0.0083515 0.0044786 1.2334e-06 0.0078828 1.3568e-05 0.0047993 0.00059328 2.5902e-05 0.001173 0.0046019 0.00075362 0.0022337 0.0076855 0.0039975 1.2334e-06 0.0010496 0.0018637 3.8236e-05 1.2334e-06 0.0038619 0.001136 0.001802 0.0026408 0.0021104 0.00069195 1.2334e-06 0.0022584 0.0030355 0.0031095 0.0012717 0.0020117 0.0020857 0.0047869 0.0057367 0.0035658 0.0030848 ];
h = bar(x,y, 'r');
title('Topic 3');
xlabels =  [ '              a  ';
'          state  ';
'            act  ';
'              b  ';
'         united  ';
'      secretary  ';
'             mr  ';
'     subsection  ';
'            sec  ';
'           year  ';
'              u  ';
'       congress  ';
'        service  ';
'        federal  ';
'          title  ';
'      paragraph  ';
'         health  ';
'           term  ';
'          house  ';
'        purpose  ';
'           bill  ';
'           fund  ';
'        program  ';
'        general  ';
'         amount  ';
'        amended  ';
'            law  ';
'           date  ';
'           plan  ';
'       national  ';
'     individual  ';
'      committee  ';
'           land  ';
'             ii  ';
'         office  ';
'           made  ';
'     government  ';
' representative  ';
'         senate  ';
'           area  ';
'         public  ';
'       provided  ';
'      including  ';
'      inserting  ';
'        provide  ';
'              h  ';
'         agency  ';
'             ha  ';
'      provision  ';
'    requirement  ';
];
ylabel('Probability(Word | Topic 3)')
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



figure
x = 1:1:50;
y = [ 0.030083 0.02941 0.0069069 0.0023035 0.029251 1.7705e-06 0.037006 0.00044441 0.0010641 0.002091 0.0072433 0.020876 0.0017546 0.00037358 0.0017546 1.7705e-06 1.7705e-06 1.7705e-06 0.019141 0.001914 0.016645 1.7705e-06 1.7705e-06 0.0023212 1.7705e-06 0.0017723 0.0013474 0.0027992 1.7705e-06 0.0034897 0.0012411 0.011882 1.7705e-06 0.0012943 0.0091732 0.0017723 0.010696 0.012785 0.013121 1.7705e-06 0.00051523 0.0012234 0.0016661 0.0014536 0.0016484 0.0087128 1.7705e-06 0.003596 0.00017882 1.7705e-06 ];
h = bar(x,y, 'r');
title('Topic 4');
xlabels =  [ '              a  ';
'          state  ';
'            act  ';
'              b  ';
'         united  ';
'      secretary  ';
'             mr  ';
'     subsection  ';
'            sec  ';
'           year  ';
'              u  ';
'       congress  ';
'        service  ';
'        federal  ';
'          title  ';
'      paragraph  ';
'         health  ';
'           term  ';
'          house  ';
'        purpose  ';
'           bill  ';
'           fund  ';
'        program  ';
'        general  ';
'         amount  ';
'        amended  ';
'            law  ';
'           date  ';
'           plan  ';
'       national  ';
'     individual  ';
'      committee  ';
'           land  ';
'             ii  ';
'         office  ';
'           made  ';
'     government  ';
' representative  ';
'         senate  ';
'           area  ';
'         public  ';
'       provided  ';
'      including  ';
'      inserting  ';
'        provide  ';
'              h  ';
'         agency  ';
'             ha  ';
'      provision  ';
'    requirement  ';
];
ylabel('Probability(Word | Topic 4)')
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



figure
x = 1:1:50;
y = [ 0.035436 0.012514 0.018367 0.0099348 0.0060333 0.0099091 1.2834e-06 0.0043135 0.0090493 0.012938 0.007907 0.0065723 0.0099861 0.0058536 0.0044162 0.0028633 0.0015799 0.0023242 0.0030429 0.0026579 0.0026194 0.017456 0.012976 0.0027991 0.0090364 0.003659 0.0078172 0.0015285 1.2834e-06 0.0047627 0.00055315 0.0040183 0.00018096 2.6951e-05 0.0041852 0.0070215 0.0021061 0.0012718 0.0025167 0.0024269 0.0076375 0.0083434 0.0046472 0.0022729 0.0016184 0.00063015 0.0070215 0.001182 0.0036975 0.003197 ];
h = bar(x,y, 'r');
title('Topic 5');
xlabels =  [ '              a  ';
'          state  ';
'            act  ';
'              b  ';
'         united  ';
'      secretary  ';
'             mr  ';
'     subsection  ';
'            sec  ';
'           year  ';
'              u  ';
'       congress  ';
'        service  ';
'        federal  ';
'          title  ';
'      paragraph  ';
'         health  ';
'           term  ';
'          house  ';
'        purpose  ';
'           bill  ';
'           fund  ';
'        program  ';
'        general  ';
'         amount  ';
'        amended  ';
'            law  ';
'           date  ';
'           plan  ';
'       national  ';
'     individual  ';
'      committee  ';
'           land  ';
'             ii  ';
'         office  ';
'           made  ';
'     government  ';
' representative  ';
'         senate  ';
'           area  ';
'         public  ';
'       provided  ';
'      including  ';
'      inserting  ';
'        provide  ';
'              h  ';
'         agency  ';
'             ha  ';
'      provision  ';
'    requirement  ';
];
ylabel('Probability(Word | Topic 5)')
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



