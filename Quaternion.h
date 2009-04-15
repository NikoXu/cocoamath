//
//  Quaternion.h
//  Matte
//
//  Created by Erik Österlund on 2008-12-21.
//

#import <Foundation/Foundation.h>


@interface Quaternion : NSObject {
	/* i, j, k, real*/
	@protected double elements[4];
}

@property(readwrite, assign)double Re;
@property(readwrite, assign)double i;
@property(readwrite, assign)double j;
@property(readwrite, assign)double k;

- (id)initWithRe:(double)Re 
				 i:(double)I 
				 j:(double)J 
				 k:(double)K;
+ (id)quaternionWithRe:(double)Re 
					   i:(double)I 
					   j:(double)J 
					   k:(double)K;

/* Returns a purely imaginary quaternion with norm 1 in a random direction. */
- (id)initWithRandomDirection;
+ (id)quaternionWithRandomDirection;

- (id)initAsProductOf:(Quaternion*)q1 And:(Quaternion*)q2;

/* Returns a rotation quaternion with given angle in radians and the axis specified by i, j, k. */
- (id)initWithAngle:(double)angle i:(double)I j:(double)J k:(double)K;
+ (id)quaternionWithAngle:(double)angle i:(double)I j:(double)J k:(double)K;

- (NSString*)description;

- (double*)elements;

@end

@interface Quaternion (QuaternionOperations)

- (Quaternion*)multiply:(Quaternion*)quaternion;
- (Quaternion*)add:(Quaternion*)quaternion;

/* Multiplies the receiver's elements by scalar. */
- (void)scaleBy:(double)scalar;
/* Returns a copy of the receiver with its elements multiplied by scalar. */
- (Quaternion*)scaledBy:(double)scalar;

- (Quaternion*)conjugate;

- (double)norm;

/* Norm of the imaginary parts */
- (double)ImNorm;

- (Quaternion*)inverse;

- (void)normalize;
- (Quaternion*)normalized;

/* Must be normalized (norm = 1) */
- (Quaternion*)slerp:(Quaternion*)arg t:(double)t;

- (double)separation:(Quaternion*)arg;

/* Rotate receiver by given rotation-quaternion with size 1 and the whole angle */
- (void)rotateBy:(Quaternion*)rot;
- (Quaternion*)rotatedBy:(Quaternion*)rot;

/* Returns a quaternion with half the angle */
- (Quaternion*)rotationQuaternion;

@end