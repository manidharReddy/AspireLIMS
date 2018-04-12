//
//  ALTest.m
//  AspireLIMS
//
//  Created by ihub on 10/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALTest.h"

@implementation ALTest
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        ALTest*test = (ALTest*)other;
        return [self.testid isEqual:test.testid] &&
        [self.testname isEqual:test.testname]  &&
        [self.departmentid isEqual:test.departmentid]  &&
        [self.departmentname isEqual:test.departmentname]  &&
        [self.testunits isEqual:test.testunits]  &&
        [self.testdate isEqual:test.testdate]  &&
        [self.testminvalue isEqual:test.testminvalue]  &&
        [self.testmaxvalue isEqual:test.testmaxvalue]  &&
        [self.testresultvalue isEqual:test.testresultvalue]  &&
        [self.testcriticallowvalue isEqual:test.testcriticallowvalue]  &&
        [self.testcriticalhighvalue isEqual:test.testcriticalhighvalue]  &&
        [self.type isEqual:test.type]  &&
        [self.isentered isEqual:test.isentered]  &&
        [self.testdatesplit isEqual:test.testdatesplit]  &&
        [self.testtimesplit isEqual:test.testtimesplit]  &&
        [self.testranges isEqual:test.testranges] &&
        [self.isrepeated isEqual:test.isrepeated] ;
    }
}


- (NSUInteger)hash
{
    return self.testid.hash +
    self.testname.hash +
    self.departmentid.hash +
    self.departmentname.hash +
    self.testunits.hash +
    self.testdate.hash +
    self.testminvalue.hash +
    self.testmaxvalue.hash +
    self.testresultvalue.hash +
    self.testcriticallowvalue.hash +
    self.testcriticalhighvalue.hash +
    self.type .hash +
    self.isentered .hash +
    self.testdatesplit.hash +
    self.testtimesplit.hash +
    self.testranges.hash +
    self.isrepeated.hash;
}
@end
