//
//  ALRecentActivity.m
//  AspireLIMS
//
//  Created by ihub on 13/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALRecentActivity.h"

@implementation ALRecentActivity
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.activityId forKey:@"activityId"];
    [encoder encodeObject:self.activityType forKey:@"activityType"];
    [encoder encodeObject:self.appointmentDate forKey:@"appointmentDate"];
    [encoder encodeObject:self.appointmentTime forKey:@"appointmentTime"];
    [encoder encodeObject:self.patientOrderServices forKey:@"patientOrderServices"];
    [encoder encodeObject:self.appointmentStatus forKey:@"appointmentStatus"];
    [encoder encodeObject:self.appointmentServices forKey:@"appointmentServices"];
    [encoder encodeObject:self.latitute forKey:@"latitute"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.activityId = [decoder decodeObjectForKey:@"activityId"];
    self.activityType = [decoder decodeObjectForKey:@"activityType"];
    self.appointmentDate = [decoder decodeObjectForKey:@"appointmentDate"];
    self.appointmentTime = [decoder decodeObjectForKey:@"appointmentTime"];
    self.patientOrderServices = [decoder decodeObjectForKey:@"patientOrderServices"];
    self.appointmentStatus = [decoder decodeObjectForKey:@"appointmentStatus"];
    self.appointmentServices = [decoder decodeObjectForKey:@"appointmentServices"];
    self.latitute = [decoder decodeObjectForKey:@"latitute"];
    self.longitude = [decoder decodeObjectForKey:@"longitude"];
    self.name = [decoder decodeObjectForKey:@"name"];
    return self;
    
}

@end
