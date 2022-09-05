function [str] = com14(cm)
%Str5, Str6, Str7, Str9, Str10, Str11, Str12, Str13, Str14, Str15, Str16, Str17, Str18
%���������
fwrite(cm,14); %�������� �������
pause(0.1);
bts=get(cm,'BytesAvailable');
if bts==0
disp('0 ������')
else
p = fread(cm,bts,'uint8');

str=cell(13,1);

for i=1:bts-1
c1=p(bts-(i-1));
c2=p(bts-i);

% ��������� ��������� 
if c1==18 && c2==255 
  a1 = p(bts-(i-3)); 
  cc1='�������� ��������� ��������';
  cc2='��������� �������������� ����������';
  cc3='��������� ���3,���4';
  cc4='��������� �� �� ���������';
  cc5='�� ������������ �������� �������';
  cc6='��������� ������� ���� ������������';
  for o=0:5
  oo=bitshift(1,o);
  c = bitand(a1,oo);
  switch c
      case 1
      cc1='������������ �������� ���������';
      case 2
      cc2='�������� �������������� ����������';
      case 4
      cc3='�������� ���3, ���4';
      case 8
      cc4='��������� ����� �� ���������';
      case 16
      cc5='����������� ������������ �������� ������� ����������������';
      case 32
      cc6='������ ������� ���� �������������';
  end    
  end
end 

% �������� �������� ����������
if c1==19 && c2==255 
  a1 = p(bts-(i-2));
  a2 = p(bts-(i-3));
% �������������� ������ � ����� 
  x = a1*256+a2;
  V1 = ceil(x/65535*1030);
end

% ���������� �������� ����������
if c1==20 && c2==255 
  a1 = p(bts-(i-2));
  a2 = p(bts-(i-3));
% �������������� ������ � ����� 
  x = a1*256+a2;
  V2 = ceil(x/65535*1030);
end

% ����� �������� 
if c1==21 && c2==255 
  b = p(bts-(i-2));
  bc = p(bts-(i-3));
end

% �������� ����������
if c1==23 && c2==255 
  a1 = p(bts-(i-2));
  a2 = p(bts-(i-3));
% �������������� ������ � ����� 
  x = a1*256+a2;
  V5 = ceil(x/65535*1030);
end

% MAC
if c1==24 && c2==255 
  mac1 = p(bts-(i-2));
  mac2 = p(bts-(i-3));
  mac3 = p(bts-(i-6));
  mac4 = p(bts-(i-7));
  mac5 = p(bts-(i-10));
  mac6 = p(bts-(i-11));
end

% IP
if c1==27 && c2==255 
  ip1 = p(bts-(i-2));
  ip2 = p(bts-(i-3));
  ip3 = p(bts-(i-6));
  ip4 = p(bts-(i-7));
end

% MASK
if c1==29 && c2==255 
  mask1 = p(bts-(i-2));
  mask2 = p(bts-(i-3));
  mask3 = p(bts-(i-6));
  mask4 = p(bts-(i-7));
end

end

s5='�������� �������� ���������� %d';
str{1,1} = sprintf (s5, V1);

s6='���������� �������� ���������� %d';
str{2,1} = sprintf (s6, V2);

s7='�������� �� ������������ ������� %d, ����� �������� �������� ������������� %d';
str{3,1} = sprintf (s7, b, bc);

s9='�������� ���������� %d';
str{4,1} = sprintf (s9, V5);

s10='MAC %d.%d.%d.%d.%d.%d';
str{5,1} = sprintf (s10, mac1, mac2, mac3, mac4, mac5, mac6);

s11='IP %d.%d.%d.%d.%d.%d';
str{6,1} = sprintf (s11, ip1, ip2, ip3, ip4);

s12='MASK %d.%d.%d.%d.%d.%d';
str{7,1} = sprintf (s12, mask1, mask2, mask3, mask4);

str{8,1} = sprintf (cc1);
str{9,1} = sprintf (cc2);
str{10,1} = sprintf (cc3);
str{11,1} = sprintf (cc4);
str{12,1} = sprintf (cc5);
str{13,1} = sprintf (cc6);

end
