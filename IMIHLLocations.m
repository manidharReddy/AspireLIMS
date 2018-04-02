//
//  IMIHLLocations.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 22/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLLocations.h"

@implementation IMIHLLocations
-(void)allocObjects{
    self.locatid_arr = [[NSMutableArray alloc]init];
    self.locatname_arr = [[NSMutableArray alloc]init];
}
-(IMIHLLocations*)getLocationResult:(NSDictionary*)responseresult{
    [self allocObjects];
    //NSLog(@"getLocations Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    for (NSDictionary*localdict in responseresult) {
        
        //NSLog(@"localdict:%@",localdict);
        
        //location Id
        NSString*id_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"id"]];
        if ([id_str isEqualToString:@""]||[id_str isEqualToString:@"(null)"]||id_str==nil||id_str==NULL||[id_str isEqualToString:@"<null>"])
        {
            //NSLog(@"id_str is :%@",id_str);
            id_str=@"";
        }else{
            
        }
        //NSLog(@"id_str:%@",id_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.locatid_arr addObject:id_str];
        
        //Dept name
        NSString*loccationname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"name"]];
        if ([loccationname_str isEqualToString:@""]||[loccationname_str isEqualToString:@"(null)"]||loccationname_str==nil||loccationname_str==NULL||[loccationname_str isEqualToString:@"<null>"])
        {
            //NSLog(@"loccationname_str is :%@",loccationname_str);
            loccationname_str=@"";
        }else{
            
        }
        //NSLog(@"loccationname_str:%@",loccationname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.locatname_arr addObject:loccationname_str];
        
        
    }
    //NSLog(@"self.locationid_arr:%@",self.locatid_arr);
    return self;
}

@end
