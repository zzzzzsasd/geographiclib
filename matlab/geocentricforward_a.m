function [geocentric, rot] = geocentricforward_a(geodetic, a, f)
%geocentricforward  Convert geographic coordinates to geocentric
%
%   [geocentric, rot] = geocentricforward(geodetic)
%   [geocentric, rot] = geocentricforward(geodetic, a, f)
%
%   geodetic is an M x 3 or M x 2 matrix of geodetic coordinates
%       lat = geodetic(:,1) in degrees
%       lon = geodetic(:,2) in degrees
%       h = geodetic(:,3) in meters (default 0 m)
%
%   geocentric is an M x 3 matrix of geocentric coordinates
%       X = geocentric(:,1) in meters
%       Y = geocentric(:,2) in meters
%       Z = geocentric(:,3) in meters
%   rot is an M x 9 matrix
%       M = rot(:,1:9) rotation matrix in row major order.  Pre-multiplying
%           a unit vector in local cartesian coordinates (east, north, up)
%           by M transforms the vector to geocentric coordinates.
  if (nargin < 2)
    ellipsoid = defaultellipsoid;
  elseif (nargin < 3)
    ellipsoid = [a, 0];
  else
    ellipsoid = [a, flat2ecc(f)];
  end
  if size(geodetic,2) < 3
    h = 0;
  else
    h = geodetic(:,3);
  end
  [X, Y, Z, M] = geocent_fwd(geodetic(:,1), geodetic(:,2), h,  ellipsoid);
  geocentric = [X, Y, Z];
  rot = reshape(permute(M, [3, 2 1]), [], 9);
end
