//
//  BiQuaternion.h
//  Matte
//
//  Created by Erik Österlund on 2009-02-04.
//

#import <Foundation/Foundation.h>
#import "Quaternion.h"

@interface BiQuaternion : Quaternion {
	/* Imi, Imj, Imk, Im */
	double ImElements[4];
}

@property(readwrite, assign)double Im;
@property(readwrite, assign)double Imi;
@property(readwrite, assign)double Imj;
@property(readwrite, assign)double Imk;

- (id)initWithRe:(double)Re
				 i:(double)I 
				 j:(double)J 
				 k:(double)K 
				Im:(double)Im 
			   Imi:(double)Imi 
			   Imj:(double)Imj 
			   Imk:(double)Imk;
+ (id)biQuaternionWithRe:(double)Re
					   i:(double)I 
					   j:(double)J 
					   k:(double)K 
					  Im:(double)Im 
					 Imi:(double)Imi 
					 Imj:(double)Imj 
					 Imk:(double)Imk;

/* Returns a rotation bi-quaternion with given hyperbolic angle and the direction specified by Imi, Imj, Imk. */
- (id)initWithAngle:(double)angle Imi:(double)Imi Imj:(double)Imj Imk:(double)Imk;
+ (id)biQuaternionWithAngle:(double)angle Imi:(double)Imi Imj:(double)Imj Imk:(double)Imk;

- (NSString*)description;

- (double*)ImElements;

@end

@interface BiQuaternion (BiQuaternionOperations) 

- (BiQuaternion*)multiply:(BiQuaternion*)q;
- (BiQuaternion*)add:(BiQuaternion*)q;
- (BiQuaternion*)subtract:(BiQuaternion*)q;

/* Multiplies the receiver's elements by scalar. */
- (void)scaleBy:(double)scalar;
/* Returns a copy of the receiver with its elements multiplied by scalar. */
- (BiQuaternion*)scaledBy:(double)scalar;

- (BiQuaternion*)conjugate;

/* Note: sqrt((x)(x.conj)) */
- (double)norm;

/* Magnitude of Im vector */
- (double)imaginaryVectorMagnitude;
/* Magnitude of Re vector */
- (double)vectorMagnitude;

- (BiQuaternion*)inverse;

- (void)normalize;
- (BiQuaternion*)normalized;

@end
