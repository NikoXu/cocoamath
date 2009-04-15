//
//  Quaternion.m
//  Matte
//
//  Created by Erik Österlund on 2008-12-21.
//

#import "Quaternion.h"
#include <math.h>


@implementation Quaternion

- (double)Re
{
	return elements[3];
}

- (double)i
{
	return elements[0];
}

- (double)j
{
	return elements[1];
}

- (double)k
{
	return elements[2];
}

- (void)setRe:(double)Real
{
	elements[3] = Real;
}

- (void)setI:(double)I
{
	elements[0] = I;
}

- (void)setJ:(double)J
{
	elements[1] = J;
}

- (void)setK:(double)K
{
	elements[2] = K;
}

- (id)initWithRe:(double)Re i:(double)I j:(double)J k:(double)K
{
	self = [super init];
	if(self){
		elements[3] = Re;
		elements[0] = I;
		elements[1] = J;
		elements[2] = K;
	}
	return self;
}

+ (id)quaternionWithRe:(double)Re i:(double)I j:(double)J k:(double)K
{
	return [[[Quaternion alloc] initWithRe:Re i:I j:J k:K] autorelease];
}

- (id)initWithRandomDirection
{
	double Real, I, J, K;
	BOOL notDone = YES;
	while(notDone)
	{
		Quaternion* temp = [[Quaternion alloc] initWithRe:0.0 
														i:(double)(random()%100000)*0.00002-0.5
														j:(double)(random()%100000)*0.00002-0.5
														k:(double)(random()%100000)*0.00002-0.5];
		double Norm = [temp ImNorm];
		if(Norm <= 1.0 && Norm > 0.1){
			Real = 0.0;
			double scalar = 1.0/Norm;
			I = temp.i*scalar;
			J = temp.j*scalar;
			K = temp.k*scalar;
			notDone = NO;
		}
		[temp release];
	}
	return [self initWithRe:Real i:I j:J k:K];
}

+ (id)quaternionWithRandomDirection
{
	
	return [[[Quaternion alloc] initWithRandomDirection] autorelease];
}

- (id)initAsProductOf:(Quaternion*)q1 And:(Quaternion*)q2
{
	self = [super init];
	if(self)
	{
		double* q1El = q1.elements;
		double* q2El = q2.elements;
		
		elements[3] = q1El[3]*q2El[3] - q1El[0]*q2El[0] - q1El[1]*q2El[1] - q1El[2]*q2El[2];
		elements[0] = q1El[3]*q2El[0] + q1El[0]*q2El[3] + q1El[1]*q2El[2] - q1El[2]*q2El[1];
		elements[1] = q1El[3]*q2El[1] + q1El[1]*q2El[3] + q1El[2]*q2El[0] - q1El[0]*q2El[2];
		elements[2] = q1El[3]*q2El[2] + q1El[2]*q2El[3] + q1El[0]*q2El[1] - q1El[1]*q2El[0];
	}
	return self;
}

- (id)initWithAngle:(double)angle i:(double)I j:(double)J k:(double)K
{
	self = [super init];
	if(self){
		double ImNorm = 1.0/sqrt(I*I + J*J + K*K);
		double sinA = sin(angle);
		elements[3] = cos(angle);
		elements[0] = sinA * I * ImNorm;
		elements[1] = sinA * J * ImNorm;
		elements[2] = sinA * K * ImNorm;
	}
	return self;
}

+ (id)quaternionWithAngle:(double)angle i:(double)I j:(double)J k:(double)K
{
	return [[[Quaternion alloc] initWithAngle:angle i:I j:J k:K] autorelease];
}

- (double*)elements
{
	return elements;
}

+ (void)initialize
{
	[super initialize];
	srandom(time(NULL));
}

- (NSString*)description
{
	NSMutableString* str = [NSMutableString new];
	int saker = 0;
	[str appendString:@"("];
	if(elements[3] != 0.0){
		[str appendFormat:@"%g", elements[3]];
		saker++;
	}
	if(elements[0] != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(elements[0] == 1.0)
			[str appendString:@"i"];
		else if(elements[0] == -1)
			[str appendString:@"-i"];
		else
			[str appendFormat:@"%gi", elements[0]];
		saker++;
	}
	if(elements[1] != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(elements[1] == 1.0)
			[str appendString:@"j"];
		else if(elements[1] == -1)
			[str appendString:@"-j"];
		else
			[str appendFormat:@"%gj", elements[1]];
		saker++;
	}
	if(elements[2] != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(elements[2] == 1.0)
			[str appendString:@"k"];
		else if(elements[2] == -1)
			[str appendString:@"-k"];
		else
			[str appendFormat:@"%gk", elements[2]];
		saker++;
	}
	[str appendString:@")"];
	return [str autorelease];
}

@end
