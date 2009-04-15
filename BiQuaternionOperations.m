//
//  BiQuaternionOperations.m
//  Matte
//
//  Created by Erik Österlund on 2009-02-04.
//

#import "BiQuaternion.h"


@implementation BiQuaternion (BiQuaternionOperations)

- (void)scaleBy:(double)scalar{
	self.Re = self.Re * scalar;
	self.Im = self.Im * scalar;
	self.i = self.i * scalar;
	self.j = self.j * scalar;
	self.k = self.k * scalar;
	self.Imi = self.Imi * scalar;
	self.Imj = self.Imj * scalar;
	self.Imk = self.Imk * scalar;
}

- (BiQuaternion*)scaledBy:(double)scalar{
	return [BiQuaternion biQuaternionWithRe:self.Re*scalar 
										  i:self.i*scalar  
										  j:self.j*scalar  
										  k:self.k*scalar  
										 Im:self.Im*scalar  
										Imi:self.Imi*scalar  
										Imj:self.Imj*scalar  
										Imk:self.Imk*scalar ];
}

- (BiQuaternion*)multiply:(BiQuaternion*)q{
	return [BiQuaternion biQuaternionWithRe:self.Re*q.Re - self.Im*q.Im		- self.i*q.i  - self.j*q.j - self.k*q.k			+ self.Imi*q.Imi + self.Imj*q.Imj + self.Imk*q.Imk 
										  i:self.Re*q.i - self.Im*q.Imi		+ self.i*q.Re + self.j*q.k - self.k*q.j			- self.Imi*q.Im - self.Imj*q.Imk + self.Imk*q.Imj 
										  j:self.Re*q.j - self.Im*q.Imj		- self.i*q.k + self.j*q.Re + self.k*q.i			+ self.Imi*q.Imk - self.Imj*q.Im - self.Imk*q.Imi 
										  k:self.Re*q.k - self.Im*q.Imk		+ self.i*q.j - self.j*q.i + self.k*q.Re			- self.Imi*q.Imj + self.Imj*q.Imi - self.Imk*q.Im 
										 Im:self.Re*q.Im + self.Im*q.Re		- self.i*q.Imi - self.j*q.Imj - self.k*q.Imk	- self.Imi*q.i - self.Imj*q.j - self.Imk*q.k 
										Imi:self.Re*q.Imi + self.Im*q.i		+ self.i*q.Im + self.j*q.Imk - self.k*q.Imj		+ self.Imi*q.Re + self.Imj*q.k - self.Imk*q.j 
										Imj:self.Re*q.Imj + self.Im*q.j		- self.i*q.Imk + self.j*q.Im + self.k*q.Imi		- self.Imi*q.k + self.Imj*q.Re + self.Imk*q.i 
										Imk:self.Re*q.Imk + self.Im*q.k		+ self.i*q.Imj - self.j*q.Imi + self.k*q.Im		+ self.Imi*q.j - self.Imj*q.i + self.Imk*q.Re];
}

- (BiQuaternion*)add:(BiQuaternion*)q{
	return [BiQuaternion biQuaternionWithRe:self.Re + q.Re
										  i:self.i + q.i
										  j:self.j + q.j
										  k:self.k + q.k
										 Im:self.Im + q.Im
										Imi:self.Imi + q.Imi
										Imj:self.Imj + q.Imj
										Imk:self.Imk + q.Imk];
}

- (BiQuaternion*)subtract:(BiQuaternion*)q{
	return [BiQuaternion biQuaternionWithRe:self.Re - q.Re
										  i:self.i - q.i
										  j:self.j - q.j
										  k:self.k - q.k
										 Im:self.Im - q.Im
										Imi:self.Imi - q.Imi
										Imj:self.Imj - q.Imj
										Imk:self.Imk - q.Imk];
}

- (BiQuaternion*)conjugate{
	return [BiQuaternion biQuaternionWithRe:self.Re 
										  i:-self.i 
										  j:-self.j 
										  k:-self.k 
										 Im:self.Im 
										Imi:-self.Imi 
										Imj:-self.Imj 
										Imk:-self.Imk];
}

- (double)imaginaryVectorMagnitude{
	return sqrt(self.Imi*self.Imi + self.Imj*self.Imj + self.Imk*self.Imk);
}

- (double)vectorMagnitude{
	return sqrt(self.i*self.i + self.j*self.j + self.k*self.k);
}

- (double)norm{
	return sqrt(self.Re*self.Re + self.Im* self.Im + self.i*self.i + self.j*self.j + self.k*self.k - self.Imi*self.Imi - self.Imj*self.Imj - self.Imk*self.Imk);
}

- (BiQuaternion*)inverse{
	BiQuaternion* result = [self conjugate];
	[result scaleBy:[result norm]];
	return result;
}

@end
