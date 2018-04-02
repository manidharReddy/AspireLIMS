//
//  IMIHLSearchResults.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 01/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLSearchResults.h"

@implementation IMIHLSearchResults
-(void)allocateArray{
    self.testid_arr = [[NSMutableArray alloc]init];
    self.testname_arr = [[NSMutableArray alloc]init];
    self.departmentid_arr = [[NSMutableArray alloc]init];
    self.testunits_arr = [[NSMutableArray alloc]init];
    self.departmentname_arr = [[NSMutableArray alloc]init];
    self.testdate_arr = [[NSMutableArray alloc]init];
    self.testminvalue_arr = [[NSMutableArray alloc]init];
    self.testmaxvalue_arr = [[NSMutableArray alloc]init];
    self.testresultvalue_arr = [[NSMutableArray alloc]init];
    self.testcriticallowvalue_arr = [[NSMutableArray alloc]init];
    self.testcriticalhighvalue_arr = [[NSMutableArray alloc]init];
    self.type_arr = [[NSMutableArray alloc]init];
    self.isentered_arr = [[NSMutableArray alloc]init];
    
    
    self.testdate_arr = [[NSMutableArray alloc]init];
    self.testdatesplit_arr = [[NSMutableArray alloc]init];
    self.testranges_arr = [[NSMutableArray alloc]init];
    self.isrepeated_arr = [[NSMutableArray alloc]init];
    
    
    
    self.serviceid_arr = [[NSMutableArray alloc]init];
    self.servicename_arr = [[NSMutableArray alloc]init];
}


-(IMIHLSearchResults*)getSearchServiceResult:(NSDictionary*)responseresult{
    
    [self allocateArray];
    
    
    for (NSDictionary*localdict in responseresult) {
        //NSLog(@"localdict:%@",localdict);
        
        
        
        //Test Id
        NSString*testid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceId"]];
        if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]])
        {
            //NSLog(@"testid is :%@",testid_str);
            testid_str=@"";
        }else{
            
        }
        //NSLog(@"testid_str:%@",testid_str);
        [self.serviceid_arr addObject:testid_str];
        
        //Test Names
        NSString*testname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceName"]];
        if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]])
        {
            //NSLog(@"testname_str is :%@",testname_str);
            testname_str=@"";
        }else{
            
        }
        
        //NSLog(@"testname_str:%@",testname_str);
        [self.servicename_arr addObject:testname_str];
    }


    return self;
}

-(IMIHLSearchResults*)getReportResult:(NSDictionary*)responseresult{
    
    [self allocateArray];
    
    //int grp,pnl;
    for (NSDictionary*localdict in responseresult) {
        //NSLog(@"localdict:%@",localdict);
        
            
        // NSDictionary*sublocal_dict = [localdict objectForKey:@"data"];
        NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
        //NSLog(@"type_str:%@",type_str);
        [self.type_arr addObject:type_str];
        
        NSDictionary*datakeydict = [localdict objectForKey:@"data"];
        
        //NSLog(@"datakeydict1:%@",datakeydict);
        //if ([datakeydict objectForKey:@"isEntered"]==false) {
        
        //}else{
        NSArray*arrytestdict =nil;
        if ([type_str isEqualToString:@"1"]) {
            arrytestdict=[datakeydict objectForKey:@"dateWaseReportResForTests"];
        }else if ([type_str isEqualToString:@"2"]){
            //NSLog(@"entred in else");
            
            NSArray*tmparr = [datakeydict objectForKey:@"dateWaseReportResForGroups"];
            NSDictionary*maindatakeydict=[tmparr objectAtIndex:0];
            //NSLog(@"entred in else:%@",[maindatakeydict objectForKey:@"data"]);
            
            NSDictionary*localdatakeydict = [maindatakeydict objectForKey:@"data"];
            //NSLog(@"localdatakeydict:%@",localdatakeydict);
            arrytestdict=[localdatakeydict objectForKey:@"dateWaseReportResForTests"];
            //NSLog(@"entred in else arryyyy:%@",arrytestdict);
        
        }else if ([type_str isEqualToString:@"3"]){
        arrytestdict=[datakeydict objectForKey:@"dateWaseReportResForTests"];
        }
        
        
        if (arrytestdict.count!=0) {
            
        
        datakeydict = [arrytestdict objectAtIndex:0];
        
        //Test Id
        NSString*testid_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"serviceId"]];
        if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]])
        {
            //NSLog(@"testid is :%@",testid_str);
            testid_str=@"";
        }else{
            
        }
        //NSLog(@"testid_str:%@",testid_str);
        [self.testid_arr addObject:testid_str];
        
        //Test Names
        NSString*testname_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"serviceName"]];
        if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]])
        {
            //NSLog(@"testname_str is :%@",testname_str);
            testname_str=@"";
        }else{
            
        }
        
        //NSLog(@"testname_str:%@",testname_str);
        [self.testname_arr addObject:testname_str];
        
        //Test Department Ids
        NSString*testdepart_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"deptId"]];
        if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]])
        {
            //NSLog(@"testdepart_str is :%@",testdepart_str);
            testdepart_str=@"";
        }else{
            
        }
        //NSLog(@"testdepart_str:%@",testdepart_str);
        [self.departmentid_arr addObject:testdepart_str];
        
        //Test Department Name
        NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"depatName"]];
        if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]])
        {
            //NSLog(@"testdepartname_str is :%@",testdepartname_str);
            testdepartname_str=@"";
        }else{
            
        }
        //NSLog(@"testdepartname_str:%@",testdepartname_str);
        [self.departmentname_arr addObject:testdepartname_str];
        
        
        
        
        //Test Date
        
        
        NSString*testdate_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"testDate"]];
        if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]])
        {
            //NSLog(@"testdate_str is :%@",testdate_str);
            testdate_str=@"";
        }else{
            
        }
        //NSLog(@"testdate_str:%@",testdate_str);
        [self.testdate_arr addObject:testdate_str];
        
        NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
        //NSLog(@"Array values are : %@",arr);
        NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
        [self.testdatesplit_arr addObject:[arr objectAtIndex:0]];
        [self.testtimesplit_arr addObject:strtime];
        
        
        
        
        //Test isEntered
        
        
        
        NSString*isentredstr = [NSString stringWithFormat:@"%d",[[datakeydict objectForKey:@"isEntered"]intValue]];
        [self.isentered_arr addObject:isentredstr];
        
        
        
        //Test Min Value
        NSString*testminvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"lowValue"]];
        if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]])
        {
            //NSLog(@"testminvalue_str is :%@",testminvalue_str);
            testminvalue_str=@"";
        }else{
            
        }
        //NSLog(@"testminvalue_str:%@",testminvalue_str);
        [self.testminvalue_arr addObject:testminvalue_str];
        
        //Test Max Value
        NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"highValue"]];
        if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]])
        {
            //NSLog(@"testmaxvalue_str is :%@",testmaxvalue_str);
            testmaxvalue_str=@"";
        }else{
            
        }
        //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
        [self.testmaxvalue_arr addObject:testmaxvalue_str];
        
        
        NSString*testrange_str  = [NSString stringWithFormat:@"%@><%@",testminvalue_str,testmaxvalue_str];
        
        [self.testranges_arr addObject:testrange_str];
        
        
        //Test Result Value
        NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"testResult"]];
        if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]])
        {
            //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
            testresultvalue_str=@"";
        }else{
            
        }
        
        [self.testresultvalue_arr addObject:testresultvalue_str];
        
        //Test Units
        NSString*testunits_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"uom"]];
        if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]])
        {
            //NSLog(@"testunits_str is :%@",testunits_str);
            testunits_str=@"not available";
        }else{
            
        }
        
        
        //NSLog(@"testunits_str:%@",testunits_str);
        [self.testunits_arr addObject:testunits_str];
        
        //Test Critical Low Value
        NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"lowCritical"]];
        if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]])
        {
            //NSLog(@"testcriticallowvalue_str is :%@",testcriticallowvalue_str);
            testcriticallowvalue_str=@"not available";
        }else{
            
        }
        //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
        [self.testcriticallowvalue_arr addObject:testcriticallowvalue_str];
        
        //Test Critical Hight Value
        NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"highCritical"]];
        if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]])
        {
            //NSLog(@"testcriticalhighvalue_str is :%@",testcriticalhighvalue_str);
            testcriticalhighvalue_str=@"not available";
        }else{
            
        }
        //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
        [self.testcriticalhighvalue_arr addObject:testcriticalhighvalue_str];
        // }
            
        }else{
        
        }
        
    }
    
    return self;

}



@end
