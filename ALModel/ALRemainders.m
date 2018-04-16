//
//  ALRemainders.m
//  AspireLIMS
//
//  Created by ihub on 21/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALRemainders.h"

@implementation ALRemainders
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.apptmtId forKey:@"apptmtId"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.appointmentDate forKey:@"appointmentDate"];
    [encoder encodeObject:self.appointmentTime forKey:@"appointmentTime"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.latitute forKey:@"latitute"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
 
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.apptmtId = [decoder decodeObjectForKey:@"apptmtId"];
    self.name = [decoder decodeObjectForKey:@"name"];
    self.appointmentDate = [decoder decodeObjectForKey:@"appointmentDate"];
    self.appointmentTime = [decoder decodeObjectForKey:@"appointmentTime"];
    self.status = [decoder decodeObjectForKey:@"status"];
    self.latitute = [decoder decodeObjectForKey:@"latitute"];
    self.longitude = [decoder decodeObjectForKey:@"longitude"];
    
    return self;
    
}


@end
