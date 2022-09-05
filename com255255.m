function [str]=com255255(pop, a1, a2, a3, a4, tbk, tbl, tbg, mnk1, mnk2, mnl1, mnl2, mng1, mng2, ch1, ch2, ch3, ch4, en1, en2, en3, n)
% ������� 255 ���������� �������� ������

%% ��� if ����� ����� �������� ���������� ���� ��� ������
if isempty(n)
 n=1;
end

if isempty(mnk1)
 mnk1=0;
 mnk2=0;
end

if isempty(mnl1)
 mnl1=0;
 mnl2=0;
end

if isempty(mng1)
 mng1=0;
 mng2=0;
end

if isempty(ch1)
 ch1=-1;
end

if isempty(ch2)
 ch2=-1;
end

if isempty(ch3)
 ch3=-1;
end

if isempty(en1)
 en1=-1;
end

if isempty(en2)
 en2=-1;
end

if isempty(en3)
 en3=-1;
end

% �������� ����� � ������ � ���� �����
r=fix(clock); % ����� � ���� ��� �������� �����
clk='%d-%d-%d %d-%d-%d';
 
if en1==1
% �������� ����� � ������ � ���� �����
tm=sprintf(clk,  r(1), r(2), r(3), r(4), r(5), r(6));
namefilek=['camera 1 ',num2str(tm),'.txt'];
fidk=fopen(namefilek,'w'); 
namefilek=['summa camera 1 ',num2str(tm),'.txt'];
fidkk=fopen(namefilek,'w'); 
end
if en2==1
% �������� ����� � ������ � ���� �����
tm=sprintf(clk,  r(1), r(2), r(3), r(4), r(5), r(6));
namefileb=['camera 2 ',num2str(tm),'.txt'];
fidl=fopen(namefileb,'w');
namefileb=['summa camera 2 ',num2str(tm),'.txt'];
fidll=fopen(namefileb,'w');
end
if en3==1
% �������� ����� � ������ � ���� �����
tm=sprintf(clk,  r(1), r(2), r(3), r(4), r(5), r(6));
namefileb=['camera 3 ',num2str(tm),'.txt'];
fidg=fopen(namefileb,'w');
namefileb=['summa camera 3 ',num2str(tm),'.txt'];
fidgg=fopen(namefileb,'w');
end

pp=300; % ���������� ����� �� �������
l1=0:pp-1;

massif_k1 = zeros(pp,1); 
massif_k2 = zeros(pp,1);
massif_k3 = zeros(pp,1);
massif_k4 = zeros(pp,1);

massif_l1 = zeros(pp,1); 
massif_l2 = zeros(pp,1);
massif_l3 = zeros(pp,1);
massif_l4 = zeros(pp,1);

massif_g1 = zeros(pp,1); 
massif_g2 = zeros(pp,1);
massif_g3 = zeros(pp,1);
massif_g4 = zeros(pp,1);

new_massif_k1 = zeros(pp,1);
new_massif_k2 = zeros(pp,1);

new_massif_l1 = zeros(pp,1);
new_massif_l2 = zeros(pp,1);

new_massif_g1 = zeros(pp,1);
new_massif_g2 = zeros(pp,1);

flmk=0;
summa_massif_k1=[];
summa_massif_k2=[];

flml=0;
summa_massif_l1=[];
summa_massif_l2=[];

flmg=0;
summa_massif_g1=[];
summa_massif_g2=[];

tic; % ������, ����� ��� ����������� ������� ������ ���������

i=0;
while i<pop
pause(0.05); 

%% ������� ������� ����������, ����� �� ���������� ������� ��� ��� 
% ��� 1 ������� 
if ch1==1
fwrite(tbk,255); % �������� �������
btsk=get(tbk, 'BytesAvailable'); % ����������� ���������� ������ 
else
btsk=0;
end
% ��� 2 �������
if ch2==1
fwrite(tbl,255); % �������� �������
btsl=get(tbl, 'BytesAvailable'); % ����������� ���������� ������ 
else
btsl=0;
end
% ��� 3 �������
if ch3==1
fwrite(tbg,255); % �������� �������
btsg=get(tbg, 'BytesAvailable'); % ����������� ���������� ������ 
else
btsg=0;  
end

%% ��������� ������ ��� 1 ��������

if ((btsk~=0)&&(ch1==1)) % ������� ����� ����� ��������� �� ��������, ���� ������ 0 ����
ck=uint32(fread(tbk, btsk/4, 'uint32')); % ������ ������

% ���� ��� ��������� ������
for iz=1:btsk/4
% ������� ������������� 
facpk(iz)=bitand(bitshift(ck(iz),-24),hex2dec('f'));
nacpk(iz)=bitshift(ck(iz),-30);
end

yk=0; 
mk1=0;
mk2=0;
mk3=0;
mk4=0;
dat.acpk1 = [ ];
dat.acpk2 = [ ];
dat.acpk3 = [ ];
dat.acpk4 = [ ];  

% ���������� �� ���
 while yk<btsk/4
 yk=yk+1;    
   switch nacpk(yk)
       case 0 % ���1
        mk1=mk1+1;
        dat.acpk1(mk1)=bitand(ck(yk),hex2dec('ffffff')); 
       case 1 % ���2 
        mk2=mk2+1;
        dat.acpk2(mk2)=bitand(ck(yk),hex2dec('ffffff'));
       case 2 %���3
        mk3=mk3+1;
        dat.acpk3(mk3)=bitand(ck(yk),hex2dec('ffffff'));
       case 3 %���;
        mk4=mk4+1;
        dat.acpk4(mk4)=bitand(ck(yk),hex2dec('ffffff'));    
   end    
 end
 
% �������� ��������
massif_k1 = circshift(massif_k1,mk1);
massif_k2 = circshift(massif_k2,mk2);
massif_k3 = circshift(massif_k3,mk3); 
massif_k4 = circshift(massif_k4,mk4); 
 
% ���� ��� ������� � ������
for pk=1:mk1          % x=1:m1  
xk=mk1+1-pk;   
flmk=flmk+1; % ���� ��� ��������������
% ��� 1     
if   bitand(dat.acpk1(xk),hex2dec('800000'))==0
massif_k1(xk)=double(dat.acpk1(xk)/(2^23-1)/10^9*10^13/2) -mnk1; 
else    
massif_k1(xk)=-double((8388607-(dat.acpk1(xk)-8388608)))/(2^23-1)/10^9*10^13/2 -mnk1;
end
% ��� 2
if   bitand(dat.acpk2(xk),hex2dec('800000'))==0
massif_k2(xk)=double(dat.acpk2(xk)/(2^23-1)/10^9*10^13/2) -mnk2; 
else 
massif_k2(xk)=-double((8388607-(dat.acpk2(xk)-8388608)))/(2^23-1)/10^9*10^13/2 -mnk2;
end

% if en1==1
% % ������ ����� � ����
% fprintf(fidk, '%d || %d\r\n', msk2(xk),msk1(xk));
% end

% ������ ����� � ������
summa_massif_k1(flmk,1) = massif_k1(xk);
summa_massif_k2(flmk,1) = massif_k2(xk);

% plot(a1,l1,msk2','b',l1,msk1','r');
% lok1=sprintf('%d',msk1(xk));
% text(-10,5,lok1,'FontSize',14)
% lok2=sprintf('%d',msk2(xk));
% text(-10,-5,lok2,'FontSize',14)
end 

% n=3;
zk1=0;
zk2=0;

chislok1 = fix(mk1/n);
new_massif_k1 = circshift(new_massif_k1,chislok1);

for x = 1:n:mk1   
  if zk1 ~= chislok1
  zk1 = zk1+1;
  y = 0:n-1;   
  symmak1 = (sum(massif_k1(x+y)))/n; 
%   symma=msk1(x)+msk1(x+1)+msk1(x+2);
  new_massif_k1(zk1) = symmak1;
   if en1 == 1
   % ������ ����� � ����
   fprintf(fidk, '%d \r\n', new_massif_k1(zk1));
   end
  end
end

chislok2 = fix(mk2/n);
new_massif_k2 = circshift(new_massif_k2,chislok2);

for x = 1:n:mk2   
  if zk2 ~= chislok2
  zk2 = zk2+1;
  y = 0:n-1;   
  symmak2 = (sum(massif_k2(x+y)))/n; 
%   symma=msk1(x)+msk1(x+1)+msk1(x+2);
  new_massif_k2(zk2) = symmak2;
  if en1 == 1
  % ������ ����� � ����
  fprintf(fidk, '                  %d \r\n', new_massif_k2(zk2));
  end
  end
end

sk1=sum(summa_massif_k1);
sk2=sum(summa_massif_k2);

plot(a1,l1,new_massif_k2','b',l1,new_massif_k1','r');
% scr = '������-1  %.2f �� � || %.2f �� � || %.2f �����';
% text_k1 = sprintf(scr, new_massif_k1(1),new_massif_k2(1),sk1);
% title(a1,num2str(text_k1))
% ylabel(a1,'���, ��')

scr = '%.2f';
text_k1 = sprintf(scr, new_massif_k1(1));
text_k2 = sprintf(scr, new_massif_k2(1));
text_k3 = sprintf(scr, sk1);
text_k4 = sprintf(scr, sk2);

title(a1,['\fontsize{14} ������-1 ','\color{red}'...
, num2str(text_k1),' �� ','\color{blue}',num2str(text_k2),' ��'...
, '\color{red} \Sigma',num2str(text_k3),'\color{blue} \Sigma',num2str(text_k4)])

ylabel(a1,'���, ��')

% uy=50;
% scr = '%.1f';
% pak = sprintf(scr, i);
% xticks(a1,[0 uy])
% xticklabels(a1,{'a' pak})

% scr = '%d';
% text_k1 = sprintf(scr, newmsk1(1)); 
% text_k2 = sprintf(scr, newmsk2(1)); 
% legend(a1,{num2str(text_k1),num2str(text_k2)},'FontSize',14)
% lok1=sprintf('%d',newmsk1(1));
% text(a1,5,3,lok1,'FontSize',14)
% lok2=sprintf('%d',newmsk2(1));
% text(a1,5,-3,lok2,'FontSize',14)
else
    
    
end

%% ��������� ������ ��� 2 ��������

if ((btsl~=0)&&(ch2==1)) % ������� ����� ����� ��������� �� ��������, ���� ������ 0 ����
cl=uint32(fread(tbl, btsl/4, 'uint32')); % ������ ������

% ���� ��� ��������� ������
for iz=1:btsl/4
% ������� ������������� 
facpl(iz)=bitand(bitshift(cl(iz),-24),hex2dec('f'));
nacpl(iz)=bitshift(cl(iz),-30);
end

yl=0; 
ml1=0;
ml2=0;
ml3=0;
ml4=0;
dat.acpl1 = [ ];
dat.acpl2 = [ ];
dat.acpl3 = [ ];
dat.acpl4 = [ ];

 % ���������� �� ���
 while yl<btsl/4
 yl=yl+1;    
   switch nacpl(yl)
       case 0 %���1
        ml1=ml1+1;
        dat.acpl1(ml1)=bitand(cl(yl),hex2dec('ffffff')); 
       case 1 %���2
        ml2=ml2+1;
        dat.acpl2(ml2)=bitand(cl(yl),hex2dec('ffffff'));
       case 2 %���3
        ml3=ml3+1;
        dat.acpl3(ml3)=bitand(cl(yl),hex2dec('ffffff'));
       case 3 %���4
        ml4=ml4+1;
        dat.acpl4(ml4)=bitand(cl(yl),hex2dec('ffffff'));    
   end

 end
 
% �������� ��������
massif_l1 = circshift(massif_l1,ml1);
massif_l2 = circshift(massif_l2,ml2);
massif_l3 = circshift(massif_l3,ml3); 
massif_l4 = circshift(massif_l4,ml4); 
 
% ���� ��� ������� � ������
 for pl = 1:ml1         % x=1:m1  
xl = ml1+1-pl;   
flml = flml+1; % ���� ��� ��������������
% ���� ��� ������� � ������    
if   bitand(dat.acpl1(xl),hex2dec('800000'))==0
massif_l1(xl)=double(dat.acpl1(xl)/(2^23-1)/10^9*10^13/2) -mnl1; 
else    
massif_l1(xl)=-double((8388607-(dat.acpl1(xl)-8388608)))/(2^23-1)/10^9*10^13/2 -mnl1;
end

if   bitand(dat.acpl2(xl),hex2dec('800000'))==0
massif_l2(xl)=double(dat.acpl2(xl)/(2^23-1)/10^9*10^13/2) -mnl2; 
else 
massif_l2(xl)=-double((8388607-(dat.acpl2(xl)-8388608)))/(2^23-1)/10^9*10^13/2 -mnl2;
end

 
% if en2==1
% % ������ ����� � ����
% fprintf(fidl, '%d || %d\r\n', msl2(xl),msl1(xl));
% end

% ������ ����� � ������
summa_massif_l1(flml,1)=massif_l1(xl);
summa_massif_l2(flml,1)=massif_l2(xl);

end
 
zl1=0;
zl2=0;

chislol1=fix(ml1/n);
new_massif_l1=circshift(new_massif_l1,chislol1);

for x=1:n:ml1   
  if zl1~=chislol1
  zl1=zl1+1;
  y=0:n-1;   
  symmal1=(sum(massif_l1(x+y)))/n; 
%   symma=msk1(x)+msk1(x+1)+msk1(x+2);
  new_massif_l1(zl1)=symmal1;
  if en2==1
  % ������ ����� � ����
  fprintf(fidl, '%d \r\n', new_massif_l1(zl1));
  end
  end
end

chislol2=fix(ml2/n);
new_massif_l2=circshift(new_massif_l2,chislol2);

for x=1:n:ml2   
  if zl2~=chislol2
  zl2=zl2+1;
  y=0:n-1;   
  symmal2=(sum(massif_l2(x+y)))/n; 
%   symma=msk1(x)+msk1(x+1)+msk1(x+2);
  new_massif_l2(zl2)=symmal2;
  if en2==1
  % ������ ����� � ����
  fprintf(fidl, '                  %d \r\n', new_massif_l2(zl2));
  end
  end
end

sl1=sum(summa_massif_l1);
sl2=sum(summa_massif_l2);

plot(a2,l1,new_massif_l2','b',l1,new_massif_l1','r');

% scr = '������-2  %.2f � || %.2f �';
% text_l1 = sprintf(scr, new_massif_l1(1),new_massif_l2(1));
% title(a2,num2str(text_l1))
% ylabel(a2,'���, ��')


scr = '%.2f';
text_l1 = sprintf(scr, new_massif_l1(1));
text_l2 = sprintf(scr, new_massif_l2(1));
text_l3 = sprintf(scr, sl1);
text_l4 = sprintf(scr, sl2);
title(a2,['\fontsize{14} ������-2 ','\color{red}'...
, num2str(text_l1),' �� ','\color{blue}',num2str(text_l2),' ��'...
, '\color{red} \Sigma',num2str(text_l3),'\color{blue} \Sigma',num2str(text_l4)])
% title(a2,num2str(text_l1))
ylabel(a2,'���, ��')

% scr = '%d';
% text_l1 = sprintf(scr, newmsl1(zl2)); 
% text_l2 = sprintf(scr, newmsl2(zl2)); 
% legend(a2,{num2str(text_l1),num2str(text_l2)},'FontSize',14)
% lol1=sprintf('%d',newmsl1(1));
% text(a2,5,3,lol1,'FontSize',14)
% lol2=sprintf('%d',newmsl2(1));
% text(a2,5,-3,lol2,'FontSize',14)

 

if ch4==1
tok1 = new_massif_k1-new_massif_l1;
tok2 = new_massif_k2-new_massif_l2;
plot(a4,l1,tok1,'b',l1,tok2,'r')

scr = '�������� �����  %d || %d';
text_t4 = sprintf(scr, tok1(1),tok2(1));
title(a4,num2str(text_t4))
else
end
% for z=1:m3
%     
% % �����������
% ms3(z)=dat.acp3(z);
% if dat.acp3(z)==8388608
%   ms3(z)=0;  
% end
% if dat.acp3(z)>8388608
%   ms3(z)=2.56*dat.acp3(z)/2^24;  
% end
% if dat.acp3(z)<8388608
%  ms3(z)=-2.56*dat.acp3(z)/2^23;  
% end
% 
% % �����������
% zz=bitand(dat.acp4(z),hex2dec('FF0000'));
% ms4(z)=bitshift(zz,-16)-128;
% % plot(a4,l1,ms4','r');
% % plot(a2,l1,ms3','b');
% end 
else 
end

%% ��������� ������ ��� 3 ��������

if ((btsg~=0)&&(ch3==1)) % ������� ����� ����� ��������� �� ��������, ���� ������ 0 ����
cg=uint32(fread(tbg, btsg/4, 'uint32')); % ������ ������

% ���� ��� ��������� ������
for iz=1:btsg/4
% ������� ������������� 
facpg(iz)=bitand(bitshift(cg(iz),-24),hex2dec('f'));
nacpg(iz)=bitshift(cg(iz),-30);
end

yg=0; 
mg1=0;
mg2=0;
mg3=0;
mg4=0;
dat.acpg1 = [ ];
dat.acpg2 = [ ];
dat.acpg3 = [ ];
dat.acpg4 = [ ];  

% ���������� �� ���
 while yg<btsg/4
 yg=yg+1;    
   switch nacpg(yg)
       case 0 % ���1
        mg1=mg1+1;
        dat.acpg1(mg1)=bitand(cg(yg),hex2dec('ffffff')); 
       case 1 % ���2 
        mg2=mg2+1;
        dat.acpg2(mg2)=bitand(cg(yg),hex2dec('ffffff'));
       case 2 %���3
        mg3=mg3+1;
        dat.acpg3(mg3)=bitand(cg(yg),hex2dec('ffffff'));
       case 3 %���;
        mg4=mg4+1;
        dat.acpg4(mg4)=bitand(cg(yg),hex2dec('ffffff'));    
   end    
 end
 
% �������� ��������
msg1=circshift(msg1,mg1);
msg2=circshift(msg2,mg2);
msg3=circshift(msg3,mg3); 
msg4=circshift(msg4,mg4); 
 
% ���� ��� ������� � ������
for pg=1:mg1          % x=1:m1  
xg=mg1+1-pg;   
flmg=flmg+1; % ���� ��� ��������������
% ��� 1     
if   bitand(dat.acpg1(xg),hex2dec('800000'))==0
massif_g1(xg)=double(dat.acpg1(xg)/(2^23-1)/10^9*10^13/2) -mng1; 
else  
massif_g1(xg)=-double((8388607-(dat.acpg1(xg)-8388608)))/(2^23-1)/10^9*10^13/2 -mng1;
end
% ��� 2
if   bitand(dat.acpg2(xg),hex2dec('800000'))==0
massif_g2(xg)=double(dat.acpg2(xg)/(2^23-1)/10^9*10^13/2) -mng2; 
else 
massif_g2(xg)=-double((8388607-(dat.acpg2(xg)-8388608)))/(2^23-1)/10^9*10^13/2 -mng2;
end

% if en3==1
% % ������ ����� � ����
% fprintf(fidg, '%d || %d\r\n', msg2(xg),msg1(xg));
% end

% ������ ����� � ������
summa_massif_g1(flmg,1)=massif_g1(xg);
summa_massif_g2(flmg,1)=massif_g2(xg);
end

zg1=0;
zg2=0;

chislog1=fix(mg1/n);
new_massif_g1=circshift(new_massif_g1,chislog1);

for x=1:n:mg1   
  if zg1~=chislog1
  zg1=zg1+1;
  y=0:n-1;   
  symmag1=(sum(msg1(x+y)))/n; 
%   symma=msk1(x)+msk1(x+1)+msk1(x+2);
  new_massif_g1(zg1)=symmag1;
  if en3==1
  % ������ ����� � ����
  fprintf(fidg, '%d \r\n', new_massif_g1(zg1));
  end
  end
end

chislog2=fix(mg2/n);
newmsg2=circshift(new_massif_g2,chislog2);

for x=1:n:mg2   
  if zg2~=chislog2
  zg2=zg2+1;
  y=0:n-1;   
  symmak2=(sum(massif_g2(x+y)))/n; 
%   symma=msk1(x)+msk1(x+1)+msk1(x+2);
  new_massif_g2(zg2)=symmak2;
  if en3==1
  % ������ ����� � ����
  fprintf(fidg, '                  %d \r\n', new_massif_g2(zg2));
  end
  end
end

sg1=sum(summa_massif_g1);
sg2=sum(summa_massif_g2);

plot(a3,l1,new_massif_g2','b',l1,new_massif_g1','r');
scr = '%.2f';
text_g1 = sprintf(scr, new_massif_g1(1));
text_g2 = sprintf(scr, new_massif_g2(1));
text_g3 = sprintf(scr, sg1);
text_g4 = sprintf(scr, sg2);

title(a3,['\fontsize{14} ������-1 ','\color{red}'...
, num2str(text_g1),' �� ','\color{blue}',num2str(text_g2),' ��'...
, '\color{red} \Sigma',num2str(text_g3),'\color{blue} \Sigma',num2str(text_g4)])
ylabel(a3,'���, ��')
% scr = '%d';
% text_g1 = sprintf(scr, newmsg1(zg2)); 
% text_g2 = sprintf(scr, newmsg2(zg2)); 
% legend({num2str(text_g1),num2str(text_g2)},'FontSize',14)
% log1=sprintf('%d',newmsg1(xg));
% text(a3,5,3,log1,'FontSize',14)
% log2=sprintf('%d',newmsg2(xg));
% text(a3,5,-3,log2,'FontSize',14)

else
end
i=toc;
end

%%
if summa_massif_k1==0
else
% �������������� 
sk1=sum(summa_massif_k1);
sk2=sum(summa_massif_k2);
end
if en1==1
fprintf(fidkk, '%d || %d \r\n', sk1,sk2);
end
if summa_massif_l1==0
else
% �������������� 
sl1=sum(summa_massif_l1);
sl2=sum(summa_massif_l2);
end
if en2==1
fprintf(fidll, '%d || %d \r\n', sl1,sl2);
end
if summa_massif_g1==0
else
% �������������� 
sg1=sum(summa_massif_g1);
sg2=sum(summa_massif_g2);
end
if en3==1
fprintf(fidgg, '%d || %d \r\n', sg1,sg2);
end
str=cell(6,1);

s1='����� ���� 1 red %d';
str{1,1} = sprintf (s1, sk1);

s2='����� ���� 1 blue %d';
str{2,1} = sprintf (s2, sk2);

s3='����� ���� 2 red %d';
str{3,1} = sprintf (s3, sl1);

s4='����� ���� 2 blue %d';
str{4,1} = sprintf (s4, sl2);

s5='����� ���� 3 red %d';
str{5,1} = sprintf (s5, sg1);

s6='����� ���� 3 blue %d';
str{6,1} = sprintf (s6, sg2);

