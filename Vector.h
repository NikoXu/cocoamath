//
//  Vector.h
//  Matte
//
//  Created by Erik Österlund on 2009-02-05.
//

#import <Cocoa/Cocoa.h>


@interface Vector3 : NSObject {
	double elements[3];
}

@property(readwrite, assign)double x;
@property(readwrite, assign)double y;
@property(readwrite, assign)double z;

- (id)initWithX:(double)x y:(double)y z:(double)z;
- (id)vectorWithX:(double)x y:(double)y z:(double)z;

@end
