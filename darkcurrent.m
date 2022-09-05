function [str,mnk1,mnk2,mnl1,mnl2,mng1,mng2]=darkcurrent(pop, a1, a2, a3, tbk, tbl, tbg, ch1, ch2, ch3, en1, en2, en3)
% ���������� ���� 
%% ��� if ����� ����� �������� ���������� ���� ��� ������
if isempty(ch1)
ch1=-1;
end

if isempty(ch2)
ch2=-1;
end

if isempty(ch3)
ch3=-1;
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
namefilek=['dark camera 1 ',num2str(tm),'.txt'];
fidk=fopen(namefilek,'w'); 
end
if en2==1
% �������� ����� � ������ � ���� �����
tm=sprintf(clk,  r(1), r(2), r(3), r(4), r(5), r(6));
namefileb=['dark camera 2 ',num2str(tm),'.txt'];
fidl=fopen(namefileb,'w');
end
if en3==1
% �������� ����� � ������ � ���� �����
tm=sprintf(clk,  r(1), r(2), r(3), r(4), r(5), r(6));
namefileb=['dark camera 3 ',num2str(tm),'.txt'];
fidg=fopen(namefileb,'w');
end

pp=300; % ���������� ����� �� �������
l1=0:pp-1;
msk1=zeros(pp,1); 
msk2=zeros(pp,1);
msk3=zeros(pp,1);
msk4=zeros(pp,1);

msl1=zeros(pp,1); 
msl2=zeros(pp,1);
msl3=zeros(pp,1);
msl4=zeros(pp,1);

msg1=zeros(pp,1); 
msg2=zeros(pp,1);
msg3=zeros(pp,1);
msg4=zeros(pp,1);

flmk=0;
mmk1=[];
mmk2=[];

flml=0;
mml1=[];
mml2=[];

flmg=0;
mmg1=[];
mmg2=[];

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
msk1=circshift(msk1,mk1);
msk2=circshift(msk2,mk2);
msk3=circshift(msk3,mk3); 
msk4=circshift(msk4,mk4); 
 
% ���� ��� ������� � ������
for pk=1:mk1          % x=1:m1  
xk=mk1+1-pk;   
flmk=flmk+1; % ���� ��� ��������������
% ��� 1     
if   bitand(dat.acpk1(xk),hex2dec('800000'))==0
msk1(xk)=double(dat.acpk1(xk)/(2^23-1)/10^9*10^15); 
else    
msk1(xk)=-double((8388607-(dat.acpk1(xk)-8388608)))/(2^23-1)/10^9*10^15;
end
% ��� 2
if   bitand(dat.acpk2(xk),hex2dec('800000'))==0
msk2(xk)=double(dat.acpk2(xk)/(2^23-1)/10^9*10^15); 
else 
msk2(xk)=-double((8388607-(dat.acpk2(xk)-8388608)))/(2^23-1)/10^9*10^15;
end

if en1==1
% ������ ����� � ����
fprintf(fidk, '%d || %d\r\n', msk2(xk),msk1(xk));
end

% ������ ����� � ������
mmk1(flmk,1)=msk1(xk);
mmk2(flmk,1)=msk2(xk);

plot(a1,l1,msk2','b',l1,msk1','r');
end  
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
msl1=circshift(msl1,ml1);
msl2=circshift(msl2,ml2);
msl3=circshift(msl3,ml3); 
msl4=circshift(msl4,ml4); 
 
% ���� ��� ������� � ������
 for pl=1:ml1         % x=1:m1  
xl=ml1+1-pl;   
flml=flml+1; % ���� ��� ��������������
R=10^-6;
% ���� ��� ������� � ������    
if   bitand(dat.acpl1(xl),hex2dec('800000'))==0
msl1(xl)=double(dat.acpl1(xl)/(2^23-1)/10^9*10^15); 
else    
msl1(xl)=-double((8388607-(dat.acpl1(xl)-8388608)))/(2^23-1)/10^9*10^15;
end

if   bitand(dat.acpl2(xl),hex2dec('800000'))==0
msl2(xl)=double(dat.acpl2(xl)/(2^23-1)/10^9*10^15); 
else 
msl2(xl)=-double((8388607-(dat.acpl2(xl)-8388608)))/(2^23-1)/10^9*10^15;
end

if en2==1
% ������ ����� � ����
fprintf(fidl, '%d || %d\r\n', msl2(xl),msl1(xl));
end

% ������ ����� � ������
mml1(flml,1)=msl1(xl);
mml2(flml,1)=msl2(xl);

plot(a2,l1,msl2','b',l1,msl1','r');
% text(285,2,num2str(mnl1))
% text(285,-2,num2str(mnl2))
 end
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
       case 3 %���4;
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
msg1(xg)=double(dat.acpg1(xg)/(2^23-1)/10^9*10^15); 
else  
msg1(xg)=-double((8388607-(dat.acpg1(xg)-8388608)))/(2^23-1)/10^9*10^15;
end
% ��� 2
if   bitand(dat.acpg2(xg),hex2dec('800000'))==0
msg2(xg)=double(dat.acpg2(xg)/(2^23-1)/10^9*10^15); 
else 
msg2(xg)=-double((8388607-(dat.acpg2(xg)-8388608)))/(2^23-1)/10^9*10^15;
end

if en3==1
% ������ ����� � ����
fprintf(fidg, '%d || %d\r\n', msg2(xg),msg1(xg));
end

% ������ ����� � ������
mmg1(flmg,1)=msg1(xg);
mmg2(flmg,1)=msg2(xg);

plot(a3,l1,msg2','b',l1,msg1','r');
end  
else
end
i=toc;
end

%%
if mmk1==0
mnk1=0;
mnk2=0;   
else
% ���������� ��������
mnk1=mean(mmk1);
mnk2=mean(mmk2);
end

if mml1==0
mnl1=0;
mnl2=0;
else
% ���������� �������� 
mnl1=mean(mml1);
mnl2=mean(mml2);
end

if mmg1==0
mng1=0;
mng2=0;    
else
% ���������� �������� 
mng1=mean(mmg1);
mng2=mean(mmg2);
end

str=cell(6,1);

s1='������� ��� 1 red %d';
str{1,1} = sprintf (s1, mnk1);

s2='������� ��� 1 blue %d';
str{2,1} = sprintf (s2, mnk2);

s3='������� ��� 2 red %d';
str{3,1} = sprintf (s3, mnl1);

s4='������� ��� 2 blue %d';
str{4,1} = sprintf (s4, mnl2);

s5='������� ��� 3 red %d';
str{5,1} = sprintf (s5, mng1);

s6='������� ��� 3 blue %d';
str{6,1} = sprintf (s6, mng2);


