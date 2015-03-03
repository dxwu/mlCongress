figure
x = 1:1:50;
y = [ 0.033694 0.0046433 0.011117 0.020412 0.0016872 0.0019995 0.0046433 0.0015936 0.012242 0.0043206 0.011097 0.0079116 0.0039147 0.00096904 0.0069332 0.005934 0.001604 0.012471 0.0064024 0.0067875 0.0010211 0.0017705 0.00078169 0.00080251 0.0014478 0.0061838 0.014417 0.0093792 0.0090253 0.0017393 0.00077128 0.0053511 0.0021556 0.0076514 0.0014478 1.0409e-06 0.0019891 0.010389 0.0051741 0.0024367 0.011055 0.0019683 0.0020099 0.0019891 0.0011252 0.0017185 0.0071206 0.0020828 0.0034463 0.000917 ];
h = bar(x,y, 'r');
title('Topic 0');
xlabels =  [ '        section  ';
'          state  ';
'            act  ';
'              b  ';
'             mr  ';
'         united  ';
'      secretary  ';
'       congress  ';
'     subsection  ';
'              u  ';
'           year  ';
'            sec  ';
'        federal  ';
'          house  ';
'        service  ';
'          title  ';
'           bill  ';
'      paragraph  ';
'           term  ';
'        purpose  ';
' representative  ';
'     government  ';
'         senate  ';
'       national  ';
'            law  ';
'        general  ';
'         health  ';
'         amount  ';
'        amended  ';
'         office  ';
'      committee  ';
'           date  ';
'           fund  ';
'             ii  ';
'        program  ';
'           land  ';
'              h  ';
'     individual  ';
'           made  ';
'           area  ';
'           plan  ';
'      including  ';
'             ha  ';
'             wa  ';
'     introduced  ';
'         person  ';
'      inserting  ';
'       provided  ';
'        provide  ';
'         public  ';
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
y = [ 0.016678 0.016368 0.019438 0.012155 1.0653e-05 0.0042622 0.011409 0.0055502 0.0060635 0.0082232 0.012339 0.0094822 0.005221 0.0020541 0.0084072 0.0055696 0.0021413 0.0037102 0.0034971 0.0031 0.0010953 0.0022187 0.0020057 0.0039813 0.0069642 0.0035358 0.0019088 0.0083297 0.0042138 0.0025383 0.0026739 0.00218 0.014596 0.001105 0.014073 0.00075637 0.00077573 0.00091132 0.005957 0.0031097 0.0011534 0.0040491 0.0023446 0.00078542 0.00064983 0.00057236 0.0024899 0.0070804 0.0023931 0.0076518 ];
h = bar(x,y, 'r');
title('Topic 1');
xlabels =  [ '        section  ';
'          state  ';
'            act  ';
'              b  ';
'             mr  ';
'         united  ';
'      secretary  ';
'       congress  ';
'     subsection  ';
'              u  ';
'           year  ';
'            sec  ';
'        federal  ';
'          house  ';
'        service  ';
'          title  ';
'           bill  ';
'      paragraph  ';
'           term  ';
'        purpose  ';
' representative  ';
'     government  ';
'         senate  ';
'       national  ';
'            law  ';
'        general  ';
'         health  ';
'         amount  ';
'        amended  ';
'         office  ';
'      committee  ';
'           date  ';
'           fund  ';
'             ii  ';
'        program  ';
'           land  ';
'              h  ';
'     individual  ';
'           made  ';
'           area  ';
'           plan  ';
'      including  ';
'             ha  ';
'             wa  ';
'     introduced  ';
'         person  ';
'      inserting  ';
'       provided  ';
'        provide  ';
'         public  ';
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
y = [ 0.000115 0.026475 0.0028885 2.4804e-05 0.049768 0.024874 0.00070127 0.021785 2.2549e-06 0.0062709 0.0027307 0.00072382 2.2549e-06 0.019597 0.001964 0.00022774 0.015877 2.2549e-06 2.2549e-06 0.0010846 0.013216 0.012224 0.013441 0.0041062 0.00094931 2.2549e-06 2.2549e-06 2.2549e-06 2.2549e-06 0.0091797 0.008165 2.4804e-05 2.2549e-06 0.00040814 0.00061108 6.9902e-05 0.0094728 0.0011297 0.00052088 0.00038559 0.00013755 0.0011523 0.0036552 0.0074209 0.0096532 2.2549e-06 2.2549e-06 2.2549e-06 0.0018964 0.00036304 ];
h = bar(x,y, 'r');
title('Topic 2');
xlabels =  [ '        section  ';
'          state  ';
'            act  ';
'              b  ';
'             mr  ';
'         united  ';
'      secretary  ';
'       congress  ';
'     subsection  ';
'              u  ';
'           year  ';
'            sec  ';
'        federal  ';
'          house  ';
'        service  ';
'          title  ';
'           bill  ';
'      paragraph  ';
'           term  ';
'        purpose  ';
' representative  ';
'     government  ';
'         senate  ';
'       national  ';
'            law  ';
'        general  ';
'         health  ';
'         amount  ';
'        amended  ';
'         office  ';
'      committee  ';
'           date  ';
'           fund  ';
'             ii  ';
'        program  ';
'           land  ';
'              h  ';
'     individual  ';
'           made  ';
'           area  ';
'           plan  ';
'      including  ';
'             ha  ';
'             wa  ';
'     introduced  ';
'         person  ';
'      inserting  ';
'       provided  ';
'        provide  ';
'         public  ';
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
y = [ 0.0075587 0.0095698 0.011845 0.0099963 0.00073332 0.0047757 0.017655 0.0012615 0.0059336 0.0044304 0.0025412 0.0038616 0.0080869 2.0314e-06 0.0012005 0.0043492 0.00050987 0.0023178 0.0076196 0.0035163 2.0314e-06 2.0314e-06 2.0314e-06 0.0083713 0.0036585 0.003435 0.0015459 0.00020517 0.00030674 2.0314e-06 0.00050987 0.0041663 8.3286e-05 0.0038413 0.00077395 0.01607 0.0011193 0.0012208 0.00089583 0.009001 0.0021959 0.0036585 0.0008552 0.0013834 0.0004083 0.0043898 2.0314e-06 0.0012615 0.0027241 0.0022975 ];
h = bar(x,y, 'r');
title('Topic 3');
xlabels =  [ '        section  ';
'          state  ';
'            act  ';
'              b  ';
'             mr  ';
'         united  ';
'      secretary  ';
'       congress  ';
'     subsection  ';
'              u  ';
'           year  ';
'            sec  ';
'        federal  ';
'          house  ';
'        service  ';
'          title  ';
'           bill  ';
'      paragraph  ';
'           term  ';
'        purpose  ';
' representative  ';
'     government  ';
'         senate  ';
'       national  ';
'            law  ';
'        general  ';
'         health  ';
'         amount  ';
'        amended  ';
'         office  ';
'      committee  ';
'           date  ';
'           fund  ';
'             ii  ';
'        program  ';
'           land  ';
'              h  ';
'     individual  ';
'           made  ';
'           area  ';
'           plan  ';
'      including  ';
'             ha  ';
'             wa  ';
'     introduced  ';
'         person  ';
'      inserting  ';
'       provided  ';
'        provide  ';
'         public  ';
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
y = [ 0.0208 0.020498 0.019108 0.012998 0.0023935 0.013537 0.0028246 0.0044303 0.0080728 0.0067688 0.00083088 0.0071999 0.0088703 0.0034604 0.0056373 0.0080405 0.0038052 0.0053679 0.0054002 0.0053571 0.0041501 0.0032233 0.0031155 0.0016391 0.0057774 0.0054217 0.00065845 0.00055069 0.0047751 0.0047859 0.0060252 0.0062192 0.00046447 0.0039561 1.0777e-06 1.0777e-06 0.0032556 0.002803 0.0029862 1.1854e-05 1.0777e-06 0.0033742 0.0051308 0.0023181 0.001984 0.0070382 0.0040531 0.0031263 0.0028892 0.0021133 ];
h = bar(x,y, 'r');
title('Topic 4');
xlabels =  [ '        section  ';
'          state  ';
'            act  ';
'              b  ';
'             mr  ';
'         united  ';
'      secretary  ';
'       congress  ';
'     subsection  ';
'              u  ';
'           year  ';
'            sec  ';
'        federal  ';
'          house  ';
'        service  ';
'          title  ';
'           bill  ';
'      paragraph  ';
'           term  ';
'        purpose  ';
' representative  ';
'     government  ';
'         senate  ';
'       national  ';
'            law  ';
'        general  ';
'         health  ';
'         amount  ';
'        amended  ';
'         office  ';
'      committee  ';
'           date  ';
'           fund  ';
'             ii  ';
'        program  ';
'           land  ';
'              h  ';
'     individual  ';
'           made  ';
'           area  ';
'           plan  ';
'      including  ';
'             ha  ';
'             wa  ';
'     introduced  ';
'         person  ';
'      inserting  ';
'       provided  ';
'        provide  ';
'         public  ';
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



