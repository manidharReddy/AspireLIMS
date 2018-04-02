//
//  IMIHDoctorSpecialities.m
//  iMediHubLIMS
//
//  Created by ihub on 12/21/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHDoctorSpecialities.h"

@implementation IMIHDoctorSpecialities
-(void)allocObjects{
    self.deptid_arr = [[NSMutableArray alloc]init];
    self.specialityname_arr = [[NSMutableArray alloc]init];
}
-(IMIHDoctorSpecialities*)getSpecialitesResult:(NSDictionary*)responseresult{
    [self allocObjects];
    //NSLog(@"getDepartment Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    for (NSDictionary*localdict in responseresult) {
        
        //NSLog(@"doctor specialities:%@",localdict);
        
        //Dept Id
        NSString*deptid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"deptid"]];
        if ([deptid_str isEqualToString:@""]||[deptid_str isEqualToString:@"(null)"]||deptid_str==nil||deptid_str==NULL||[deptid_str isEqualToString:@"<null>"])
        {
            //NSLog(@"deptid_str  doctoris :%@",deptid_str);
            deptid_str=@"";
        }else{
            
        }
        //NSLog(@"deptid_str doctor:%@",deptid_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.deptid_arr addObject:deptid_str];
        
        //Dept name
        NSString*spcialityname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"sDescription"]];
        if ([spcialityname_str isEqualToString:@""]||[spcialityname_str isEqualToString:@"(null)"]||spcialityname_str==nil||spcialityname_str==NULL||[spcialityname_str isEqualToString:@"<null>"] || [spcialityname_str isEqual:[NSNull null]])
        {
            //NSLog(@"spcialityname_str is :%@",spcialityname_str);
            spcialityname_str=@"not available";
        }else{
            
        }
        //NSLog(@"spcialityname_str:%@",spcialityname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.specialityname_arr addObject:spcialityname_str];
        
        
    }
    //NSLog(@"self.deptid_arr doctor:%@",self.deptid_arr);
    return self;
}

@end
