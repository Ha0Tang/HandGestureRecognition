function [FV] = sphere_tri(shape,maxlevel,r,winding)

% sphere_tri - generate a triangle mesh approximating a sphere
%
% Usage: FV = sphere_tri(shape,Nrecurse,r,winding)
%
%   shape is a string, either of the following:
%   'ico'   starts with icosahedron (most even, default)
%   'oct'   starts with octahedron
%   'tetra' starts with tetrahedron (least even)
%
%   Nrecurse is int >= 0, setting the recursions (default 0)
%
%   r is the radius of the sphere (default 1)
%
%   winding is 0 for clockwise, 1 for counterclockwise (default 0).  The
%   matlab patch command gives outward surface normals for clockwise
%   order of vertices in the faces (viewed from outside the surface).
%
%   FV has fields FV.vertices and FV.faces.  The vertices
%   are listed in clockwise order in FV.faces, as viewed
%   from the outside in a RHS coordinate system.
%
% The function uses recursive subdivision.  The first
% approximation is an platonic solid, either an  icosahedron,
% octahedron or a tetrahedron.  Each level of refinement
% subdivides each triangle face by a factor of 4 (see also
% mesh_refine).  At each refinement, the vertices are
% projected to the sphere surface (see sphere_project).
%
% A recursion level of 3 or 4 is a good sphere surface, if
% gouraud shading is used for rendering.
%
% The returned struct can be used in the patch command, eg:
%
% % create and plot, vertices: [2562x3] and faces: [5120x3]
% FV = sphere_tri('ico',4,1);
% lighting phong; shading interp; figure;
% patch('vertices',FV.vertices,'faces',FV.faces,...
%       'facecolor',[1 0 0],'edgecolor',[.2 .2 .6]);
% axis off; camlight infinite; camproj('perspective');
%
% See also: mesh_refine, sphere_project
%



% $Revision: 1.2 $ $Date: 2005/07/20 23:07:03 $

% Licence:  GNU GPL, no implied or express warranties
% Jon Leech (leech @ cs.unc.edu) 3/24/89
% icosahedral code added by Jim Buddenhagen (jb1556@daditz.sbc.com) 5/93
% 06/2002, adapted from c to matlab by Darren.Weber_at_radiology.ucsf.edu
% 05/2004, reorder of the faces for the 'ico' surface so they are indeed
% clockwise!  Now the surface normals are directed outward.  Also reset the
% default recursions to zero, so we can get out just the platonic solids.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eegversion = '$Revision: 1.2 $';
% fprintf('SPHERE_TRI [v %s]\n',eegversion(11:15)); tic

if ~exist('shape','var') || isempty(shape),
    shape = 'ico';
end
% fprintf('...creating sphere tesselation based on %s\n',shape);

% default maximum subdivision level
if ~exist('maxlevel','var') || isempty(maxlevel) || maxlevel < 0,
    maxlevel = 0;
end

% default radius
if ~exist('r','var') || isempty(r),
    r = 1;
end

if ~exist('winding','var') || isempty(winding),
    winding = 0;
end


% -----------------
% define the starting shapes

shape = lower(shape);

switch shape,
case 'tetra',
    
    % Vertices of a tetrahedron
    sqrt_3 = 0.5773502692;
    
    tetra.v = [  sqrt_3,  sqrt_3,  sqrt_3 ;   % +X, +Y, +Z  - PPP
                -sqrt_3, -sqrt_3,  sqrt_3 ;   % -X, -Y, +Z  - MMP
                -sqrt_3,  sqrt_3, -sqrt_3 ;   % -X, +Y, -Z  - MPM
                 sqrt_3, -sqrt_3, -sqrt_3 ];  % +X, -Y, -Z  - PMM
    
    % Structure describing a tetrahedron
    tetra.f = [ 1, 2, 3;
                1, 4, 2;
                3, 2, 4;
                4, 1, 3 ];
    
    FV.vertices = tetra.v;
    FV.faces    = tetra.f;
    
case 'oct',
    
    % Six equidistant points lying on the unit sphere
    oct.v = [  1,  0,  0 ;  %  X
              -1,  0,  0 ;     % -X
               0,  1,  0 ;  %  Y
               0, -1,  0 ;     % -Y
               0,  0,  1 ;     %  Z
               0,  0, -1 ];    % -Z
    
    % Join vertices to create a unit octahedron
    oct.f = [ 1 5 3 ;    %  X  Z  Y  -  First the top half
              3 5 2 ;    %  Y  Z -X
              2 5 4 ;    % -X  Z -Y
              4 5 1 ;    % -Y  Z  X
              1 3 6 ;    %  X  Y -Z  -  Now the bottom half
              3 2 6 ;    %  Y  Z -Z
              2 4 6 ;    % -X  Z -Z
              4 1 6 ];   % -Y  Z -Z
    
    FV.vertices = oct.v;
    FV.faces    = oct.f;
    
case 'ico',
    
    % Twelve vertices of icosahedron on unit sphere
    tau = 0.8506508084; % t=(1+sqrt(5))/2, tau=t/sqrt(1+t^2)
    one = 0.5257311121; % one=1/sqrt(1+t^2) , unit sphere
    
    ico.v( 1,:) = [  tau,  one,    0 ]; % ZA
    ico.v( 2,:) = [ -tau,  one,    0 ]; % ZB
    ico.v( 3,:) = [ -tau, -one,    0 ]; % ZC
    ico.v( 4,:) = [  tau, -one,    0 ]; % ZD
    ico.v( 5,:) = [  one,   0 ,  tau ]; % YA
    ico.v( 6,:) = [  one,   0 , -tau ]; % YB
    ico.v( 7,:) = [ -one,   0 , -tau ]; % YC
    ico.v( 8,:) = [ -one,   0 ,  tau ]; % YD
    ico.v( 9,:) = [   0 ,  tau,  one ]; % XA
    ico.v(10,:) = [   0 , -tau,  one ]; % XB
    ico.v(11,:) = [   0 , -tau, -one ]; % XC
    ico.v(12,:) = [   0 ,  tau, -one ]; % XD
    
    % Structure for unit icosahedron
    ico.f = [  5,  8,  9 ;
               5, 10,  8 ;
               6, 12,  7 ;
               6,  7, 11 ;
               1,  4,  5 ;
               1,  6,  4 ;
               3,  2,  8 ;
               3,  7,  2 ;
               9, 12,  1 ;
               9,  2, 12 ;
              10,  4, 11 ;
              10, 11,  3 ;
               9,  1,  5 ;
              12,  6,  1 ;
               5,  4, 10 ;
               6, 11,  4 ;
               8,  2,  9 ;
               7, 12,  2 ;
               8, 10,  3 ;
               7,  3, 11 ];
    
    FV.vertices = ico.v;
    FV.faces    = ico.f;
end


% -----------------
% refine the starting shapes with subdivisions
if maxlevel,
    
    % Subdivide each starting triangle (maxlevel) times
    for level = 1:maxlevel,
        
        % Subdivide each triangle and normalize the new points thus
        % generated to lie on the surface of a sphere radius r.
        FV = mesh_refine_tri4(FV);
        FV.vertices = sphere_project(FV.vertices,r);
        
        % An alternative might be to define a min distance
        % between vertices and recurse or use fminsearch
        
    end
end

for i=1:length(FV.faces)
    FV.centers(i,:) = mean(FV.vertices(FV.faces(i,:),:));
    % Unit Normalization
    FV.centers(i,:) = FV.centers(i,:) ./ sqrt(dot(FV.centers(i,:),FV.centers(i,:)));
end

if winding,
%     fprintf('...returning counterclockwise vertex order (viewed from outside)\n');
    FV.faces = FV.faces(:,[1 3 2]);
else
%     fprintf('...returning clockwise vertex order (viewed from outside)\n');
end

% t=toc; fprintf('...done (%6.2f sec)\n\n',t);

return