function [tbl]=bondbl()
tbl=tcpip('192.168.161.240',5000,'InputBufferSize',2048); %��������� ���������� � ������
fopen(tbl);%�������� TCP ������� � ��������
end

