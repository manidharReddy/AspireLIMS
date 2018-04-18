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


-(void)allocateMemory{
    self.alReportObjsArry = [[NSMutableArray alloc]init];
    self.alReportObjsSet = [NSMutableOrderedSet new];
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.alReportObjsArry forKey:@"alReportObjsArry"];
    [encoder encodeObject:self.alReportObjsSet forKey:@"alReportObjsSet"];
    
    //[encoder encodeObject:self.alReportObjsArry forKey:@"alReportObjsArry"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.alReportObjsArry = [decoder decodeObjectForKey:@"alReportObjsArry"];
    self.alReportObjsSet = [decoder decodeObjectForKey:@"alReportObjsSet"];
    //self.alReportObjsArry = [decoder decodeObjectForKey:@"alReportObjsArry"];
    
    return self;
    
}




///////////Edited////////////////////////
-(IMIHLReportValue*)getReports:(NSDictionary*)responseresult ifSearch:(BOOL)isType{
    [self allocateMemory];
    IMIHLDBManager*testdb;
    NSLog(@"isType Checked:%d",isType);
    if (isType == true) {
        NSLog(@"isType:true");
    
        }else{
            NSLog(@"isType:false");
            testdb = [IMIHLDBManager getSharedInstance];
            
            [testdb deleteGroupTestsInfoDB];

    }
    BOOL issuccess;
    
    ALReports *report = [ALReports getSharedInstance];
    //[report allocate];
    report.resultDataArrObj = [[NSMutableArray alloc]init];
    
    for (NSDictionary*localdict in responseresult) {
        //NSLog(@"localdict:%@",localdict);
       // NSLog(@"localdick:%@",localdict);
        //NSLog(@"repeated value:%@",[localdict objectForKey:@"isRepeated"]);
        NSString*isrepeated_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"isRepeated"]];
        if ([isrepeated_str isEqualToString:@""]||[isrepeated_str isEqualToString:@"(null)"]||isrepeated_str==nil||isrepeated_str==NULL||[isrepeated_str isEqual:[NSNull null]]||[isrepeated_str isEqualToString:@"<null>"])
        {
            //NSLog(@"isrepeated_str value :%@",isrepeated_str);
            isrepeated_str=@"0";
        }else{
            
        }
        NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
        NSLog(@"type_str:%@",type_str);
        
        report.testTypeObj = type_str;
        
        
        if ([type_str isEqualToString:@"1"]) {
            report.testIsRepeatedObj = isrepeated_str;
            //NSLog(@"isrepeated_str:%@",isrepeated_str);
            
            // NSDictionary*sublocal_dict = [localdict objectForKey:@"data"];
            
            
            NSDictionary*datakeydict = [localdict objectForKey:@"data"];
            
            //NSLog(@"datakeydict1:%@",datakeydict);
            //if ([datakeydict objectForKey:@"isEntered"]==false) {
            
            //}else{
            NSArray*arrytestdict =[datakeydict objectForKey:@"dateWaseReportResForTests"];
            NSLog(@"check mate3");
            if (arrytestdict.count!=0) {
                NSLog(@"check mate4");
                datakeydict = nil;
                datakeydict = [arrytestdict objectAtIndex:0];
                NSLog(@"check mate5");
               ALTest*testObj = [self setDataForAlTestObj:datakeydict];
                NSLog(@"check mate6");
                NSLog(@"ieRepeatedVlaue:%@",testObj.isrepeated);
                NSLog(@"testObj.testresultvalue:%@",testObj.testresultvalue);
                [report.resultDataArrObj addObject:testObj];
                [self.alReportObjsArry addObject:report];
                if ([testObj.isrepeated isEqualToString:@"1"]) {
                     NSLog(@"check mate23");
                    if ([testObj.testresultvalue isEqualToString:@"POSITIVE"] || [testObj.testresultvalue isEqualToString:@"NEGATIVE"]) {
                        
                    }else if([testObj.testresultvalue intValue]>0.0){
                         NSLog(@"check mate24");
                        if (isType == false) {
                            
                        
                issuccess= [testdb saveGroupTests:testObj.testid :testObj.testname :testObj.type :testObj.testdatesplit :testObj.testtimesplit :testObj.departmentid :testObj.testunits :testObj.departmentname :testObj.testminvalue :testObj.testmaxvalue :testObj.testresultvalue :testObj.testcriticallowvalue :testObj.testcriticalhighvalue :[testObj.isentered intValue]];
                    
                       
                
                if (issuccess==YES) {
                    NSLog(@"inserted group tests in db");
                }else{
                    NSLog(@" failed to insert group tests in db");
                    
                }
                        }else{
                            NSLog(@"isSerach:%d",isType);
                        }
                }
                    
                testObj = nil;
                }else{
                    
                }
            
            }else{
                
            }
            NSLog(@"check mate10");
            
        }
        else if ([type_str isEqualToString:@"2"]){
            
            NSLog(@"type2 entered resultvlue");
            report.testIsRepeatedObj = isrepeated_str;
            NSDictionary*datakeydict = [localdict objectForKey:@"data"];
           NSArray*dateWaseReportResForGroupsArry =[datakeydict objectForKey:@"dateWaseReportResForGroups"];
            NSLog(@"dateWaseReportResForGroupsArry.count:%d",dateWaseReportResForGroupsArry.count);
            if (dateWaseReportResForGroupsArry.count!=0) {
                
                NSDictionary*dataDict = [dateWaseReportResForGroupsArry objectAtIndex:0];
            NSDictionary*secondDataDict = [dataDict objectForKey:@"data"];
                //NSDictionary*tempGeneralDict = [arryDataValue objectAtIndex:0];
                NSLog(@"secondDataDict:%@",secondDataDict);
                NSString*groupName = [secondDataDict objectForKey:@"groupName"];
                if ([groupName isEqualToString:@""]||[groupName isEqualToString:@"(null)"]||groupName==nil||groupName==NULL||[groupName isEqual:[NSNull null]]||[groupName isEqualToString:@"<null>"])
                {
                    NSLog(@"groupName_str is :%@",groupName);
                    groupName=@"";
                }else{
                    //NSArray*testsArry = [secondDataDict objectForKey:@"dateWaseReportResForTests"];
                   
                    //if (testsArry.count!=0) {
                         NSDictionary*testsList = [secondDataDict objectForKey:@"dateWaseReportResForTests"];
                        ALGroup*groupObj = [self setGroupObjectWithData:testsList :groupName];
                        //groupObj.groupName = groupName;
                       // NSString*keyForGroupTest = [NSString stringWithFormat:@"%@%@",groupName,groupObj.groupDate];
                        //[report.groupTests setObject:testsList forKey:keyForGroupTest];
                        [report.resultDataArrObj addObject:groupObj];
                        groupObj=nil;
                        [self.alReportObjsArry addObject:report];
                      // }
                    
                    }
               }
          }//type 2 condition end
}
    NSLog(@"count value check:%d",self.alReportObjsArry.count);
    return self;
}

-(ALGroup*)setGroupObjectWithData:(NSDictionary*)testList :(NSString*)groupName{
        int isentred = 0,enteredvalue = 0;
        NSMutableString*strdatemut =[NSMutableString new];
        NSMutableString*strtimemut = [NSMutableString new];
        for (NSDictionary*testsdict in testList) {
            //NSLog(@"testsdict:%@",testsdict);
            NSString*testdate_str = [NSString stringWithFormat:@"%@",[testsdict objectForKey:@"testDate"]];
            if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]]||[testdate_str isEqualToString:@"<null>"])
            {
                //NSLog(@"testdate_str is :%@",testdate_str);
                testdate_str=@"";
            }else{
                
            }
            NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
            //NSLog(@"Array values are : %@",arr);
            NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
            //NSLog(@"date set:%@ Time Set:%@",strdatemut,strtimemut);
            if ([strdatemut isEqualToString:@""]) {
                //strdatemut = [arr objectAtIndex:0];
                [strdatemut setString:[arr objectAtIndex:0]];
                [strtimemut setString:strtime];
                //strtimemut = strtime;
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
            
            break;
        }
        
    NSLog(@"gorupName Data:%@",groupName);
        NSLog(@"check mate4 gorup:%@",strdatemut);
       // NSString*keyForGroupTest = [NSString stringWithFormat:@"%@%@",groupName,strdatemut];
       //NSDictionary*grouptestsdict = [NSDictionary dictionaryWithObject:testList forKey:keyForGroupTest];
    
    ALGroup* groupObj = [ALGroup new];
    
       //[groupObj setTests:grouptestsdict];
    //[groupObj.tests setValue:testList forKey:keyForGroupTest];
        groupObj.groupName = groupName;
        groupObj.groupIsEntered = [NSString stringWithFormat:@"%d",(int)enteredvalue];
        groupObj.groupDate = [NSString stringWithFormat:@"%@",strdatemut];
        
        
        NSLog(@"isEnteredStr:%d",(int)enteredvalue);
        groupObj.groupTime = [NSString stringWithFormat:@"%@",strtimemut];
        groupObj.grouptests = testList;
    
        
        strdatemut=nil;
        strtimemut=nil;
        
    return groupObj;
}


-(ALTest*)setDataForAlTestObj:(NSDictionary*)dict{
     ALTest*testObj =nil;
 
        testObj =[[ALTest alloc]init];

        //Test Id
        NSString*testid_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"serviceId"]];
        if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]]||[testid_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testid is :%@",testid_str);
            testid_str=@"";
        }else{
            
        }
        //NSLog(@"testid_str:%@",testid_str);
    
        testObj.testid = testid_str;
    
    
    
        //Test Names
        NSString*testname_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"serviceName"]];
        if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]]||[testname_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testname_str is :%@",testname_str);
            testname_str=@"";
        }else{
            
        }
        testObj.testname = testname_str;
        //NSLog(@"testname_str:%@",testname_str);
        
        
        //Test Department Ids
        NSString*testdepart_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"deptId"]];
        if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]]||[testdepart_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testdepart_str is :%@",testdepart_str);
            testdepart_str=@"";
        }else{
            
        }
        //NSLog(@"testdepart_str:%@",testdepart_str);
        testObj.departmentid = testdepart_str;
        
        //Test Department Name
        NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"depatName"]];
        if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]]||[testdepartname_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testdepartname_str is :%@",testdepartname_str);
            testdepartname_str=@"";
        }else{
            
        }
        //NSLog(@"testdepartname_str:%@",testdepartname_str);
        testObj.departmentname = testdepartname_str;
        
        
        
        
        //Test Date
        
        
        NSString*testdate_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"testDate"]];
        if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]]||[testdate_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testdate_str is :%@",testdate_str);
            testdate_str=@"";
        }else{
            
        }
        //NSLog(@"testdate_str:%@",testdate_str);
    
        
        testObj.testdate = testdate_str;
        
        NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
        //NSLog(@"Array values are : %@",arr);
        NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
        
        testObj.testdatesplit = [arr objectAtIndex:0];
        testObj.testtimesplit = strtime;
        //[self.testdatesplit_arr addObject:[arr objectAtIndex:0]];
        //[self.testtimesplit_arr addObject:strtime];
        
        
        
        
        //Test isEntered
    
        NSString*isentredstr = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"isEntered"]intValue]];
        //[self.isentered_arr addObject:isentredstr];
        
        testObj.isentered = isentredstr;
        
        
        
        //Test Min Value
        NSString*testminvalue_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"lowValue"]];
        if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]]||[testminvalue_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testminvalue_str is :%@",testminvalue_str);
            testminvalue_str=@"";
        }else{
            
        }
        //NSLog(@"testminvalue_str:%@",testminvalue_str);
    
        testObj.testminvalue = testminvalue_str;
        
        //Test Max Value
        NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"highValue"]];
        if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]]||[testmaxvalue_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testmaxvalue_str is :%@",testmaxvalue_str);
            testmaxvalue_str=@"";
        }else{
            
        }
        //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
    
        testObj.testmaxvalue = testmaxvalue_str;
        
        NSString*testrange_str  = [NSString stringWithFormat:@"%@<=%@",testminvalue_str,testmaxvalue_str];
        
    
        testObj.testranges = testrange_str;
        
        //Test Result Value
        NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"testResult"]];
        if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]]||[testresultvalue_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
            testresultvalue_str=@"";
        }else{
            
        }
        
    
        testObj.testresultvalue = testresultvalue_str;
        //Test Units
        NSString*testunits_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"uom"]];
        if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]]||[testunits_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testunits_str is :%@",testunits_str);
            testunits_str=@"not available";
        }else{
            
        }
        
        
        //NSLog(@"testunits_str:%@",testunits_str);
    
        testObj.testunits = testunits_str;
        
        
        
        //Test Critical Low Value
        NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"lowCritical"]];
        if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]]||[testcriticallowvalue_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testcriticallowvalue_str is :%@",testcriticallowvalue_str);
            testcriticallowvalue_str=@"not available";
        }else{
            
        }
        //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
    
        testObj.testcriticallowvalue = testcriticallowvalue_str;
        
        
        
        //Test Critical Hight Value
        NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"highCritical"]];
        if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]]||[testcriticalhighvalue_str isEqualToString:@"<null>"])
        {
            //NSLog(@"testcriticalhighvalue_str is :%@",testcriticalhighvalue_str);
            testcriticalhighvalue_str=@"not available";
        }else{
            
        }
    
        //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
    
        // }
        
        testObj.testcriticalhighvalue = testcriticalhighvalue_str;
        
    NSString*isrepeated_str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"isRepeated"]];
    if ([isrepeated_str isEqualToString:@""]||[isrepeated_str isEqualToString:@"(null)"]||isrepeated_str==nil||isrepeated_str==NULL||[isrepeated_str isEqual:[NSNull null]]||[isrepeated_str isEqualToString:@"<null>"])
    {
        //NSLog(@"isrepeated_str value :%@",isrepeated_str);
        isrepeated_str=@"0";
    }else{
        
    }
    testObj.isrepeated = isrepeated_str;
        
        return testObj;
}

@end
