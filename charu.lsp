
;这段命名是在图纸中插入图纸档案号
(defun C:charu ()
  (setq pt (getpoint "\n选择插入点:"))

  (setq dimscale (getvar "dimscale")) ; 获取比例参数
  

    (princ pt)
    (princ dimscale)
    (command "-insert" "/home/yl1203/ZWCADM/dwg/PARTS.dwg" pt dimscale "" "") 
    ;| 
      命令: CHARU
      选择插入点:(23.3826 18.0731 0.0)1.0-insert
      插入图块或 [列出图中块(?)]:选择复制到剪切板中的对象: 
      指定块的插入点或 [基点(B)/比例(S)/X/Y/Z/旋转(R)]: 
      命令: 
      命令: 1.000000000000000
      未知命令1.000000000000000。按 F1 查看帮助。
      命令: 
      命令:  
      ****************
      我在此处做了一个实验，手动输入命令，看每一步的输入
      命令: -INSERT
      插入图块或 [列出图中块(?)] <PARTS>: /home/yl1203/ZWCADM/dwg/PARTS.dwg
      指定块的插入点或 [基点(B)/比例(S)/X/Y/Z/旋转(R)]:      ;这个位置是自动换的行，不是我换的（大概问题就在这个换行上）
      命令: 415,5
      未知命令415,5。按 F1 查看帮助。
      |;
 
  
  (princ)
  
) ; defun结束


