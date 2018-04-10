//
//  ALGroup.m
//  AspireLIMS
//
//  Created by ihub on 10/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALGroup.h"
static ALGroup *sharedALGroupInstance = nil;
@implementation ALGroup
+(ALGroup*)getSharedInstance{
    if (!sharedALGroupInstance) {
        sharedALGroupInstance = [[super allocWithZone:NULL]init];
        [sharedALGroupInstance allocate];
    }
    return sharedALGroupInstance;
}
-(void)allocate{
   // self.tests = [NSDictionary new];
}
@end
