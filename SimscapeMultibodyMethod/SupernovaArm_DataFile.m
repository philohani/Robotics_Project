% Simscape(TM) Multibody(TM) version: 25.2

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(9).translation = [0.0 0.0 0.0];
smiData.RigidTransform(9).angle = 0.0;
smiData.RigidTransform(9).axis = [0.0 0.0 0.0];
smiData.RigidTransform(9).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [129.99999999999994 0 -20.000000000000007];  % mm
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [0 0 0];
smiData.RigidTransform(1).ID = "B[Link2forSimulink-1:-:GripperforSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [-5.6843418860808015e-14 2.8421709430404007e-14 -34.999999999999986];  % mm
smiData.RigidTransform(2).angle = 1.3791050120411821e-16;  % rad
smiData.RigidTransform(2).axis = [2.1163626406917054e-16 -1 -1.4593431625373211e-32];
smiData.RigidTransform(2).ID = "F[Link2forSimulink-1:-:GripperforSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0 0 77.999999999999957];  % mm
smiData.RigidTransform(3).angle = 3.1415926535897922;  % rad
smiData.RigidTransform(3).axis = [-1 5.510796331312449e-31 -9.3560260704581016e-16];
smiData.RigidTransform(3).ID = "B[BaseAssemblyforSimulink-1:-:Joint1forSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [0 8.0716882587846158e-13 0];  % mm
smiData.RigidTransform(4).angle = 3.1415926535897922;  % rad
smiData.RigidTransform(4).axis = [-1 5.510796331312449e-31 -9.3560260704581016e-16];
smiData.RigidTransform(4).ID = "F[BaseAssemblyforSimulink-1:-:Joint1forSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-1.5355301206923139e-13 71.98314777082507 45.299999999999976];  % mm
smiData.RigidTransform(5).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(5).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(5).ID = "B[Joint1forSimulink-1:-:Link1forSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-1.5355301206923139e-13 -2.8421709430404007e-14 -93.733147770825354];  % mm
smiData.RigidTransform(6).angle = 1.5700924586837749e-16;  % rad
smiData.RigidTransform(6).axis = [-1 0 -0];
smiData.RigidTransform(6).ID = "F[Joint1forSimulink-1:-:Link1forSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [139.99999999999997 0 -14.999999999999996];  % mm
smiData.RigidTransform(7).angle = 0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = "B[Link1forSimulink-1:-:Link2forSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [-5.6843418860808015e-14 1.4210854715202007e-14 -2.2204460492503131e-14];  % mm
smiData.RigidTransform(8).angle = 2.6138690272981225e-16;  % rad
smiData.RigidTransform(8).axis = [-0.84948634612558271 0.52761060238229363 -5.8576543880117085e-17];
smiData.RigidTransform(8).ID = "F[Link1forSimulink-1:-:Link2forSimulink-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 0];  % mm
smiData.RigidTransform(9).angle = 0;  % rad
smiData.RigidTransform(9).axis = [0 0 0];
smiData.RigidTransform(9).ID = "RootGround[BaseAssemblyforSimulink-1]";


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(5).mass = 0.0;
smiData.Solid(5).CoM = [0.0 0.0 0.0];
smiData.Solid(5).MoI = [0.0 0.0 0.0];
smiData.Solid(5).PoI = [0.0 0.0 0.0];
smiData.Solid(5).color = [0.0 0.0 0.0];
smiData.Solid(5).opacity = 0.0;
smiData.Solid(5).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.53090441438863889;  % kg
smiData.Solid(1).CoM = [5.7296523026334159 0.58640093671428362 38.548513014637898];  % mm
smiData.Solid(1).MoI = [1398.4867936425812 1244.6296300443983 1909.6625137888796];  % kg*mm^2
smiData.Solid(1).PoI = [0.35772434808376474 33.574796573749204 -10.19741138173014];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "BaseAssemblyforSimulink*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.21320687323072848;  % kg
smiData.Solid(2).CoM = [1.6957526916937005 7.2368964135498057 20.059704963340728];  % mm
smiData.Solid(2).MoI = [250.10433345908902 234.18827466948645 315.93940504251577];  % kg*mm^2
smiData.Solid(2).PoI = [-24.48027846755399 4.5538183572799609 11.557880321406792];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "Joint1forSimulink*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.13868354842038202;  % kg
smiData.Solid(3).CoM = [64.83859281156667 -5.3184626625800559e-09 -11.801067903709745];  % mm
smiData.Solid(3).MoI = [43.916288764463694 440.19637655053475 435.73039176922958];  % kg*mm^2
smiData.Solid(3).PoI = [5.1387585788296892e-09 26.693090680785627 6.2244616358735085e-08];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "Link2forSimulink*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.144683548420382;  % kg
smiData.Solid(4).CoM = [69.837221223932687 5.0978975816300549e-09 11.726377950772854];  % mm
smiData.Solid(4).MoI = [44.584944707964524 511.59466845271913 507.36002772791318];  % kg*mm^2
smiData.Solid(4).PoI = [5.0836749565423907e-09 -29.102097082795996 -6.5933489825596356e-08];  % kg*mm^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "Link1forSimulink*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 0.17712583440938887;  % kg
smiData.Solid(5).CoM = [51.014559729028072 4.1413053642083693 -13.018318997860607];  % mm
smiData.Solid(5).MoI = [188.74143845010497 356.32474545671602 295.00052193579722];  % kg*mm^2
smiData.Solid(5).PoI = [6.591117511847175 62.695226291195588 10.125144450604713];  % kg*mm^2
smiData.Solid(5).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = "GripperforSimulink*:*Default";


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(4).Rz.Pos = 0.0;
smiData.RevoluteJoint(4).ID = "";

smiData.RevoluteJoint(1).Rz.Pos = -1.6896696745274937e-14;  % deg
smiData.RevoluteJoint(1).ID = "[Link2forSimulink-1:-:GripperforSimulink-1]";

smiData.RevoluteJoint(2).Rz.Pos = 0;  % deg
smiData.RevoluteJoint(2).ID = "[BaseAssemblyforSimulink-1:-:Joint1forSimulink-1]";

smiData.RevoluteJoint(3).Rz.Pos = -89.999999999999986;  % deg
smiData.RevoluteJoint(3).ID = "[Joint1forSimulink-1:-:Link1forSimulink-1]";

smiData.RevoluteJoint(4).Rz.Pos = 9.5416640443905503e-15;  % deg
smiData.RevoluteJoint(4).ID = "[Link1forSimulink-1:-:Link2forSimulink-1]";

