clc; clear all; 
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_9';
subdir =  dir( maindir ); 
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir ) 
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir ) 
            continue;
        end
 
        subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );


        for k = 3 : length( images )
            imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )

                if images( k ).name(6) == '1'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\1\');
                elseif images( k ).name(6) == '2'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\2\');
                elseif images( k ).name(6) == '3'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\3\');
                elseif images( k ).name(6) == '4'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\4\');
                elseif images( k ).name(6) == '5'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\5\');
                elseif images( k ).name(6) == '6'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\6\');
                elseif images( k ).name(6) == '7'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\7\');
                elseif images( k ).name(6) == '8'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\8\');
                elseif images( k ).name(6) == '9'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\9\');
                end
                movefile(imagepath, newimagepath);
            end
        end
end