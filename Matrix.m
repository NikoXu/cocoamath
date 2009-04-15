//
//  Matrix.m
//  Matte
//
//  Created by Erik Österlund on 2008-12-20.
//

#import "Matrix.h"

@implementation Matrix

@synthesize columns, rows, elements;

- (id)initWithRows:(NSUInteger)Rows columns:(NSUInteger)Columns
{
	if(Rows == 0 || Columns == 0){
		[self release];
		return nil;
	}
	self = [super init];
	if(self){
		elements = (double*)calloc(1, sizeof(double) * Rows * Columns);
		rows = Rows;
		columns = Columns;
	}
	return self;
}

- (id)initWithElements:(double*)Elements rows:(NSUInteger)Rows columns:(NSUInteger)Columns
{
	if(Rows == 0 || Columns == 0){
		[self release];
		return nil;
	}
	self = [super init];
	if(self){
		elements = (double*)malloc(sizeof(double) * Rows * Columns);
		rows = Rows;
		columns = Columns;
		for(int i = 0; i < Rows*Columns; i++){
			elements[i] = Elements[i];
		}
	}
	return self;
}

- (id)initWithMatrix:(Matrix*)matrix byRemovingRow:(NSUInteger)Row column:(NSUInteger)Column
{
	NSUInteger Rows = matrix.rows;
	NSUInteger Columns = matrix.columns;
	if(Rows == 0 || Columns == 0){
		[self release];
		return nil;
	}
	self = [super init];
	if(self){
		rows = Rows-1;
		columns = Columns-1;
		elements = malloc(sizeof(double)*rows*columns);
		double* data = matrix.elements;
		NSUInteger index = 0;
		for(NSUInteger i = 0; i < Rows; i++){
			for(NSUInteger j = 0; j < Columns; j++){
				if(i != Row && j != Column)
					elements[index++] = data[i * Columns + j];
			}
		}
	}
	
	return self;
}

- (id)initIdentityMatrixWithSize:(NSUInteger)size
{
	if(size == 0){
		[self release];
		return nil;
	}
	self = [super init];
	if(self){
		rows = size;
		columns = size;
		elements = calloc(1, sizeof(double)*size*size);
		
		for(NSUInteger i = 0; i < size; i++){
			for(NSUInteger j = 0; j < size; j++){
				if(i == j)
					elements[i*size+j] = 1.0;
			}
		}
	}
	
	return self;
}

+ (id)matrixWithRows:(NSUInteger)Rows columns:(NSUInteger)Columns
{
	return [[[Matrix alloc] initWithRows:Rows columns:Columns] autorelease];
}

+ (id)matrixWithElements:(double*)Elements rows:(NSUInteger)Rows columns:(NSUInteger)Columns
{
	return [[[Matrix alloc] initWithElements:Elements rows:Rows columns:Columns] autorelease];
}

+ (id)matrixWithMatrix:(Matrix*)matrix byRemovingRow:(NSUInteger)Row column:(NSUInteger)Column
{
	return [[[Matrix alloc] initWithMatrix:matrix byRemovingRow:Row column:Column] autorelease];
}

+ (id)identityMatrixWithSize:(NSUInteger)size
{
	return [[[Matrix alloc] initIdentityMatrixWithSize:size] autorelease];
}

- (void)dealloc{
	free(elements);
	[super dealloc];
}

- (NSString*)description{
	NSMutableString* str = [NSMutableString new];
	[str appendString:@"{"];
	for(NSUInteger i = 0; i < rows; i++){
		[str appendString:@"{"];
		for(NSUInteger j = 0; j < columns; j++){
			[str appendFormat:@"%g", elements[i*columns+j]];
			if(j+1 != columns)
				[str appendString:@","];
		}
		[str appendString:@"}"];
		if(i+1 != rows)
			[str appendString:@",\n"];
	}
	[str appendString:@"}"];
	[str autorelease];
	return str;
}

- (BOOL)isSquareMatrix
{
	return rows == columns;
}

@end
