function com06(dt,o)
%������ ���������� �������� ����������  
t=bond();
if o == 0
    fcore=12.582912;
else 
    fcore=1.572864;
end
cm = 65535-dt*fcore;
str=char([6,cm]);
fwrite(t,str);
fclose(t);
end
��������
