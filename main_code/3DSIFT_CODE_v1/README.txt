This code is provided as-is and is for research purposes only.  I would like to ask that you link to 
http://www.cs.ucf.edu/~pscovann/ instead of hosting the code at another site.  If you downloaded it 
from anywhere other than http://www.cs.ucf.edu/~pscovann/, please go and download from there to ensure 
the latest version.


This code has evolved significantly since it's initial publication.  We hope that you enjoy the 
additional work that has been put into it.  It should be fairly straightforward, however here is a 
premptive FAQ:


What parameters should I adjust?
All important parameters are in LoadParams.m.  See this file and it's comments for an idea of what to 
tweak.


Is this code for "x-y-z" 3D space data (MRI scans) or "x-y-t" spatio-temporal data (Video)?
Both


Where is the solid angle normalization discussed in the paper?
Due to the implementation of a tessellation based orientation histogram, solid angle normalization is 
unesessary.  This is due to the fact that in the tessellation all bins are equal in size.


Why has rotational invariance been removed?
In our application, action recognition, rotational invariance is less meaningful.  Assuming the camera-
man is able to keep the camera upright and/or people don't develop the ability to walk up vertical 
walls.  In other applications rotational invariance may be important.  I appologize if your research 
depends on rotational invariance, this is on the long list of possible improvements for the future.  
However, I would encourage you to add this ability yourself, and to send me the changes you made so 
that I can make the option available to others.


I received the following message "MISS : Top 3 orientations within ~25 degree range : Returning with 
reRun flag set."  What is going on?
This is another improvement made to the method.  3DSIFT will refuse to generate a descriptor if it 
finds the data at the given location is not descriptive enough.  You can force 3DSIFT to return a 
descriptor by setting TwoPeak_Flag = 0 in LoadParams.m.  I would suggest that you instead write your 
frontend in such a way that you can give 3DSIFT a new location if it returns reRun == 1.


How do I calculate descriptors at multiple scales?
This is best done by resizing your data before calling 3DSIFT.  xyScale and tScale inputs are actually 
more like resolution parameters than scale parameters.
