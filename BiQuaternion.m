//
//  BiQuaternion.m
//  Matte
//
//  Created by Erik Österlund on 2009-02-04.
//

#import "BiQuaternion.h"


@implementation BiQuaternion

- (void)setIm:(double)Im{
	ImElements[3] = Im;
}

- (double)Im{
	return ImElements[3];
}

- (void)setImi:(double)Imi{
	ImElements[0] = Imi;
}

- (double)Imi{
	return ImElements[0];
}

- (void)setImj:(double)Imj{
	ImElements[1] = Imj;
}

- (double)Imj{
	return ImElements[1];
}

- (void)setImk:(double)Imk{
	ImElements[2] = Imk;
}

- (double)Imk{
	return ImElements[2];
}

- (id)initWithRe:(double)Re 
				 i:(double)I 
				 j:(double)J 
				 k:(double)K 
				Im:(double)Im 
			   Imi:(double)Imi 
			   Imj:(double)Imj 
			   Imk:(double)Imk{
	self = [[BiQuaternion alloc] initWithRe:Re i:I j:J k:K];
	if(self){
		ImElements[3] = Im;
		ImElements[0] = Imi;
		ImElements[1] = Imj;
		ImElements[2] = Imk;
	}
	return self;
}

+ (id)biQuaternionWithRe:(double)Re 
					   i:(double)I 
					   j:(double)J 
					   k:(double)K 
					  Im:(double)Im 
					 Imi:(double)Imi 
					 Imj:(double)Imj 
					 Imk:(double)Imk{
	return [[[BiQuaternion alloc] initWithRe:Re 
										   i:I 
										   j:J 
										   k:K 
										  Im:Im 
										 Imi:Imi 
										 Imj:Imj 
										 Imk:Imk] autorelease];
}

- (id)initWithAngle:(double)angle Imi:(double)Imi Imj:(double)Imj Imk:(double)Imk{
	self = [super init];
	if(self){
		double scalar = sinh(angle)/sqrt(Imi*Imi + Imj*Imj + Imk*Imk);
		self.Re = cosh(angle);
		ImElements[0] = scalar*Imi;
		ImElements[1] = scalar*Imj;
		ImElements[2] = scalar*Imk;
	}
	return self;
}

+ (id)biQuaternionWithAngle:(double)angle Imi:(double)Imi Imj:(double)Imj Imk:(double)Imk{
	return [[[BiQuaternion alloc] initWithAngle:angle i:Imi j:Imj k:Imk] autorelease];
}

- (double*)ImElements
{
	return ImElements;
}

- (NSString*)description
{
	NSMutableString* str = [NSMutableString new];
	int saker = 0;
	[str appendString:@"("];
	if(self.Re != 0.0){
		[str appendFormat:@"%g", self.Re];
		saker++;
	}
	if(self.Im != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.Im == 1.0)
			[str appendString:@"ı"];
		else if(self.Im == -1)
			[str appendString:@"-ı"];
		else
			[str appendFormat:@"%gı", self.Im];
		saker++;
	}
	if(self.i != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.i == 1.0)
			[str appendString:@"i"];
		else if(self.i == -1)
			[str appendString:@"-i"];
		else
			[str appendFormat:@"%gi", self.i];
		saker++;
	}
	if(self.j != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.j == 1.0)
			[str appendString:@"j"];
		else if(self.j == -1)
			[str appendString:@"-j"];
		else
			[str appendFormat:@"%gj", self.j];
		saker++;
	}
	if(self.k != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.k == 1.0)
			[str appendString:@"k"];
		else if(self.k == -1)
			[str appendString:@"-k"];
		else
			[str appendFormat:@"%gk", self.k];
		saker++;
	}
	if(self.Imi != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.Imi == 1.0)
			[str appendString:@"ıi"];
		else if(self.Imi == -1)
			[str appendString:@"-ıi"];
		else
			[str appendFormat:@"%gıi", self.Imi];
		saker++;
	}
	if(self.Imj != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.Imj == 1.0)
			[str appendString:@"ıj"];
		else if(self.Imj == -1)
			[str appendString:@"-ıj"];
		else
			[str appendFormat:@"%gıj", self.Imj];
		saker++;
	}
	if(self.Imk != 0.0){
		if(saker != 0)
			[str appendString:@" + "];
		if(self.Imk == 1.0)
			[str appendString:@"ık"];
		else if(self.Imk == -1)
			[str appendString:@"-ık"];
		else
			[str appendFormat:@"%gık", self.Imk];
		saker++;
	}
	[str appendString:@")"];
	return [str autorelease];
}

@end
