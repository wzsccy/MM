

function [c,ceq] = nonlfun1(x)
    % c��ʾ�����Բ���ʽԼ��
    c = [x(1) + x(2)^2 + x(3)^2 - 20];
    ceq = [-x(1) - x(2)^2 + 2];
    % ceq��ʾ�����Ե�ʽԼ��
end
