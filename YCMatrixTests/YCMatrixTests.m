//
//  YCMatrixTests.m
//  YCMatrixTests
//
//  Created by Yan Const on 11/7/13.
//  Copyright (c) 2013 Ioannis Chatzikonstantinou. All rights reserved.
//

#import "YCMatrixTests.h"

@implementation YCMatrixTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    TitleNSLog(@"Matrix Unit Tests");
}

- (void)tearDown
{
    // Tear-down code here.
    TitleNSLog(@"End Of Matrix Unit Tests");
    [super tearDown];
}

- (void)testExample
{
    //
    // Array Test
    //
    TitleNSLog(@"Simple Array Test");
    double simple_array[9] = { 1.0, 2.0, 3.0,
        4.0, 5.0, 6.0,
        7.0, 8.0, 9.0 };
    YCMatrix *simple_matrix = [YCMatrix matrixFromArray:simple_array Rows:3 Columns:3];
    CleanNSLog(@"%@",simple_matrix);
    
    // Perform various get item tests
    TitleNSLog(@"Get Items Test");
    CleanNSLog(@"Value at 0,0: %f",[simple_matrix getValueAtRow:0 Column:0]);
    CleanNSLog(@"Value at 1,1: %f",[simple_matrix getValueAtRow:1 Column:1]);
    CleanNSLog(@"Value at 2,1: %f",[simple_matrix getValueAtRow:2 Column:1]);
    CleanNSLog(@"Value at 1,2: %f",[simple_matrix getValueAtRow:1 Column:2]);
    CleanNSLog(@"Value at 2,2: %f",[simple_matrix getValueAtRow:2 Column:2]);
    STAssertTrue([simple_matrix getValueAtRow:0 Column:0] == 1.0, @"GetValue error!");
    STAssertTrue([simple_matrix getValueAtRow:1 Column:0] == 4.0, @"GetValue error!");
    STAssertTrue([simple_matrix getValueAtRow:2 Column:0] == 7.0, @"GetValue error!");
    STAssertTrue([simple_matrix getValueAtRow:0 Column:1] == 2.0, @"GetValue error!");
    STAssertTrue([simple_matrix getValueAtRow:0 Column:2] == 3.0, @"GetValue error!");
    STAssertTrue([simple_matrix getValueAtRow:2 Column:1] == 8.0, @"GetValue error!");
    
    //
    // Identity Matrix
    //
    TitleNSLog(@"Identity Matrix Test");
    YCMatrix *idm1 = [YCMatrix identityOfRows:3 Columns:5];
    CleanNSLog(@"%@",idm1);
    YCMatrix *idm2 = [YCMatrix identityOfRows:6 Columns:4];
    CleanNSLog(@"%@",idm2);
    
    //
    // Addition and Scalar Multiplication
    //
    TitleNSLog(@"Addition and Scalar Multiplication");
    double matrix_array[9] = { 1.0, 2.0, 3.0,
        4.0, 5.0, 6.0,
        7.0, 8.0, 9.0 };
    YCMatrix *testm1 = [YCMatrix matrixFromArray:matrix_array Rows:3 Columns:3];
    YCMatrix *testm2 = [YCMatrix matrixFromMatrix:testm1];
    YCMatrix *testm_add = [testm1 addWith:testm2];
    YCMatrix *testm_ms = [testm1 multiplyWithScalar:2];
    STAssertTrue([testm_ms isEqual: testm_add], @"M+M != 2*M");
    
    //
    // Matrix Multiplication
    //
    TitleNSLog(@"Matrix Multiplication");
    CleanNSLog(@"Test Matrix 1: %ix%i",testm1->rows, testm1->columns);
    CleanNSLog(@"Test Matrix 2: %ix%i",testm2->rows, testm2->columns);
    YCMatrix *multResult = [testm1 multiplyWithRight:testm2];
    CleanNSLog(@"Resulting Matrix: %ix%i",multResult->rows, multResult->columns);
    CleanNSLog(@"%@",multResult);
    
    //
    // Transposition
    //
    TitleNSLog(@"Transposition");
    double matrix_orig_arr[6] = { 1.0, 2.0, 3.0,
        4.0, 5.0, 6.0 };
    double matrix_trans_arr[6] = { 1.0, 4.0,
        2.0, 5.0,
        3.0, 6.0 };
    YCMatrix *orig = [YCMatrix matrixFromArray:matrix_orig_arr Rows:2 Columns:3];
    YCMatrix *trans = [YCMatrix matrixFromArray:matrix_trans_arr Rows:3 Columns:2];
    YCMatrix *trans2 = [orig transpose];
    CleanNSLog(@"%@",orig);
    CleanNSLog(@"%@",trans);
    CleanNSLog(@"%@",trans2);
    STAssertTrue([trans isEqual: trans2], @"M^T != Mt");
    
    //
    // Trace
    //
    TitleNSLog(@"Trace");
    YCMatrix *tracetestm = [YCMatrix matrixFromArray:matrix_array Rows:3 Columns:3];
    double trace = [[tracetestm multiplyWithRight:tracetestm] trace];
    CleanNSLog(@"%f",trace);
    STAssertEquals(trace, 261.000, @"Trace is not correct!");
    
    //
    // Dot
    //
    TitleNSLog(@"Dot Product");
    double vectorarray[3] = { 1.0, 2.0, 3.0 };
    YCMatrix *Vector = [YCMatrix matrixFromArray:vectorarray Rows:3 Columns:1];
    double dotp = [Vector dotWith:Vector];
    CleanNSLog(@"Dot Product: %f",dotp);
    
    //
    // Pseudo-Inverse
    //
    TitleNSLog(@"Pseudo Inverse");
    double pinv_orig_array[4] = { 1.0, 2.0,
        3.0, 4.0};
    YCMatrix *po = [YCMatrix matrixFromArray:pinv_orig_array Rows:2 Columns:2];
    YCMatrix *poi = [po pseudoInverse];
    CleanNSLog(@"Original: %ix%i",po->rows, po->columns);
    CleanNSLog(@"%@",po);
    CleanNSLog(@"PseudoInverse: %ix%i",poi->rows, poi->columns);
    CleanNSLog(@"%@",poi);
    
    double pinv_orig_array2[6] = { 1.0, 2.0,
        3.0, 4.0, 5.0, 6.0};
    YCMatrix *po2 = [YCMatrix matrixFromArray:pinv_orig_array2 Rows:3 Columns:2];
    YCMatrix *poi2 = [po2 pseudoInverse];
    CleanNSLog(@"Original: %ix%i",po2->rows, po2->columns);
    CleanNSLog(@"%@",po2);
    CleanNSLog(@"PseudoInverse: %ix%i",poi2->rows, poi2->columns);
    CleanNSLog(@"%@",poi2);
    
}

@end