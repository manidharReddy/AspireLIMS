//
//  IMIHDDepartments.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 27/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHDDepartments.h"

@implementation IMIHDDepartments
-(void)allocObjects{
    self.deptid_arr = [[NSMutableArray alloc]init];
    self.deptname_arr = [[NSMutableArray alloc]init];
}
-(IMIHDDepartments*)getDepartmentResult:(NSDictionary*)responseresult{
    [self allocObjects];
    //NSLog(@"getDepartment Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    for (NSDictionary*localdict in responseresult) {
        
        //NSLog(@"localdict:%@",localdict);
        
        //Dept Id
        NSString*deptid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"subDept_Id"]];
        if ([deptid_str isEqualToString:@""]||[deptid_str isEqualToString:@"(null)"]||deptid_str==nil||deptid_str==NULL||[deptid_str isEqualToString:@"<null>"])
        {
            //NSLog(@"deptid_str is :%@",deptid_str);
            deptid_str=@"not available";
        }else{
            
        }
        //NSLog(@"deptid_str:%@",deptid_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.deptid_arr addObject:deptid_str];
        
        //Dept name
        NSString*deptname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"subDept_Name"]];
        if ([deptname_str isEqualToString:@""]||[deptname_str isEqualToString:@"(null)"]||deptname_str==nil||deptname_str==NULL||[deptname_str isEqualToString:@"<null>"])
        {
            //NSLog(@"deptname_str is :%@",deptname_str);
            deptname_str=@"not available";
        }else{
            
        }
        //NSLog(@"deptname_str:%@",deptname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.deptname_arr addObject:deptname_str];
        
        
    }
    //NSLog(@"self.deptid_arr:%@",self.deptid_arr);
    return self;
}

@end
