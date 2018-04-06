//
//  ALUserLogin.m
//  AspireLIMS
//
//  Created by ihub on 06/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALUserLogin.h"

@implementation ALUserLogin
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.userid forKey:@"userid"];
    [encoder encodeObject:self.password forKey:@"password"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.userid = [decoder decodeObjectForKey:@"userid"];
    self.password = [decoder decodeObjectForKey:@"password"];
    return self;

}
@end
