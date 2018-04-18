//
//  IMIHLTest.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 27/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLTest.h"

@implementation IMIHLTest
-(void)allocObjects{
    self.testid_arr = [[NSMutableArray alloc]init];
    self.testname_arr = [[NSMutableArray alloc]init];
    self.tmptestdict = [[NSMutableDictionary alloc]init];
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.testid_arr forKey:@"testid_arr"];
     [encoder encodeObject:self.testname_arr forKey:@"testname_arr"];
     [encoder encodeObject:self.tmptestdict forKey:@"tmptestdict"];
    
    
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.testid_arr = [decoder decodeObjectForKey:@"testid_arr"];
     self.testname_arr = [decoder decodeObjectForKey:@"testname_arr"];
     self.tmptestdict = [decoder decodeObjectForKey:@"tmptestdict"];
    
    
    return self;
    
}
-(IMIHLTest*)getDepartmentTestsResult:(NSDictionary*)responseresult{
    
    //NSLog(@"getDepartment Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    [self allocObjects];
    
    for (NSDictionary*localdict in responseresult) {
        
        //NSLog(@"localdict:%@",localdict);
        
        //Test Id
        NSString*testid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceId"]];
        if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqualToString:@"<null>"]||[testid_str isEqual:[NSNull null]])
        {
            //NSLog(@"testid_str is :%@",testid_str);
            testid_str=@"not available";
        }else{
            
        }
        //NSLog(@"testid_str:%@",testid_str);
        [self.testid_arr addObject:testid_str];
    
        //Test name
        NSString*testname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceName"]];
        if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqualToString:@"<null>"]||[testid_str isEqual:[NSNull null]])
        {
            //NSLog(@"testname_str is :%@",testname_str);
            testname_str=@"not available";
        }else{
            
        }
        //NSLog(@"testname_str:%@",testname_str);
        
        [self.testname_arr addObject:testname_str];

        //Test price
        NSString*testprice_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceName"]];
        if ([testprice_str isEqualToString:@""]||[testprice_str isEqualToString:@"(null)"]||testprice_str==nil||testprice_str==NULL||[testprice_str isEqualToString:@"<null>"]||[testid_str isEqual:[NSNull null]])
        {
            //NSLog(@"testprice_str is :%@",testprice_str);
            testprice_str=@"not available";
        }else{
            
        }
        //NSLog(@"testprice_str:%@",testprice_str);
        [self.tesprice_arr addObject:testprice_str];
        [self.tmptestdict setObject:testid_str forKey:testname_str];
    }
    return self;
}

@end
