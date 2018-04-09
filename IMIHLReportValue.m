//
//  IMIHLReportValue.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 21/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLReportValue.h"
#import "IMIHLDBManager.h"
@implementation IMIHLReportValue


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
    self.groupttestobj_arr = [[NSMutableArray alloc]init];
    self.panelgroupobj_arr = [[NSMutableArray alloc]init];
    self.paneltestobj_arr = [[NSMutableArray alloc]init];
    self.isentered_arr = [[NSMutableArray alloc]init];
    self.testdatesplit_arr = [[NSMutableArray alloc]init];
    self.testtimesplit_arr = [[NSMutableArray alloc]init];
    self.testranges_arr = [[NSMutableArray alloc]init];
    self.isrepeated_arr = [[NSMutableArray alloc]init];
}
-(void)allocateDictionary{
        self.grouptest_dict = [[NSMutableDictionary alloc]init];
        self.paneltest_dict = [[NSMutableDictionary alloc]init];
        self.panelgroup_dict = [[NSMutableDictionary alloc]init];
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.testid_arr forKey:@"testid_arr"];
    [encoder encodeObject:self.testname_arr forKey:@"testname_arr"];
    [encoder encodeObject:self.departmentid_arr forKey:@"testunits_arr"];
    [encoder encodeObject:self.testunits_arr forKey:@"orderflag_arr"];
    [encoder encodeObject:self.departmentname_arr forKey:@"departmentname_arr"];
    [encoder encodeObject:self.testdate_arr forKey:@"testdate_arr"];
    [encoder encodeObject:self.testminvalue_arr forKey:@"testminvalue_arr"];
    [encoder encodeObject:self.testmaxvalue_arr forKey:@"testmaxvalue_arr"];
    [encoder encodeObject:self.testresultvalue_arr forKey:@"testresultvalue_arr"];
    [encoder encodeObject:self.testcriticallowvalue_arr forKey:@"testcriticallowvalue_arr"];
    [encoder encodeObject:self.testcriticalhighvalue_arr forKey:@"testcriticalhighvalue_arr"];
    [encoder encodeObject:self.type_arr forKey:@"type_arr"];
    [encoder encodeObject:self.groupttestobj_arr forKey:@"groupttestobj_arr"];
    [encoder encodeObject:self.panelgroupobj_arr forKey:@"panelgroupobj_arr"];
    [encoder encodeObject:self.paneltestobj_arr forKey:@"orderservices_dict"];
    [encoder encodeObject:self.isentered_arr forKey:@"isentered_arr"];
    [encoder encodeObject:self.testdatesplit_arr forKey:@"testdatesplit_arr"];
    [encoder encodeObject:self.testtimesplit_arr forKey:@"testtimesplit_arr"];
    [encoder encodeObject:self.testranges_arr forKey:@"testranges_arr"];
    [encoder encodeObject:self.isrepeated_arr forKey:@"isrepeated_arr"];
    
    
    [encoder encodeObject:self.grouptest_dict forKey:@"grouptest_dict"];
    [encoder encodeObject:self.paneltest_dict forKey:@"paneltest_dict"];
    [encoder encodeObject:self.panelgroup_dict forKey:@"panelgroup_dict"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
   self.testid_arr = [decoder decodeObjectForKey:@"testid_arr"];
    self.testname_arr = [decoder decodeObjectForKey:@"testname_arr"];
    self.departmentid_arr = [decoder decodeObjectForKey:@"departmentid_arr"];
    self.testunits_arr = [decoder decodeObjectForKey:@"testunits_arr"];
    self.departmentname_arr = [decoder decodeObjectForKey:@"departmentname_arr"];
    self.testunits_arr = [decoder decodeObjectForKey:@"testunits_arr"];
    self.departmentname_arr = [decoder decodeObjectForKey:@"departmentname_arr"];
    self.testdate_arr = [decoder decodeObjectForKey:@"testdate_arr"];
    self.testminvalue_arr = [decoder decodeObjectForKey:@"testminvalue_arr"];
    self.testmaxvalue_arr = [decoder decodeObjectForKey:@"testmaxvalue_arr"];
    self.testresultvalue_arr = [decoder decodeObjectForKey:@"testresultvalue_arr"];
    self.testcriticallowvalue_arr = [decoder decodeObjectForKey:@"testcriticallowvalue_arr"];
    self.testcriticalhighvalue_arr = [decoder decodeObjectForKey:@"testcriticalhighvalue_arr"];
    self.type_arr = [decoder decodeObjectForKey:@"type_arr"];
    self.groupttestobj_arr = [decoder decodeObjectForKey:@"groupttestobj_arr"];
    self.panelgroupobj_arr = [decoder decodeObjectForKey:@"panelgroupobj_arr"];
    self.paneltestobj_arr = [decoder decodeObjectForKey:@"paneltestobj_arr"];
    self.isentered_arr = [decoder decodeObjectForKey:@"isentered_arr"];
    self.testdatesplit_arr = [decoder decodeObjectForKey:@"testdatesplit_arr"];
    self.testtimesplit_arr = [decoder decodeObjectForKey:@"testtimesplit_arr"];
    self.testranges_arr = [decoder decodeObjectForKey:@"testranges_arr"];
    self.isrepeated_arr = [decoder decodeObjectForKey:@"isrepeated_arr"];
    
    self.grouptest_dict = [decoder decodeObjectForKey:@"grouptest_dict"];
    self.paneltest_dict = [decoder decodeObjectForKey:@"paneltest_dict"];
    self.panelgroup_dict = [decoder decodeObjectForKey:@"panelgroup_dict"];
    
    
    return self;
    
}

-(IMIHLReportValue*)getReportResult:(NSDictionary*)responseresult{
 
    [self allocateArray];
    [self allocateDictionary];
    IMIHLDBManager*testdb = [IMIHLDBManager getSharedInstance];
    
    [testdb deleteGroupTestsInfoDB];
    BOOL issuccess;
    //int grp,pnl;
    for (NSDictionary*localdict in responseresult) {
        //NSLog(@"localdict:%@",localdict);
        
        
        
        //NSLog(@"repeated value:%@",[localdict objectForKey:@"isRepeated"]);
        NSString*isrepeated_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"isRepeated"]];
        if ([isrepeated_str isEqualToString:@""]||[isrepeated_str isEqualToString:@"(null)"]||isrepeated_str==nil||isrepeated_str==NULL||[isrepeated_str isEqual:[NSNull null]]||[isrepeated_str isEqualToString:@"<null>"])
        {
            //NSLog(@"isrepeated_str value :%@",isrepeated_str);
            isrepeated_str=@"0";
        }else{
            
        }
        NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
        //NSLog(@"type_str:%@",type_str);
       
        
        
        if ([[localdict objectForKey:@"type"]intValue]==1) {
            
            //NSLog(@"isrepeated_str:%@",isrepeated_str);
           
           // NSDictionary*sublocal_dict = [localdict objectForKey:@"data"];
           
            
            NSDictionary*datakeydict = [localdict objectForKey:@"data"];
            
            //NSLog(@"datakeydict1:%@",datakeydict);
            //if ([datakeydict objectForKey:@"isEntered"]==false) {
                
            //}else{
            
            
            
            NSArray*arrytestdict =[datakeydict objectForKey:@"dateWaseReportResForTests"];
            
            if (arrytestdict.count!=0) {
                
             [self.isrepeated_arr addObject:isrepeated_str];
                 [self.type_arr addObject:type_str];
            datakeydict = [arrytestdict objectAtIndex:0];
            
            
        //Test Id
        NSString*testid_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"serviceId"]];
            if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]]||[testid_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testid is :%@",testid_str);
                testid_str=@"";
            }else{
            
            }
        //NSLog(@"testid_str:%@",testid_str);
        [self.testid_arr addObject:testid_str];
        
        //Test Names
        NSString*testname_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"serviceName"]];
            if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]]||[testname_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testname_str is :%@",testname_str);
                testname_str=@"";
            }else{
                
            }
            
        //NSLog(@"testname_str:%@",testname_str);
        [self.testname_arr addObject:testname_str];

        //Test Department Ids
        NSString*testdepart_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"deptId"]];
            if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]]||[testdepart_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testdepart_str is :%@",testdepart_str);
                testdepart_str=@"";
            }else{
                
            }
        //NSLog(@"testdepart_str:%@",testdepart_str);
        [self.departmentid_arr addObject:testdepart_str];
      
        //Test Department Name
        NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"depatName"]];
            if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]]||[testdepartname_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testdepartname_str is :%@",testdepartname_str);
                testdepartname_str=@"";
            }else{
                
            }
        //NSLog(@"testdepartname_str:%@",testdepartname_str);
        [self.departmentname_arr addObject:testdepartname_str];

            
            
            
            //Test Date
            

            NSString*testdate_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"testDate"]];
            if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]]||[testdate_str isEqualToString:@"<null>"])
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
            if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]]||[testminvalue_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testminvalue_str is :%@",testminvalue_str);
                testminvalue_str=@"";
            }else{
                
            }
        //NSLog(@"testminvalue_str:%@",testminvalue_str);
        [self.testminvalue_arr addObject:testminvalue_str];

        //Test Max Value
        NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"highValue"]];
            if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]]||[testmaxvalue_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testmaxvalue_str is :%@",testmaxvalue_str);
                testmaxvalue_str=@"";
            }else{
                
            }
        //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
        [self.testmaxvalue_arr addObject:testmaxvalue_str];
        
            
            NSString*testrange_str  = [NSString stringWithFormat:@"%@<%@>",testminvalue_str,testmaxvalue_str];
            
            [self.testranges_arr addObject:testrange_str];
            
            
        //Test Result Value
        NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"testResult"]];
            if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]]||[testresultvalue_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
                testresultvalue_str=@"";
            }else{
                
            }
            
            [self.testresultvalue_arr addObject:testresultvalue_str];
            
            //Test Units
            NSString*testunits_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"uom"]];
            if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]]||[testunits_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testunits_str is :%@",testunits_str);
                testunits_str=@"not available";
            }else{
                
            }
            
            
        //NSLog(@"testunits_str:%@",testunits_str);
        [self.testunits_arr addObject:testunits_str];

        //Test Critical Low Value
        NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"lowCritical"]];
            if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]]||[testcriticallowvalue_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testcriticallowvalue_str is :%@",testcriticallowvalue_str);
                testcriticallowvalue_str=@"not available";
            }else{
                
            }
        //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
        [self.testcriticallowvalue_arr addObject:testcriticallowvalue_str];

        //Test Critical Hight Value
        NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[datakeydict objectForKey:@"highCritical"]];
            if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]]||[testcriticalhighvalue_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testcriticalhighvalue_str is :%@",testcriticalhighvalue_str);
                testcriticalhighvalue_str=@"not available";
            }else{
                
            }
        //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
        [self.testcriticalhighvalue_arr addObject:testcriticalhighvalue_str];
           // }
            
            [self.groupttestobj_arr addObject:@""];
            [self.paneltestobj_arr addObject:@""];
            [self.panelgroupobj_arr addObject:@""];
            
            
            
            issuccess= [testdb saveGroupTests:[datakeydict objectForKey:@"serviceId"] :[datakeydict objectForKey:@"serviceName"] :type_str :[arr objectAtIndex:0] :strtime :[datakeydict objectForKey:@"deptId"] :[datakeydict objectForKey:@"uom"] :[datakeydict objectForKey:@"depatName"] :[datakeydict objectForKey:@"lowValue"] :[datakeydict objectForKey:@"highValue"] :[datakeydict objectForKey:@"testResult"] :[datakeydict objectForKey:@"lowCritical"] :[datakeydict objectForKey:@"highCritical"] :[[datakeydict objectForKey:@"isEntered"]intValue]];
            
            if (issuccess==YES) {
                //NSLog(@"inserted single tests in db");
            }else{
                //NSLog(@" failed to insert single tests in db");
                
            }
            
            }else{
                //NSLog(@"Type value else");
            }
            
        }else if ([[localdict objectForKey:@"type"]intValue]==2){
            
            //NSLog(@"isrepeated_str:%@",isrepeated_str);
            [self.isrepeated_arr addObject:isrepeated_str];
            //NSLog(@"type2 entered");
            NSDictionary*datakeydict = [localdict objectForKey:@"data"];
            NSArray*arrytestdict =[datakeydict objectForKey:@"dateWaseReportResForGroups"];
            datakeydict = [arrytestdict objectAtIndex:0];
            arrytestdict=nil;
            //datakeydict = [datakeydict objectForKey:@"dateWaseReportResForGroups"];
            
            datakeydict = [datakeydict objectForKey:@"data"];
            
           // NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
            
            [self.type_arr addObject:type_str];

           // NSString*grpname_str = [NSString stringWithFormat:@"%@%d",[datakeydict objectForKey:@"groupName"],grp];
            [self.testname_arr addObject:[datakeydict objectForKey:@"groupName"]];
            //[self.grouptest_dict setObject:[datakeydict objectForKey:@"dateWaseReportResForTests"] forKey:[datakeydict objectForKey:@"groupName"]];
            
            //NSArray*arrytestdictgrp =[datakeydict objectForKey:@"dateWaseReportResForTests"];
            //datakeydict = [arrytestdictgrp objectAtIndex:0];
            NSDictionary*tempdict = [NSDictionary dictionaryWithObject:[datakeydict objectForKey:@"dateWaseReportResForTests"] forKey:[datakeydict objectForKey:@"groupName"]];
            
            [self.groupttestobj_arr addObject:tempdict];
            //NSLog(@"tempdict:%@",tempdict);
            
            
            NSDictionary*tempdbdict = [tempdict objectForKey:[datakeydict objectForKey:@"groupName"]];
            int isentred = 0,enteredvalue = 0;
            NSString*strdatemut = [[NSString alloc]init];
             NSString*strtimemut = [[NSString alloc]init];;
            for (NSDictionary*testsdict in tempdbdict) {
                //NSLog(@"testsdict:%@",testsdict);
                NSString*testdate_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"testDate"]];
                if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]]||[testdate_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testdate_str is :%@",testdate_str);
                    testdate_str=@"";
                }else{
                    
                }
                
                //NSLog(@"testdate_str:%@",testdate_str);
                
                
                NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
                //NSLog(@"Array values are : %@",arr);
                NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
                //NSLog(@"date set:%@ Time Set:%@",strdatemut,strtimemut);
                if ([strdatemut isEqualToString:@""]) {
                    strdatemut = [arr objectAtIndex:0];
                    strtimemut = strtime;
                }else{
                    
                }

                if (isentred==0) {
                    
                
                NSString*isentred_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"isEntered"]];
                if ([isentred_str isEqualToString:@""]||[isentred_str isEqualToString:@"(null)"]||isentred_str==nil||isentred_str==NULL||[isentred_str isEqual:[NSNull null]]||[isentred_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"isentred_str is :%@",isentred_str);
                    isentred_str=@"";
                }else{
                    
                }
                    if ([isentred_str isEqualToString:@"1"]) {
                        enteredvalue=1;
                    }else if ([isentred_str isEqualToString:@"0"]){
                        enteredvalue=0;
                    }
                //NSLog(@"isentred_str:%@",isentred_str);
                
                }else{
                    isentred=1;
                }
                
            issuccess= [testdb saveGroupTests:[testsdict objectForKey:@"serviceId"] :[testsdict objectForKey:@"serviceName"] :@"1" :[arr objectAtIndex:0] :strtime :[testsdict objectForKey:@"deptId"] :[testsdict objectForKey:@"uom"] :[testsdict objectForKey:@"depatName"] :[testsdict objectForKey:@"lowValue"] :[testsdict objectForKey:@"highValue"] :[testsdict objectForKey:@"testResult"] :[testsdict objectForKey:@"lowCritical"] :[testsdict objectForKey:@"highCritical"] :[[testsdict objectForKey:@"isEntered"]intValue]];
                
                if (issuccess==YES) {
                    //NSLog(@"inserted tests in db");
                }else{
                //NSLog(@" failed to insert tests in db");
                
                }
            
            }
            
            //NSLog(@"isEnteredStr:%d",(int)enteredvalue);
            [self.testid_arr addObject:@""];
            [self.departmentid_arr addObject:@""];
            [self.departmentname_arr addObject:@""];
            [self.testdate_arr addObject:@""];
            
            [self.isentered_arr addObject:[NSString stringWithFormat:@"%d",enteredvalue]];
            
            
            [self.testminvalue_arr addObject:@""];
            [self.testmaxvalue_arr addObject:@""];
            [self.testresultvalue_arr addObject:@""];
            [self.testunits_arr addObject:@""];
            [self.testcriticallowvalue_arr addObject:@""];
            [self.testcriticalhighvalue_arr addObject:@""];
            [self.paneltestobj_arr addObject:@""];
            [self.panelgroupobj_arr addObject:@""];
            [self.testdatesplit_arr addObject:strdatemut];
            [self.testtimesplit_arr addObject:strtimemut];
            
            strdatemut=nil;
            strtimemut=nil;
            //NSLog(@"self.testdatesplistarr:%@",self.testdatesplit_arr);
            //NSLog(@"testtimesplit_arr:%@",self.testtimesplit_arr);
        }else if ([[localdict objectForKey:@"type"]intValue]==3){
            //NSLog(@"type3 entered");
            //NSLog(@"isrepeated_str:%@",isrepeated_str);
            [self.isrepeated_arr addObject:isrepeated_str];
           // NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
            
            [self.type_arr addObject:type_str];

            NSDictionary*datakeydict = [localdict objectForKey:@"data"];
            
            
            
            
            
            
            
            [self.testname_arr addObject:[datakeydict objectForKey:@"panelName"]];
            
            NSDictionary*temppaneltestsdict = [NSDictionary dictionaryWithObject:[datakeydict objectForKey:@"dateWaseReportResForTests"] forKey:[datakeydict objectForKey:@"panelName"]];

            NSDictionary*temppanelgrpsdict = [NSDictionary dictionaryWithObject:[datakeydict objectForKey:@"dateWaseReportResForGroups"] forKey:[datakeydict objectForKey:@"panelName"]];

            
            //////////////////////////////////////////////Panel Single Tests///////////////////////////////////////////
            for (NSDictionary*testsdict in [datakeydict objectForKey:@"dateWaseReportResForTests"]) {
                //NSLog(@"testsdict sibngle tests:%@",testsdict);
                
                // for (NSDictionary*testsdict in  localtestsdict) {
                //    //NSLog(@"testsdict check:%@",testsdict);
                
                // NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
                ////NSLog(@"type_str:%@",type_str);
                // [self.type_arr addObject:type_str];
                
                // NSDictionary*datakeydict = [localdict objectForKey:@"data"];
                // //NSLog(@"datakeydict1:%@",datakeydict);
                //if ([datakeydict objectForKey:@"isEntered"]==false) {
                
                //}else{
                
                //Test Id
                NSString*testid_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"serviceId"]];
                if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]]||[testid_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testid is :%@",testid_str);
                    testid_str=@"";
                }else{
                    
                }
                //NSLog(@"testid_str:%@",testid_str);
                //  [self.testid_arr addObject:testid_str];
                
                //Test Names
                NSString*testname_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"serviceName"]];
                if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]]||[testname_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testname_str is :%@",testname_str);
                    testname_str=@"";
                }else{
                    
                }
                
                //NSLog(@"testname_str:%@",testname_str);
                // [self.testname_arr addObject:testname_str];
                
                //Test Department Ids
                NSString*testdepart_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"deptId"]];
                if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]]||[testdepart_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testdepart_str is :%@",testdepart_str);
                    testdepart_str=@"";
                }else{
                    
                }
                //NSLog(@"testdepart_str group:%@",testdepart_str);
                //[self.departmentid_arr addObject:testdepart_str];
                
                //Test Department Name
                NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"depatName"]];
                if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]]||[testdepartname_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testdepartname_str is :%@",testdepartname_str);
                    testdepartname_str=@"";
                }else{
                    
                }
                //NSLog(@"testdepartname_str group:%@",testdepartname_str);
                //  [self.departmentname_arr addObject:testdepartname_str];
                
                
                
                
                //Test Date
                
                
                NSString*testdate_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"testDate"]];
                if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]]||[testdate_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testdate_str is :%@",testdate_str);
                    testdate_str=@"";
                }else{
                    
                }
                //NSLog(@"testdate_str:%@",testdate_str);
                // [self.testdate_arr addObject:testdate_str];
                
                NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
                //NSLog(@"Array values are : %@",arr);
                NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
                //[self.testdatesplit_arr addObject:[arr objectAtIndex:0]];
                //[self.testtimesplit_arr addObject:strtime];
                
                
                
                
                //Test isEntered
                
                
                
                //NSString*isentredstr = [NSString stringWithFormat:@"%d",[[testsdict objectForKey:@"isEntered"]intValue]];
                // [self.isentered_arr addObject:isentredstr];
                
                
                
                //Test Min Value
                NSString*testminvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"lowValue"]];
                if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]]||[testminvalue_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testminvalue_str is :%@",testminvalue_str);
                    testminvalue_str=@"";
                }else{
                    
                }
                //NSLog(@"testminvalue_str:%@",testminvalue_str);
                //[self.testminvalue_arr addObject:testminvalue_str];
                
                //Test Max Value
                NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"highValue"]];
                if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]]||[testmaxvalue_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testmaxvalue_str group is :%@",testmaxvalue_str);
                    testmaxvalue_str=@"";
                }else{
                    
                }
                //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
                // [self.testmaxvalue_arr addObject:testmaxvalue_str];
                
                
               // NSString*testrange_str  = [NSString stringWithFormat:@"%@<%@>",testminvalue_str,testmaxvalue_str];
                
                // [self.testranges_arr addObject:testrange_str];
                
                
                //Test Result Value
                NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"testResult"]];
                if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]]||[testresultvalue_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
                    testresultvalue_str=@"";
                }else{
                    
                }
                
                // [self.testresultvalue_arr addObject:testresultvalue_str];
                
                //Test Units
                NSString*testunits_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"uom"]];
                if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]]||[testunits_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testunits_str is :%@",testunits_str);
                    testunits_str=@"";
                }else{
                    
                }
                
                
                //NSLog(@"testunits_str:%@",testunits_str);
                // [self.testunits_arr addObject:testunits_str];
                
                //Test Critical Low Value
                NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"lowCritical"]];
                if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]]||[testcriticallowvalue_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testcriticallowvalue_str group is :%@",testcriticallowvalue_str);
                    testcriticallowvalue_str=@"";
                }else{
                    
                }
                //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
                // [self.testcriticallowvalue_arr addObject:testcriticallowvalue_str];
                
                //Test Critical Hight Value
                NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"highCritical"]];
                if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]]||[testcriticalhighvalue_str isEqualToString:@"<null>"])
                {
                    //NSLog(@"testcriticalhighvalue_str group is :%@",testcriticalhighvalue_str);
                    testcriticalhighvalue_str=@"";
                }else{
                    
                }
                //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
                // [self.testcriticalhighvalue_arr addObject:testcriticalhighvalue_str];
                
                
                issuccess= [testdb saveGroupTests:[testsdict objectForKey:@"serviceId"] :[testsdict objectForKey:@"serviceName"] :[testsdict objectForKey:@"1"] :[arr objectAtIndex:0] :strtime :[testsdict objectForKey:@"deptId"] :[testsdict objectForKey:@"uom"] :[testsdict objectForKey:@"depatName"] :[testsdict objectForKey:@"lowValue"] :[testsdict objectForKey:@"highValue"] :[testsdict objectForKey:@"testResult"] :[testsdict objectForKey:@"lowCritical"] :[testsdict objectForKey:@"highCritical"] :[[testsdict objectForKey:@"isEntered"]intValue]];
                
                if (issuccess==YES) {
                    //NSLog(@"inserted group tests in db");
                }else{
                    //NSLog(@" failed to insert group tests in db");
                    
                }
                
                
                //}
            }
            
            //////////////////////////////////////////////END Single Tests////////////////////////////////////////////
            
            //NSLog(@"panelcheck:%@",[datakeydict objectForKey:@"dateWaseReportResForGroups"]);
    
            for (NSDictionary*grpdict in [datakeydict objectForKey:@"dateWaseReportResForGroups"]) {
                NSDictionary*localgrpdict = [grpdict objectForKey:@"data"];
                //NSLog(@"datacheck:%@",localgrpdict);
                for (NSDictionary*testsdict in [localgrpdict objectForKey:@"dateWaseReportResForTests"]) {
                //NSLog(@"testsdict:%@",testsdict);
                    
                  // for (NSDictionary*testsdict in  localtestsdict) {
                    //    //NSLog(@"testsdict check:%@",testsdict);
                    
                       // NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
                        ////NSLog(@"type_str:%@",type_str);
                       // [self.type_arr addObject:type_str];
                    
                       // NSDictionary*datakeydict = [localdict objectForKey:@"data"];
                       // //NSLog(@"datakeydict1:%@",datakeydict);
                        //if ([datakeydict objectForKey:@"isEntered"]==false) {
                    
                        //}else{
                    
                        //Test Id
                        NSString*testid_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"serviceId"]];
                        if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]]||[testid_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testid is :%@",testid_str);
                            testid_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testid_str:%@",testid_str);
                      //  [self.testid_arr addObject:testid_str];
                        
                        //Test Names
                        NSString*testname_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"serviceName"]];
                        if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]]||[testname_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testname_str is :%@",testname_str);
                            testname_str=@"";
                        }else{
                            
                        }
                        
                        //NSLog(@"testname_str:%@",testname_str);
                       // [self.testname_arr addObject:testname_str];
                        
                        //Test Department Ids
                        NSString*testdepart_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"deptId"]];
                        if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]]||[testdepart_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testdepart_str is :%@",testdepart_str);
                            testdepart_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testdepart_str group:%@",testdepart_str);
                        //[self.departmentid_arr addObject:testdepart_str];
                        
                        //Test Department Name
                        NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"depatName"]];
                        if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]]||[testdepartname_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testdepartname_str is :%@",testdepartname_str);
                            testdepartname_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testdepartname_str group:%@",testdepartname_str);
                      //  [self.departmentname_arr addObject:testdepartname_str];
                        
                        
                        
                        
                        //Test Date
                        
                        
                        NSString*testdate_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"testDate"]];
                        if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]]||[testdate_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testdate_str is :%@",testdate_str);
                            testdate_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testdate_str:%@",testdate_str);
                       // [self.testdate_arr addObject:testdate_str];
                        
                        NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
                        //NSLog(@"Array values are : %@",arr);
                        NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
                        //[self.testdatesplit_arr addObject:[arr objectAtIndex:0]];
                        //[self.testtimesplit_arr addObject:strtime];
                        
                        
                        
                        
                        //Test isEntered
                        
                        
                        
                        //NSString*isentredstr = [NSString stringWithFormat:@"%d",[[testsdict objectForKey:@"isEntered"]intValue]];
                       // [self.isentered_arr addObject:isentredstr];
                        
                        
                        
                        //Test Min Value
                        NSString*testminvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"lowValue"]];
                        if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]]||[testminvalue_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testminvalue_str is :%@",testminvalue_str);
                            testminvalue_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testminvalue_str:%@",testminvalue_str);
                        //[self.testminvalue_arr addObject:testminvalue_str];
                        
                        //Test Max Value
                        NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"highValue"]];
                        if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]]||[testmaxvalue_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testmaxvalue_str group is :%@",testmaxvalue_str);
                            testmaxvalue_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
                       // [self.testmaxvalue_arr addObject:testmaxvalue_str];
                        
                        
                       // NSString*testrange_str  = [NSString stringWithFormat:@"%@<%@>",testminvalue_str,testmaxvalue_str];
                        
                       // [self.testranges_arr addObject:testrange_str];
                        
                        
                        //Test Result Value
                        NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"testResult"]];
                        if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]]||[testresultvalue_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
                            testresultvalue_str=@"";
                        }else{
                            
                        }
                        
                       // [self.testresultvalue_arr addObject:testresultvalue_str];
                        
                        //Test Units
                        NSString*testunits_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"uom"]];
                        if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]]||[testunits_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testunits_str is :%@",testunits_str);
                            testunits_str=@"";
                        }else{
                            
                        }
                        
                        
                        //NSLog(@"testunits_str:%@",testunits_str);
                       // [self.testunits_arr addObject:testunits_str];
                        
                        //Test Critical Low Value
                        NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"lowCritical"]];
                        if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]]||[testcriticallowvalue_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testcriticallowvalue_str group is :%@",testcriticallowvalue_str);
                            testcriticallowvalue_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
                       // [self.testcriticallowvalue_arr addObject:testcriticallowvalue_str];
                        
                        //Test Critical Hight Value
                        NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"highCritical"]];
                        if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]]||[testcriticalhighvalue_str isEqualToString:@"<null>"])
                        {
                            //NSLog(@"testcriticalhighvalue_str group is :%@",testcriticalhighvalue_str);
                            testcriticalhighvalue_str=@"";
                        }else{
                            
                        }
                        //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
                       // [self.testcriticalhighvalue_arr addObject:testcriticalhighvalue_str];
                        

                        issuccess= [testdb saveGroupTests:[testsdict objectForKey:@"serviceId"] :[testsdict objectForKey:@"serviceName"] :[testsdict objectForKey:@"1"] :[arr objectAtIndex:0] :strtime :[testsdict objectForKey:@"deptId"] :[testsdict objectForKey:@"uom"] :[testsdict objectForKey:@"depatName"] :[testsdict objectForKey:@"lowValue"] :[testsdict objectForKey:@"highValue"] :[testsdict objectForKey:@"testResult"] :[testsdict objectForKey:@"lowCritical"] :[testsdict objectForKey:@"highCritical"] :[[testsdict objectForKey:@"isEntered"]intValue]];
                        
                        if (issuccess==YES) {
                            //NSLog(@"inserted group tests in db");
                        }else{
                            //NSLog(@" failed to insert group tests in db");
                            
                        }
                        
                        
                    //}
                }
                
            }
            
            
            
            
           // [self.paneltest_dict setObject:[datakeydict objectForKey:@"dateWaseReportResForTests"] forKey:[datakeydict objectForKey:@"panelName"]];
            //[self.panelgroup_dict setObject:[datakeydict objectForKey:@"dateWaseReportResForGroups"] forKey:[datakeydict objectForKey:@"panelName"]];
            
            
            //NSLog(@"temppanelgrpsdict:%@",temppanelgrpsdict);
            [self.paneltestobj_arr addObject:temppaneltestsdict];
            [self.panelgroupobj_arr addObject:temppanelgrpsdict];
            
            [self.testid_arr addObject:@""];
            [self.departmentid_arr addObject:@""];
            [self.departmentname_arr addObject:@""];
            [self.testdate_arr addObject:@""];
            [self.isentered_arr addObject:@""];
            [self.testminvalue_arr addObject:@""];
            [self.testmaxvalue_arr addObject:@""];
            [self.testresultvalue_arr addObject:@""];
            [self.testunits_arr addObject:@""];
            [self.testcriticallowvalue_arr addObject:@""];
            [self.testcriticalhighvalue_arr addObject:@""];
            [self.groupttestobj_arr addObject:@""];
            [self.testdatesplit_arr addObject:@""];
            [self.testtimesplit_arr addObject:@""];
            
        }

    }
    
    
    return self;
}

@end
