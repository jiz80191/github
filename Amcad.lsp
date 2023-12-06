;(if (not (=  (substr (ver) 1 16) "Visual LISP 2012")) (exit)) ;�����ǰAutoCAD�汾����"Visual LISP 2012"�����˳���ǰ��LISP���򣻷��򣬼���ִ�к�����LISP���롣
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
);cond,���ϲ������ж�ͼֽ�ı������ļ��Ƿ�Ϊԭʼ��С,�Ƚϴ�ָ���ļ���ȡ��ϵͳʱ�����ַ���"2012114151453"�Ƿ����,����б仯������ִ��.
|;
(setq Templete_flag T) ;�������ע�͵��ˣ������Ƿ����˳��ִ�С�
(defun tg (x)
  (setq x (/ (sin x) (cos x)))
) ;���������Ŀ���Ǽ������"x"������ֵ�����������ֵ������"x"��

(defun fh (x / pt)
  (setq pt (getpoint "\n���ַ���λ��..."))
  (command "text" "c" pt (* i 3) 0 x)
);���������Ŀ������AutoCAD�д���һ�����ж�����ı����󣬲��뵽�û�ָ���ĵ��ϣ�����Ϊ�����Ĳ���"x"��

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
	 (PRINC "\n *�����ж�*")
	)
	((or (= msg "Function cancelled") (= msg "������ȡ��"))
	 (princ "\n *������ȡ��*")
	)
	((= "HZ" (SUBSTR MSG (- (STRLEN MSG) 2) 2))
	 (princ "\n ͨ�ýӿ�������� \n Ҫ�淶��ͼ,����ʹ��AJCAD��׼�����ļ�")
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
	 (princ (strcat "\n *��������:" msg "*"))
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
(cond ((= 1 x) ;���һ���ж�,��x=1ʱ
       (setq ti i)
       (SETQ ri (GETREAL (strcat "\nָ��ͼֽ����[1:" (rtos i) "]" " <" (rtos i) ">:")))
       (if (or (= ri 0) (= ri nil))
	 (setq ri i)
       )
       (if (/= ri i)
	   (setq i ri)
       )
      )
      ((and (not s) (= 0 x)) ;������sΪ����x����0ʱ,�������ʽΪ��;����,�������ʽΪ��.
       (setq ti i)
       (SETQ ri (GETREAL (strcat "\nָ��ͼֽ����[1:" (rtos i) "]" " <" (rtos i) ">:")))
       (if (or (= ri 0) (= ri nil))
	 (setq ri i)
       )
       (setq i ri)
      )
) ;���Ӧ���ǳ�ʼ��ͼֽ�������õĳ���.
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
(princ "\n��ʼ����ɡ�")
(princ)
);pinit
(if (SSGET "L") (pinit 0))
;(princ)

