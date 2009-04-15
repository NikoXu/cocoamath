//
//  QuaternionOperations.m
//  Matte
//
//  Created by Erik Österlund on 2008-12-22.
//

#import "Quaternion.h"
#include <math.h>
#import "Constants.h"


@implementation Quaternion (QuaternionOperations)

- (Quaternion*)multiply:(Quaternion*)q
{
	double* argE = q.elements;
	return [Quaternion quaternionWithRe:elements[3]*argE[3] - elements[0]*argE[0] - elements[1]*argE[1] - elements[2]*argE[2]
									  i:elements[3]*argE[0] + elements[0]*argE[3] + elements[1]*argE[2] - elements[2]*argE[1]
									  j:elements[3]*argE[1] + elements[1]*argE[3] + elements[2]*argE[0] - elements[0]*argE[2]
									  k:elements[3]*argE[2] + elements[2]*argE[3] + elements[0]*argE[1] - elements[1]*argE[0]];
}

- (Quaternion*)add:(Quaternion*)q
{
	double* argE = q.elements;
	return [Quaternion quaternionWithRe:elements[3]+argE[3]
									  i:elements[0]+argE[0]
									  j:elements[1]+argE[1]
									  k:elements[2]+argE[2]];
}

- (void)scaleBy:(double)scalar
{
	@synchronized(self){
		elements[0]*=scalar;
		elements[1]*=scalar;
		elements[2]*=scalar;
		elements[3]*=scalar;
	}
}

- (Quaternion*)scaledBy:(double)scalar
{
	return [Quaternion quaternionWithRe:elements[3]*scalar
									  i:elements[0]*scalar
									  j:elements[1]*scalar
									  k:elements[2]*scalar];
}

- (Quaternion*)conjugate
{
	return [Quaternion quaternionWithRe:elements[3] 
									  i:-elements[0] 
									  j:-elements[1] 
									  k:-elements[2]];
}

- (double)norm
{
	return sqrt(elements[0]*elements[0] + elements[1]*elements[1] + elements[2]*elements[2] + elements[3]*elements[3]);
}

- (double)ImNorm
{
	return sqrt(elements[0]*elements[0] + elements[1]*elements[1] + elements[2]*elements[2]);
}

- (Quaternion*)inverse
{
	Quaternion* q = [self conjugate];
	[q scaleBy:1.0/[self norm]];
	return q;
}

- (void)normalize
{
	[self scaleBy:1.0/[self norm]];
}

- (Quaternion*)normalized
{
	return [self scaledBy:[self norm]];
}

- (Quaternion*)rotatedBy:(Quaternion*)Rot
{
	Quaternion* rot = [Rot rotationQuaternion];
	if(rot == nil) // Rotation by π or 0 along any axis.
	{
		if(Rot.Re > 0.0)	// Nothing
			return [Quaternion quaternionWithRe:elements[3] i:elements[0] j:elements[1] k:elements[2]];
		return [self conjugate]; // π
	}
		
	return [[rot multiply:self] multiply:[rot conjugate]];
}

- (void)rotateBy:(Quaternion*)rot
{
	Quaternion* q = [self rotatedBy:rot];
	elements[3] = q.Re;
	elements[0] = q.i;
	elements[1] = q.j;
	elements[2] = q.k;
}

- (Quaternion*)rotationQuaternion
{
	double ImNorm = [self ImNorm];
	if(ImNorm == 0.0)
		return nil;
	
	double angle = acos(elements[3])*0.5;
	double sinA = sin(angle);
	double scalar = 1.0/ImNorm;
	Quaternion* halfRot = [Quaternion quaternionWithRe:cos(angle)
													 i:sinA*elements[0]*scalar
													 j:sinA*elements[1]*scalar
													 k:sinA*elements[2]*scalar];
	return halfRot;
}

- (Quaternion*)slerp:(Quaternion*)arg t:(double)t
{
	double sep = [self separation:arg];
	if(sep > 1.0)
		sep = 1.0;
	else if(sep < -1.0)
		sep = -1.0;
	double angle = acos(sep);
	double sc1, sc2;
	if(angle == 0.0 || angle == PI){
		sc1 = 1.0;
		sc2 = 0.0;
	}
	sc1 = sin(angle*(1.0-t))/sin(angle);
	sc2 = sin(angle*t)/sin(angle);
	Quaternion* result = [Quaternion quaternionWithRe:self.Re*sc1+arg.Re*sc2
													i:self.i*sc1+arg.i*sc2 
													j:self.j*sc1+arg.j*sc2 
													k:self.k*sc1+arg.k*sc2];
	
	return result;
}

- (double)separation:(Quaternion*)arg
{
	double* elements2 = [arg elements];
	return elements[0]*elements2[0] + elements[1]*elements2[1]
	+ elements[2]*elements2[2] + elements[3]*elements2[3];
}

@end
