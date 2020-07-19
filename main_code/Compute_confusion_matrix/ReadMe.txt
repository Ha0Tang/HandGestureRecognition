========================================================================
Matlab code for computing and visualization: Confusion Matrix, Precision/Recall, ROC, 
Accuracy, F-Measure etc. for Classification.

The package runs well at Matlab(Version:R2010b) for Windows. However, it may
report some errors at old version matlab, e.g., "no function 'assert'" or others.
You can update yout Matlab or you can find the missing functions(.m files).



 Created by Piji Li (pagelee.sd@gmail.com)   blog: http://www.zhizhihu.com
IRLab. : http://ir.sdu.edu.cn     
Shandong University,Jinan,China
10/1/2010

Some code are from:
 1¡¢Literature:
     K.H. Brodersen, C.S. Ong, K.E. Stephan, J.M. Buhmann (2010). The
     binormal assumption on precision-recall curves. In: Proceedings of
     the 20th International Conference on Pattern Recognition (ICPR).
 Kay H. Brodersen & Cheng Soon Ong, ETH Zurich, Switzerland
 $Id: prc_demo.m 5529 2010-04-22 21:10:32Z bkay $

 2¡¢GETCM : gets confusion matrices, precision, recall, and F scores
 [confus,numcorrect,precision,recall,F] = getcm (actual,pred,[classes])
 dinoj@cs.uchicago.edu , Apr 2005, modified July 2005

========================================================================


Just run main.m, then you can follow the method in main.m do do your own
work.
   