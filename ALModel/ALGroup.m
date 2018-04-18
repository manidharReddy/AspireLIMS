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

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        ALGroup*group = (ALGroup*)other;
        return [self.groupName isEqual:group.groupName] && [self.groupDate isEqual:group.groupDate] && [self.groupTime isEqual:group.groupTime];
    }
}

- (NSUInteger)hash
{
    return self.groupName.hash+self.groupTime.hash+self.groupDate.hash;
}
@end
