;这段命名是在图纸中插入图纸档案号
(defun c:dah ()
  (setq pt (getpoint "\n选择插入点："))
  (setq text "档案号:386601")
  (setq dimscale (getvar "dimscale")) ; 获取比例参数
  
  (setq height (* 5 dimscale)) ; 根据比例参数计算文字高度，

  (setvar "CLAYER" "DIM") ; 将图层设置为"DIM"
 
  (command "text" pt height 0 text)
  
  (princ)
) ; defun结束
