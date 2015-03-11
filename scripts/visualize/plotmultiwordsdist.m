figure
x = 1:1:50;
y = [ 0.0051941 0.0053649 0.0011516 0.0055934 0.0079869 0.0013295 0.0041582 0.0014523 0.001373 0.0027113 0.00549 0.012114 1.7088e-05 0.0038405 0.0038552 0.0012925 1.5914e-05 0.0053297 0.00789 0.0024089 0.0052475 0.0054248 0.0037013 0.0015862 0.0019919 5.8722e-08 0.0017882 0.00061841 0.00090732 0.0011545 0.0017682 0.0059768 3.3531e-05 5.8722e-08 0.0038305 0.0030108 0.0031388 0.0010248 0.0028927 0.0011305 0.0023607 0.0009314 0.0029796 0.00064659 0.00055675 0.0011181 0.00021087 0.001491 0.00070766 0.0016701 ];
h = bar(x,y, 'r');
title('Topic 0');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
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
y = [ 0.00068159 0.012286 0.0078409 0.0045026 0.016835 0.0052217 0.0041066 0.0057114 0.0084637 0.0088044 0.0060066 0.0031667 0.00073765 0.0045753 0.0019167 0.0073065 0.0070639 0.0021164 0.0004626 0.00047048 0.0028934 0.0051315 0.010093 0.00053968 0.00044858 8.7597e-08 0.0025378 0.00017791 0.0052874 0.0017021 0.0043484 0.0033787 7.9713e-06 0.024843 0.0044281 0.0039673 0.0023398 0.0038202 0.0044631 5.0018e-05 0.010281 0.0038675 0.0056185 0.0024764 0.0014656 0.001929 0.00062728 0.0012939 0.0006448 0.0070157 ];
h = bar(x,y, 'r');
title('Topic 1');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
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
y = [ 0.024998 0.0043453 0.011172 0.015607 0.0011036 0.0064431 0.001097 0.0033105 0.0048545 0.0010545 0.0012301 0.0020358 0.00019092 0.0044881 0.0030434 0.0053092 0.00029124 0.0012617 0.0084451 0.0064726 5.0266e-05 0.00097818 7.3164e-05 0.0014863 0.0091756 1.0904e-07 0.0014732 0.0086795 1.2103e-05 0.011241 0.0014285 0.0025232 6.6513e-06 1.4284e-05 0.00059873 0.0018134 0.0010491 1.0904e-07 0.0015735 0.0083938 1.0904e-07 0.002593 0.0016738 0.0039287 0.00093347 0.0083295 0.010444 0.0011494 0.0013751 0.00016912 ];
h = bar(x,y, 'r');
title('Topic 2');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
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
y = [ 0.032699 0.0022844 4.3623e-05 0.00042024 0.00044105 0.00019786 0.0022011 9.4626e-08 1.8074e-05 0.00079779 0.0016021 0.00058205 3.416e-05 0.0025862 0.0017762 9.4626e-08 0.0013305 9.4626e-08 0.0035079 0.014889 9.0936e-05 0.0033783 0.00051202 0.00056028 0.008559 9.4626e-08 0.0011697 0.00011554 2.9334e-06 0.0076062 0.0070422 0.0018434 0.0044059 0.000847 8.999e-05 0.00061611 0.0038533 0.00077982 0.00034075 0.0044901 6.7185e-06 0.00065112 0.0017147 0.00036346 0.0014233 0.0048979 0.0035864 0.0012709 0.0022248 0.0022749 ];
h = bar(x,y, 'r');
title('Topic 3');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
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
y = [ 0.011313 0.0023368 0.0056979 0.013129 8.9556e-06 0.0071557 0.0092949 0.0015367 0.0068176 0.0056113 0.0076461 0.0095162 5.9309e-08 0.0038012 0.0084272 0.0055448 0.0040906 0.002271 0.00078056 0.0017574 0.00026398 0.0027656 0.0042661 0.0033575 0.00089977 0.028309 0.0028208 0.0063734 0.0036309 0.0010142 0.0052169 0.0017414 0.0053284 5.9309e-08 5.9961e-05 0.0035319 0.0036487 0.007056 0.0039376 0.0022579 4.5134e-05 0.0032152 0.0023866 0.0046101 0.0037442 0.0016506 0.0030598 0.0051807 0.011097 2.319e-05 ];
h = bar(x,y, 'r');
title('Topic 4');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
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
y = [ 0.0038927 0.013777 0.014316 0.0066325 0.019318 0.0045322 0.0061198 0.0074117 0.0028528 0.0012658 0.0023185 0.006727 0.0066043 0.0039671 0.00046148 0.0023672 0.0022882 0.019415 0.011518 0.0043264 0.0016661 0.0075158 0.010288 0.013556 0.0049895 5.1327e-08 0.0063589 0.0011878 0.00057645 0.00092137 0.00070118 0.008102 0.0082606 0.00031469 0.014311 0.0026013 0.0065956 0.0053499 0.0018986 0.0053622 0.01054 0.0010753 0.0033799 0.00079664 0.00097064 0.00038141 0.0019459 0.0039548 4.7785e-05 0.0081841 ];
h = bar(x,y, 'r');
title('Topic 5');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
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



figure
x = 1:1:50;
y = [ 0.003614 0.022245 0.0028925 0.002586 3.3981e-05 0.017501 0.0089918 0.016356 0.012052 0.011205 0.0074149 0.00021345 2.3497e-05 0.009994 0.011159 0.010365 0.0060655 0.0018348 3.762e-06 0.0011003 0.0048882 0.00092021 0.0002005 0.0036985 0.00088197 6.1672e-08 0.0079767 0.0091405 0.009434 0.0014654 0.0023627 0.00013019 0.0019489 6.1672e-08 0.00027389 0.0054093 0.00032384 0.00034974 0.003524 0.00081845 1.6096e-05 0.0071041 0.00083942 0.0063547 0.0078429 0.0024016 0.00098126 0.0026353 0.0039785 0.0002227 ];
h = bar(x,y, 'r');
title('Topic 6');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
];
ylabel('Probability(Word | Topic 6)')
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
y = [ 0.0015279 0.0069717 0.017244 0.0078422 0.0072343 0.0052171 0.0067693 0.0056869 0.0041997 0.0076899 0.0057234 0.0028648 0.029548 0.0038145 0.0055908 0.0029738 0.012529 0.0010825 0.00056597 0.00039471 0.016015 0.0036392 0.00014358 0.0036873 0.001385 6.7692e-08 0.004042 0.0010188 0.0067361 0.0013566 0.0034307 0.0025934 0.0061533 1.4215e-06 0.0020383 0.0042545 0.0033292 0.0058724 0.0052672 0.0010946 0.00023767 0.0039587 0.0046762 0.0039634 0.00607 0.0016132 0.0012016 0.0045808 0.00094776 0.0013803 ];
h = bar(x,y, 'r');
title('Topic 7');
xlabels =  [ '         united  ';
'           year  ';
'        service  ';
'          title  ';
'        program  ';
'        amended  ';
'        general  ';
'         amount  ';
'      inserting  ';
'             ii  ';
'           term  ';
'        federal  ';
'         health  ';
'        purpose  ';
'           date  ';
'       striking  ';
'     individual  ';
'           fund  ';
'       national  ';
'     government  ';
'           plan  ';
'      including  ';
'         agency  ';
'       provided  ';
'      committee  ';
'        deleted  ';
'           made  ';
'           code  ';
'   subparagraph  ';
' representative  ';
'             ha  ';
'         public  ';
'       security  ';
'          child  ';
'         fiscal  ';
'              e  ';
'         report  ';
'    information  ';
'    requirement  ';
'         office  ';
'          grant  ';
'            end  ';
'        provide  ';
'         period  ';
'        respect  ';
'              h  ';
'         member  ';
'      provision  ';
'         person  ';
'     assistance  ';
];
ylabel('Probability(Word | Topic 7)')
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



