;(if (not (=  (substr (ver) 1 16) "Visual LISP 2012")) (exit)) ;如果当前AutoCAD版本不是"Visual LISP 2012"，则退出当前的LISP程序；否则，继续执行后续的LISP代码。
;|
(cond ((/= (vl-file-size "c:/amcad/dwg/ASSEMBLY.DWG") 207833)
          (setq Templete_flag nil)
      );
      ((/= (vl-file-size "c:/amcad/dwg/parts.DWG") 208448)
          (setq Templete_flag nil)
      );
      ((/= (strcat (itoa (nth 0 (setq s (vl-file-systime "c:/amcad/dwg/ASSEMBLY.DWG")))) 
                  (itoa (nth 1 s)) (itoa (nth 2 s)) (itoa (nth 3 s)) (itoa (nth 4 s))
                  (itoa (nth 5 s)))
              "2012114151453")
          (setq Templete_flag nil)
      );
      ((/= (strcat (itoa (nth 0 (setq s (vl-file-systime "c:/amcad/dwg/parts.DWG")))) 
                  (itoa (nth 1 s)) (itoa (nth 2 s)) (itoa (nth 3 s)) (itoa (nth 4 s))
                  (itoa (nth 5 s)))
          "2012114151444")
          (setq Templete_flag nil)
      );
      (T
          (setq Templete_flag T)
      )
);cond,以上部分是判断图纸的标题栏文件是否为原始大小,比较从指定文件获取的系统时间与字符串"2012114151453"是否不相等,如果有变化不向下执行.
|;
(setq Templete_flag T) ;将上面的注释掉了，看看是否可以顺利执行。
(defun tg (x)
  (setq x (/ (sin x) (cos x)))
) ;这个函数的目的是计算参数"x"的正切值，并将结果赋值给变量"x"。

(defun fh (x / pt)
  (setq pt (getpoint "\n文字符号位置..."))
  (command "text" "c" pt (* i 3) 0 x)
);这个函数的目的是在AutoCAD中创建一个居中对齐的文本对象，插入到用户指定的点上，内容为函数的参数"x"。

(defun ca1 (/ n ab m b1)
  (setq a1 (ssget "X" '((0 . "LWPOLYLINE") (-3 ("SJYJY")))))
  (if a1
    (progn
      (setq n (sslength a1))
      (setq ab 0
	    m  0
      )
      (repeat n
	(setq b1 (assoc -3 (entget (ssname a1 m) '("SJYJY")))
	      b1 (cadr b1)
	      b1 (cdadr b1)
	      b1 (atof b1)
	)
	(setq ab (+ ab b1)
	      m	 (1+ m)
	)
      )					;repeat
      (setq a1 (rtos ab 2 3))
    )					;progn
    (setq a1 "")
  )					;if
)
(defun asc (x y / m n)
  (setvar "dimzin" 8)
  (setq	m 1
	n ""
  )
  (repeat (strlen x)
    (setq n (strcat n (rtos (+ (ascii (substr x m 1)) y))))
    (setq m (1+ m))
  )
  (cond	((<= (strlen n) 8)
	 (setq x n)
	)
	((> (strlen n) 16)
	 (setq x (itoa (+ (atoi (substr n 1 8))
			  (atoi (substr n 9 8))
			  (atoi (substr n 17))
		       )
		 )
	 )
	)
	(T
	 (setq x (itoa (+ (atoi (substr n 1 8)) (atoi (substr n 9)))))
	)
  )
)
(defun psave ()
  (ca1)
  (if (< i 1)
    (setq sc (strcat (rtos (/ 1 i) 2 3) ":1"))
    (setq sc (strcat "1:" (rtos i 2 3)))
  )
  (setq	oldosmo	(getvar "osmode")
	oldclay	(getvar "clayer")
	oldcolo	(getvar "cecolor")
	oldtxte	(getvar "texteval")
  )
)					;psave
(defun pload ()
      (setvar "cmdecho" 0)
      (setvar "osmode" oldosmo)
      (setvar "clayer" oldclay)
      (setvar "cecolor" oldcolo)
      (setvar "texteval" oldtxte)
      (setvar "highlight" 1)
      (setvar "dimupt" 0)
)					;pload
(defun *error* (msg)
  (COND	((= msg "quit / exit abort")
	 (PRINC "\n *程序中断*")
	)
	((or (= msg "Function cancelled") (= msg "函数被取消"))
	 (princ "\n *操作被取消*")
	)
	((= "HZ" (SUBSTR MSG (- (STRLEN MSG) 2) 2))
	 (princ "\n 通用接口设置完成 \n 要规范制图,建议使用AJCAD标准样板文件")
	 (COMMAND "STYLE"  "HZ"	    "ZGTXT,HZFS"      0	       0.85
		  0	   "N"	    "N"	     "N"      "STYLE"
		  "STANDARD"	    "ZGTXT"  0	      0.85     0
		  "N"	   "N"	    "N"
		 )
	 (SETVAR "DIMTXSTY" "HZ")
	 (command "load" "camd")
	 (SETVAR "TEXTSTYLE" "hz")
	)
	(T
	 (princ (strcat "\n *操作错误:" msg "*"))
	)
  )					;COND
  (command "layer" "u" "dim-g" "u" "dim" "u" "center" "")
  (setq	mxb nil
	F   NIL
  )
  (pload)
)					;ERROR
(defun pinit (x)
(SETQ S (SSGET "L"))
(setvar "cmdecho" 0)
(setvar "osmode" 0)
(setq i (GETVAR "DIMSCALE"))
(setq ol (getvar "clayer"))
(command "layer" "m" "DIM-G" "c" "141" ""
 "m" "DRAW" "c" "7"  ""
 "m" "DRAW-XI" "c" "4"  ""
 "m" "DIM" "c" "3"  ""
 "m" "Text" "c" "2"  ""
 "m" "CENTER" "c" "1" "" "L" "CENTER" ""
 "m" "DASHED" "c" "6" "" "L" "DASHED" ""
 "m" "DIVIDE" "c" "40" "" "L" "DIVIDE" ""
 "")
(setvar "clayer" ol)
(cond ((= 1 x) ;这个一个判断,当x=1时
       (setq ti i)
       (SETQ ri (GETREAL (strcat "\n指定图纸比例[1:" (rtos i) "]" " <" (rtos i) ">:")))
       (if (or (= ri 0) (= ri nil))
	 (setq ri i)
       )
       (if (/= ri i)
	   (setq i ri)
       )
      )
      ((and (not s) (= 0 x)) ;当条件s为假且x等于0时,整个表达式为真;否则,整个表达式为假.
       (setq ti i)
       (SETQ ri (GETREAL (strcat "\n指定图纸比例[1:" (rtos i) "]" " <" (rtos i) ">:")))
       (if (or (= ri 0) (= ri nil))
	 (setq ri i)
       )
       (setq i ri)
      )
) ;这段应该是初始化图纸比例设置的程序.
(setvar "expert" 5)
(command "-scalelistedit" "a" (strcat "1:" (rtos i)) (strcat "1:" (rtos i)) "e")
(command "style" "standard" "zgtxt.shx,gbcbig.shx" 0 0.85 0 "n" "n" "n")
(command "dimstyle" "r" "standard")
(mapcar 'setvar 
   '("dimscale"  "dimasz"   "dimtoh"    "dimupt"    "dimdec"   "dimdli" 
     "dimtfac"   "dimzin"   "dimtzin"   "dimazin"   "hpname"   "HPSCALE"
     "dimexe"    "DIMSAH"   "dimtih"    "dimtad"    "dimfit"   "filedia"                
     "blipmode"  "dragmode" "aperture"  "PICKBOX"   "luprec"   "ltscale"   
     "MIRRTEXT"  "edgemode" "menuecho"  "highlight" "cmdecho"  "textsize"
     "texteval"  "lispinit" "textstyle" "lunits"    "cecolor"  "DIMGAP"
     "autosnap" "POLARADDANG" "polarmode" "celtype" "dimlfac"  "dimtix"
     "dimatfit"  "dimtdec"   "DIMTXT"   "DIMDSEP"   "DIMTOFL"  "sdi" "dimexo" "cannoscale" 
    )
    (list i   3.2  0   0   1  10
          0.6   8   8   2   "ansi31"  (* 40 i)
          1.1   0   0   1   3  1
          0     2   8   5   3  (* 2 i)
          0     0   3   1   0  (* 3.5 i)
          1     1   "HZ"   2   "bylayer" 1.5
          47 "10;20" 15 "bylayer"  1  0
          1     3   3.5  "." 0  0  0 (strcat "1:" (rtos i)) "HZ"
    )
)
(if (not (tblsearch "appid" "SJYJY"))
  (regapp "SJYJY")
)
(if (not (tblsearch "appid" "JHDATA"))
  (regapp "JHDATA")
)
(setvar "osmode" 183)
(setvar "orthomode" 1)
(psave)
(princ "\n初始化完成。")
(princ)
);pinit
(if (SSGET "L") (pinit 0))
;(princ)

