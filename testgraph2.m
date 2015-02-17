x = 1:1:50;
y = [ 0.0208 0.020498 0.019108 0.012998 0.0023935 0.013537 0.0028246 0.0044303 0.0080728 0.0067688 0.00083088 0.0071999 0.0088703 0.0034604 0.0056373 0.0080405 0.0038052 0.0053679 0.0054002 0.0053571 0.0041501 0.0032233 0.0031155 0.0016391 0.0057774 0.0054217 0.00065845 0.00055069 0.0047751 0.0047859 0.0060252 0.0062192 0.00046447 0.0039561 1.0777e-06 1.0777e-06 0.0032556 0.002803 0.0029862 1.1854e-05 1.0777e-06 0.0033742 0.0051308 0.0023181 0.001984 0.0070382 0.0040531 0.0031263 0.0028892 0.0021133 ];
h = bar(x,y,'r');
title('Topic 0');
ylabel('Probability(Word | Topic 0)')
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