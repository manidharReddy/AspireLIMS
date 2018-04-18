//
//  ALAppointments.m
//  AspireLIMS
//
//  Created by Aparna Reddy Challa on 17/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALAppointments.h"

@implementation ALAppointments
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.apointmentId forKey:@"apointmentId"];
    [encoder encodeObject:self.deptId forKey:@"deptId"];
    [encoder encodeObject:self.testId forKey:@"testId"];
    [encoder encodeObject:self.testName forKey:@"testName"];
    [encoder encodeObject:self.deptName forKey:@"deptName"];
    [encoder encodeObject:self.bookedTime forKey:@"bookedTime"];
    [encoder encodeObject:self.bookedDate forKey:@"bookedDate"];
    [encoder encodeObject:self.status forKey:@"status"];
  
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.apointmentId = [decoder decodeObjectForKey:@"apointmentId"];
    self.deptId = [decoder decodeObjectForKey:@"deptId"];
    self.testId = [decoder decodeObjectForKey:@"testId"];
    self.testName = [decoder decodeObjectForKey:@"testName"];
    self.deptName = [decoder decodeObjectForKey:@"deptName"];
    self.bookedTime = [decoder decodeObjectForKey:@"bookedTime"];
    self.bookedDate = [decoder decodeObjectForKey:@"bookedDate"];
    self.status = [decoder decodeObjectForKey:@"status"];
    
    
    return self;
    
}
@end
