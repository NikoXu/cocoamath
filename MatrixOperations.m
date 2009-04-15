//
//  MatrixOperations.m
//  Matte
//
//  Created by Erik Österlund on 2008-12-20.
//

#import "Matrix.h"

@implementation Matrix (MatrixOperations)

- (Matrix*)multiply:(Matrix*)matrix{
	if(columns != matrix.rows){
		return nil;
	}
	NSUInteger mColumns = matrix.columns;
	Matrix* matris = [Matrix matrixWithRows:rows columns:mColumns];
	double* dataArg = matrix.elements;
	double* dataResult = matris.elements;
	for(NSUInteger i = 0; i < rows; i++)
	{
		for(NSUInteger j = 0; j < mColumns; j++)
		{
			double sum = 0.0;
			for(NSUInteger k = 0; k < columns; k++)
				sum += elements[i*columns+k] * dataArg[k*mColumns+j];
			dataResult[i*mColumns+j] = sum;
		}
	}
	return matris;
}

- (double)determinant
{
	if(rows != columns)
		return 0.0;
	
	double summa = 0.0;
	
	switch(rows){
	case 1:
		return elements[0];
	case 2:
		return elements[0]*elements[3] - elements[1]*elements[2];
	default:
		for(NSUInteger i = 0; i < columns; i++){
			Matrix* matris = [[Matrix alloc] initWithMatrix:self byRemovingRow:0 column:i];
			if(i%2 == 0)
				summa += elements[i]*[matris determinant];
			else
				summa -= elements[i]*[matris determinant];
			[matris release];
		}
		break;
	}
	return summa;
}

- (Matrix*)inverse
{
	double det = [self determinant];
	if(det == 0.0)
		return nil;
	if(rows == 1){
		double value = elements[0]/det;
		return [Matrix matrixWithElements:&value rows:1 columns:1];
	}
	Matrix*  matris = [[Matrix alloc] initWithRows:rows columns:columns];
	double* data = matris.elements;
		
	for(NSUInteger i = 0; i < rows; i++){
		for(NSUInteger j = 0; j < columns; j++){
			Matrix* subdet = [Matrix matrixWithMatrix:self byRemovingRow:i column:j];
			if((i+j)%2 == 0)
				data[i*rows+j] = [subdet determinant]/det;
			else
				data[i*rows+j] = -[subdet determinant]/det;
		}
	}
	Matrix* trans = [matris transpose];
	return trans;
}

- (Matrix*)transpose
{
	double buffer[columns*rows];
	for(NSUInteger i = 0; i < rows; i++){
		for(NSUInteger j = 0; j < columns; j++)
			buffer[j*rows+i] = elements[i*columns+j];
	}
	Matrix* result = [Matrix matrixWithElements:buffer rows:columns columns:rows];
	return result;
}

@end