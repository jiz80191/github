;�����������ͼֽ�в���ͼֽ������
(defun c:dah ()
  (setq pt (getpoint "\nѡ�����㣺"))
  (setq text "������:386601")
  (setq dimscale (getvar "dimscale")) ; ��ȡ��������
  
  (setq height (* 5 dimscale)) ; ���ݱ��������������ָ߶ȣ�

  (setvar "CLAYER" "DIM") ; ��ͼ������Ϊ"DIM"
 
  (command "text" pt height 0 text)
  
  (princ)
) ; defun����
