//
//  Matrix.h
//  Matte
//
//  Created by Erik Österlund on 2008-12-20.
//

#import <Foundation/Foundation.h>


@interface Matrix : NSObject {
	double* elements;
	NSUInteger rows;
	NSUInteger columns;
}

- (id)initWithRows:(NSUInteger)Rows columns:(NSUInteger)Columns;
- (id)initWithElements:(double*)Elements rows:(NSUInteger)Rows columns:(NSUInteger)Columns;
- (id)initWithMatrix:(Matrix*)matrix byRemovingRow:(NSUInteger)Row column:(NSUInteger)Column;
- (id)initIdentityMatrixWithSize:(NSUInteger)size;
+ (id)matrixWithRows:(NSUInteger)Rows columns:(NSUInteger)Columns;
+ (id)matrixWithElements:(double*)Elements rows:(NSUInteger)Rows columns:(NSUInteger)Columns;
+ (id)matrixWithMatrix:(Matrix*)matrix byRemovingRow:(NSUInteger)Row column:(NSUInteger)Column;
+ (id)identityMatrixWithSize:(NSUInteger)size;

- (NSString*)description;
- (BOOL)isSquareMatrix;

@property(readonly, assign)double* elements;
@property(readonly, assign)NSUInteger rows;
@property(readonly, assign)NSUInteger columns;

@end

@interface Matrix (MatrixOperations)

- (Matrix*)multiply:(Matrix*)matrix;

/* Returns 0.0 if receiver is not a square matrix */
- (double)determinant;

/* Returns nil if inverting is impossible */
- (Matrix*)inverse;

- (Matrix*)transpose;

@end