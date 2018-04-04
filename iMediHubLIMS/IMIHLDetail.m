//
//  IMIHLDetail.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDetail.h"
#import "MyReportsVC.h"
#import "IMDIHLReport.h"
#import "IMIHLDBManager.h"
#import "IMIHLReport.h"
@interface IMIHLDetail ()
@property(nonatomic,retain) NSMutableArray*patienttestid_arr;
@property(nonatomic,retain) NSMutableArray*patienttestrange_arr;
@property(nonatomic,retain) NSMutableArray*patienttestdate_arr;
@property(nonatomic,retain) NSMutableArray*patienttesttime_arr;
@property(nonatomic,retain)NSMutableArray*patientteststatus_arr;
@property(nonatomic,retain)NSMutableArray*patienttestunits_arr;
@property(nonatomic,retain)NSMutableArray*patienttestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttesttype_arr;
//@property(nonatomic,retain)NSMutableArray*patientgrouptestname_arr;
@property(nonatomic,retain)NSMutableArray*patientpaneltestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttestminvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestmaxvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisready;
@property(nonatomic,retain)NSMutableArray*departmentid_arr;
@property(nonatomic,retain)NSMutableArray*departmentname_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisrepeated_arr;
@end

@implementation IMIHLDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self allocateArray];
    //isback=0;
    if (self.testdict!=nil) {
        //NSLog(@"grop details");
        [self groupTest];
    }else if (self.paneltest_dict!=nil||self.panelgrps_dict){
        //isback=1;
        self.testdict = self.paneltest_dict;
        [self groupTest];
    }
    
    //[self.backbaritem_btn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backbaritem_btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backbaritem_btn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backbaritem_btn];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)allocateArray{
    self.patienttestid_arr = [[NSMutableArray alloc]init];
    self.patienttesttype_arr = [[NSMutableArray alloc]init];
    self.patienttestname_arr = [[NSMutableArray alloc]init];
    self.patienttestrange_arr = [[NSMutableArray alloc]init];
    self.patienttestdate_arr = [[NSMutableArray alloc]init];
    self.patienttesttime_arr = [[NSMutableArray alloc]init];
    self.patienttestvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestunits_arr = [[NSMutableArray alloc]init];
    self.patienttestminvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestmaxvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestisready = [[NSMutableArray alloc]init];
    self.grouptestname_arr = [[NSMutableArray alloc]init];
   // self.panelgrps_arr = [[NSMutableArray alloc]init];
    //self.paneltest_arr = [[NSMutableArray alloc]init];
    self.departmentid_arr = [[NSMutableArray alloc]init];
    self.departmentname_arr = [[NSMutableArray alloc]init];
    self.patienttestisrepeated_arr = [[NSMutableArray alloc]init];
    
    self.grpreloadtests_arr =  [[NSMutableArray alloc]init];
}
-(void)groupTest{
    
    isback=0;
[self removeDataInArray];
    NSDictionary*tmpdict = [self.testdict objectForKey:self.navigationController.title];
    //NSLog(@"tmpdict:%@",tmpdict);
    NSDictionary*tmpgrpdict = [self.panelgrps_dict objectForKey:self.navigationController.title];
    
    for (NSDictionary*localdict in tmpdict) {
     
    
            //NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
            //NSLog(@"type_str:%@",type_str);
            [self.patienttesttype_arr addObject:@"1"];
            
           // NSDictionary*datakeydict = [localdict objectForKey:@"data"];
            ////NSLog(@"datakeydict1:%@",datakeydict);
        
        
            //Test Id
            NSString*testid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceId"]];
            if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]])
            {
                //NSLog(@"testid is :%@",testid_str);
                testid_str=@"";
            }else{
                
            }
            //NSLog(@"testid_str:%@",testid_str);
            [self.patienttestid_arr addObject:testid_str];
            
            //Test Names
            NSString*testname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceName"]];
            if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]])
            {
                //NSLog(@"testname_str is :%@",testname_str);
                testname_str=@"";
            }else{
                
            }
            
            //NSLog(@"testname_str:%@",testname_str);
            [self.patienttestname_arr addObject:testname_str];
            
            //Test Department Ids
            NSString*testdepart_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"deptId"]];
            if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]])
            {
                //NSLog(@"testdepart_str is :%@",testdepart_str);
                testdepart_str=@"";
            }else{
                
            }
            //NSLog(@"testdepart_str:%@",testdepart_str);
            [self.departmentid_arr addObject:testdepart_str];
            
            //Test Department Name
            NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"depatName"]];
            if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]])
            {
                //NSLog(@"testdepartname_str is :%@",testdepartname_str);
                testdepartname_str=@"";
            }else{
                
            }
            //NSLog(@"testdepartname_str:%@",testdepartname_str);
           [self.departmentname_arr addObject:testdepartname_str];
            
            
            
            
            //Test Date
            
            
            NSString*testdate_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"testDate"]];
            if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]])
            {
                //NSLog(@"testdate_str is :%@",testdate_str);
                testdate_str=@"";
            }else{
                
            }
            //NSLog(@"testdate_str:%@",testdate_str);
            //[self.patienttestdate_arr addObject:testdate_str];
            NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
            //NSLog(@"Array values are : %@",arr);
            NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
            [self.patienttestdate_arr addObject:[arr objectAtIndex:0]];
            [self.patienttesttime_arr addObject:strtime];

    
            //Test isEntered
            NSString*isentredstr = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"isEntered"]intValue]];
            [self.patienttestisready addObject:isentredstr];
            
        NSString*isrepeatedstr = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"isRepeated"]intValue]];
        [self.patienttestisrepeated_arr addObject:isrepeatedstr];
        
        
            //Test Min Value
            NSString*testminvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"lowValue"]];
            if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testminvalue_str is :%@",testminvalue_str);
                testminvalue_str=@"";
            }else{
                
            }
            //NSLog(@"testminvalue_str:%@",testminvalue_str);
            [self.patienttestminvalue_arr addObject:testminvalue_str];
            
            //Test Max Value
            NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"highValue"]];
            if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testmaxvalue_str is :%@",testmaxvalue_str);
                testmaxvalue_str=@"";
            }else{
                
            }
            //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
            [self.patienttestmaxvalue_arr addObject:testmaxvalue_str];
            
            //Test Result Value
            NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"testResult"]];
            if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
                testresultvalue_str=@"";
            }else{
                
            }
            
            [self.patienttestvalue_arr addObject:testresultvalue_str];
            
            //Test Units
            NSString*testunits_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"uom"]];
            if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]])
            {
                //NSLog(@"testunits_str is :%@",testunits_str);
                testunits_str=@"not available";
            }else{
                
            }
            
            
            //NSLog(@"testunits_str:%@",testunits_str);
            [self.patienttestunits_arr addObject:testunits_str];
            
            //Test Critical Low Value
            NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"lowCritical"]];
            if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testcriticallowvalue_str is :%@",testcriticallowvalue_str);
                testcriticallowvalue_str=@"not available";
            }else{
                
            }
            //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
           // [self.testcriticallowvalue_arr addObject:testcriticallowvalue_str];
            
            //Test Critical Hight Value
            NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"highCritical"]];
            if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testcriticalhighvalue_str is :%@",testcriticalhighvalue_str);
                testcriticalhighvalue_str=@"not available";
            }else{
                
            }
            //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
            //[self.testcriticalhighvalue_arr addObject:testcriticalhighvalue_str];
            // }
        
        
        if ([testresultvalue_str isEqualToString:@"Positive"]||[testresultvalue_str isEqualToString:@"Negative"]) {
            [self.patienttestrange_arr addObject:@""];
            
        }else{
            NSString*strrange = [NSString stringWithFormat:@"%@><%@",testminvalue_str,testmaxvalue_str];
            [self.patienttestrange_arr addObject:strrange];
        }
        
        [self.grpreloadtests_arr addObject:@""];
    }
    
    
    //NSLog(@"tmpgrpdict:%@",tmpgrpdict);
   
    for (NSDictionary*localgrpdict in tmpgrpdict) {
        
             NSDictionary*tmpgrpdatadict = [localgrpdict objectForKey:@"data"];
            
            NSString*type_str = [NSString stringWithFormat:@"%d",[[localgrpdict objectForKey:@"type"]intValue]];
            //NSLog(@"type_str:%@",type_str);
            [self.patienttesttype_arr addObject:type_str];
        
            //Test Names
            NSString*testname_str = [NSString stringWithFormat:@"%@",[tmpgrpdatadict objectForKey:@"groupName"]];
            if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]])
            {
                //NSLog(@"testname_str is :%@",testname_str);
                testname_str=@"";
            }else{
                
            }
            
            //NSLog(@"testname_str:%@",testname_str);
            [self.patienttestname_arr addObject:testname_str];
        
        [self.grpreloadtests_arr addObject:[tmpgrpdatadict objectForKey:@"dateWaseReportResForTests"]];
        
            
    }
    
    
    
    [self.detailreports_tblview reloadData];
            
}

/*
-(void)testData{
    self.patienttestid_arr = [NSArray arrayWithObjects:@"TestID1", @"TestID2", @"TestID3", @"TestID4",@"TestID5",@"TestID6",@"TestID7",@"TestID8",@"TestID9",@"TestID1",nil];
    self.patienttestname_arr = [NSArray arrayWithObjects:@"TestA", @"TestB", @"TestC", @"TestD",@"GroupA",@"PanelA",@"TestE",@"TestF",@"TestG",@"TestH",nil];
    self.patienttesttype_arr = [NSArray arrayWithObjects:@"1", @"1", @"1", @"1",@"2",@"3",@"1",@"1",@"1",@"1",nil];
    self.patienttestrange_arr = [NSArray arrayWithObjects:@">15<40", @">15<40", @">15<40", @">15<40",@">15<40",@">15<40",@">15<40",@">15<40",@">15<40",@">15<40",nil];
    self.patienttestdate_arr = [NSArray arrayWithObjects:@"24th Jan 2016", @"29th Jan 2016", @"2th Feb 2016", @"12th Feb 2016",@"5th Mar 2016",@"15th Mar 2016",@"10th Apr 2016",@"16th May 2016",@"25th May 2016",@"20th Jun 2016",nil];
    self.patienttesttime_arr = [NSArray arrayWithObjects:@"10.30pm", @"10.30pm", @"10.30pm", @"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",nil];
    self.patientteststatus_arr = [NSArray arrayWithObjects:@"High", @"Normal", @"Normal", @"Normal",@"Normal",@"Normal",@"High",@"Normal",@"Low",@"Normal",nil];
    self.patienttestvalue_arr = [NSArray arrayWithObjects:@"41.2", @"18.2", @"32.2", @"16.2",@"15.2",@"22.2",@"36.2",@"34.2",@"10.2",@"21.2",nil];
    self.patienttestunits_arr = [NSArray arrayWithObjects:@"mmol/L", @"mmol/L", @"mmol/L", @"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",nil];
    self.patientgrouptestname_arr = [NSArray arrayWithObjects:@"TestA", @"TestB", @"TestC", @"TestD",@"TestX",@"TestY",@"TestE",@"TestF",@"TestG",@"TestH",nil];
    [self.detailreports_tblview reloadData];
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//////////////////////////////TableView Delegate Methods/////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.patienttestname_arr.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.view.frame.size.width<self.view.frame.size.height) {
        return self.detailreports_tblview.frame.size.height*0.2;

    }
    return self.detailreports_tblview.frame.size.height*0.4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    //NSLog(@"cellfor");
    static NSString *CellIdentifier = @"testlisttblcell";
    
    UITableViewCell *cell = [self.detailreports_tblview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    self.detailreports_tblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //mtable.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    
    if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==1) {
        
        //NSLog(@"cellcheck2");
         UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        /*
        UIButton*grphbtn = (UIButton*)[cell viewWithTag:8];
        
        [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
        [grphbtn setTag:indexPath.row];
        [grphbtn addTarget:self action:@selector(graphBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        */
        
        
        
        if ([[self.patienttestisready objectAtIndex:indexPath.row]intValue]==1) {
            
            //NSLog(@"isrepeated value:%d",[[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]);
           // if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==1) {
                
                
                
                grphbtn.hidden=NO;
                //  grphbtn.hidden=YES;
                
                [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
                
                // [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
                
                
                [grphbtn setTag:indexPath.row];
                [grphbtn addTarget:self action:@selector(graphBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                /*
            }else if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==0){
                // grphbtn.hidden=YES;
                //grphbtn=nil;
                
                //grphbtn.hidden=YES;
                
                [grphbtn setImage:nil forState:UIControlStateNormal];
                [grphbtn setHidden:YES];
            }
            */
            
            
            //NSLog(@"cellcheck3");
            UILabel*lbl;
            
            UILabel*lbl_range;
            //NSLog(@"cellcheck4");
            lbl_range=(UILabel*)[cell viewWithTag:1];
            lbl_range.text = [self.patienttestvalue_arr objectAtIndex:indexPath.row];
            //NSLog(@"cellcheck5");
            lbl=(UILabel*)[cell viewWithTag:2];
            lbl.text = [self.patienttestunits_arr objectAtIndex:indexPath.row];
            //NSLog(@"cellcheck6");
            lbl=(UILabel*)[cell viewWithTag:3];
            lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.row];
            //NSLog(@"cellcheck7");
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.row];
            //NSLog(@"cellcheck8");
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            
            //NSLog(@"patientteststatus_arr value:%@",[self.patientteststatus_arr objectAtIndex:indexPath.row]);
            //NSLog(@"self.patienttestvalue_arr:%@",self.patienttestvalue_arr);
            if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row] isEqualToString:@"Positive"]||[[self.patienttestvalue_arr objectAtIndex:indexPath.row] isEqualToString:@"Negative"]) {
                
                lbl=(UILabel*)[cell viewWithTag:6];
                lbl.hidden=YES;
               // lbl_range.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck5");
                //lbl_range.hidden=YES;
                lbl=(UILabel*)[cell viewWithTag:2];
                lbl.hidden=YES;
                //lbl.text = [self.patienttestunits_arr objectAtIndex:indexPath.row];
                //lbl.hidden=YES;
                //NSLog(@"cellcheck6");
                
                //NSLog(@"cellcheck9");
                if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row] isEqualToString:@"Negative"]) {
                    //NSLog(@"cellcheck21");
                
                //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                [btn setTitle:@"Negative" forState:UIControlStateNormal];
               // lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else{
                    //NSLog(@"cellcheck22");
                   // btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                     btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    [btn setTitle:@"Positive" forState:UIControlStateNormal];
                  //  lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                }
                
            }else{
                /*
                lbl_range=(UILabel*)[cell viewWithTag:6];
                lbl_range.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck25");
                lbl=(UILabel*)[cell viewWithTag:2];
                lbl.text = [self.patienttestunits_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck26");

                
                if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]>[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck10");
                    btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    [btn setTitle:@"High" forState:UIControlStateNormal];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];;
                }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]<[[self.patienttestminvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck11");
                    btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                    [btn setTitle:@"Low" forState:UIControlStateNormal];
                    lbl_range.textColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]>=[[self.patienttestminvalue_arr objectAtIndex:indexPath.row]intValue] ||
                          [[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]<=[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck12");
                    btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    [btn setTitle:@"Normal" forState:UIControlStateNormal];
                    lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                }
                 
                 */
                //NSLog(@"elsedgfhjdkfkkfkkdlld");
                
                if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]>[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck10");
                   // btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"High" forState:UIControlStateNormal];
                   // lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];;
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]<[[self.patienttestminvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck11");
                    //btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                    [btn setTitle:@"Low" forState:UIControlStateNormal];
                   // lbl_range.textColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]>=[[self.patienttestminvalue_arr objectAtIndex:indexPath.row]intValue] ||
                          [[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]<=[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck12");
                   // btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                     btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    [btn setTitle:@"Normal" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                }
                
                //NSLog(@"range erroroor");
                //NSLog(@"RangeArr:%@",self.patienttestrange_arr);
                lbl=(UILabel*)[cell viewWithTag:6];
                
                NSString*strl = [NSString stringWithFormat:@"%@",[self.patienttestrange_arr objectAtIndex:indexPath.row]];
                //NSLog(@"strlenth:%d",(int)strl.length);
                if (strl.length>10) {
                    lbl.font = [UIFont systemFontOfSize:8];
                }
                lbl.text = strl;
                
               // lbl.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck13");
                
                
                
                /*
                lbl=(UILabel*)[cell viewWithTag:6];
                lbl.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                 */
                //NSLog(@"cellcheck13");
            }
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.row];
            
            
        }else{
            //NSLog(@"cellcheck14");
            
            
            //NSLog(@"celldate:%@",[self.patienttestdate_arr objectAtIndex:indexPath.row]);
            //NSLog(@"celldate:%@",[self.patienttesttime_arr objectAtIndex:indexPath.row]);
            UILabel*lbl;
            
            UILabel*lbl_range;
            
            lbl_range=(UILabel*)[cell viewWithTag:1];
            lbl_range.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:2];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:3];
            lbl.hidden=NO;
            lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.row];
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.hidden=NO;
            lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.row];
            lbl=(UILabel*)[cell viewWithTag:6];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.row];
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            //btn.hidden=YES;
            btn.backgroundColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0];
            [btn setTitle:@"Pending" forState:UIControlStateNormal];
            //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
            UIButton*grphbtn = (UIButton*)[cell viewWithTag:8];
            grphbtn.hidden=YES;
            [grphbtn setImage:nil forState:UIControlStateNormal];
            //grphbtn.hidden=YES;

            
            
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==2){
        //NSLog(@"Group");
        UILabel*lbl;
        
        UILabel*lbl_range;
        
        lbl_range=(UILabel*)[cell viewWithTag:1];
        lbl_range.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:2];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:3];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:4];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:6];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:7];
        lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.row];
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        btn.hidden=YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.accessoryView
        
    }
    
    /*
    else if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==3){
        //NSLog(@"Panel");
        UILabel*lbl;
        
        UILabel*lbl_range;
        
        lbl_range=(UILabel*)[cell viewWithTag:1];
        lbl_range.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:2];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:3];
        
        lbl=(UILabel*)[cell viewWithTag:4];
        lbl=(UILabel*)[cell viewWithTag:6];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:7];
        lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.row];
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        btn.hidden=YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        
    }
     */
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"didselect method.....");
    //NSLog(@"didselect type:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    
    
    //self.navigationController.title=self.navigation_name_str;
    
    if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==2) {
        //NSLog(@"group entredee didselet");
            [self removeDataInArray];
        NSDictionary*grptests = [self.grpreloadtests_arr objectAtIndex:indexPath.row];
        
        [self groupTestsInDetails:grptests];
        
    } else {
    }
}


-(void)removeDataInArray{
    [self.patienttestid_arr removeAllObjects];
    [self.patienttesttype_arr removeAllObjects];
    [self.patienttestname_arr removeAllObjects];
    [self.patienttestrange_arr removeAllObjects];
    [self.patienttestdate_arr removeAllObjects];
    [self.patienttesttime_arr removeAllObjects];
    [self.patienttestvalue_arr removeAllObjects];
    [self.patienttestunits_arr removeAllObjects];
    [self.patienttestminvalue_arr removeAllObjects];
    [self.patienttestmaxvalue_arr removeAllObjects];
    [self.patienttestisrepeated_arr removeAllObjects];
    [self.patienttestisready removeAllObjects];
    [self.grouptestname_arr removeAllObjects];
    
}


-(IBAction)graphBtnClicked:(id)sender{
    UIButton*tagbutton = (UIButton*)sender;
    int tagvalue = (int)tagbutton.tag;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    IMDIHLReport * mrvc = [storyboard instantiateViewControllerWithIdentifier:@"reportgraph"];
    mrvc.patientid_str = self.patientid_str;
    
    IMIHLDBManager*dbmanger = [IMIHLDBManager getSharedInstance];
    
    dbmanger = [dbmanger getAllGroupTestsDB:[self.patienttestname_arr objectAtIndex:tagvalue]];
    
    
    //NSLog(@"tagvalue:%d",tagvalue);
    //[mrvc allocateArray];
    
    //NSLog(@"arr:%@",self.patienttestid_arr);
    //NSLog(@"dbmanager names:%@",dbmanger.patienttestname_arr);
    /*
     [mrvc.patienttestid_arr addObject:[self.patienttestid_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestname_arr addObject:[self.patienttestname_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestvalue_arr addObject:[self.patienttestvalue_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestunits_arr addObject:[self.patienttestunits_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestdate_arr addObject:[self.patienttestdate_arr objectAtIndex:indexvalue]];
     [mrvc.patienttesttime_arr addObject:[self.patienttesttime_arr objectAtIndex:indexvalue]];
     [mrvc.patienttesttype_arr addObject:[self.patienttesttype_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestrange_arr addObject:[self.patienttestrange_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestmaxvalue_arr addObject:[self.patienttestmaxvalue_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestminvalue_arr addObject:[self.patienttestminvalue_arr objectAtIndex:indexvalue]];
     [mrvc.patienttestisready addObject:[self.patienttestisready objectAtIndex:indexvalue]];
     */
    
    NSMutableArray*id_arr =[[NSMutableArray alloc]init];
    NSMutableArray*name_arr =[[NSMutableArray alloc]init];
    NSMutableArray*testvalue_arr =[[NSMutableArray alloc]init];
    NSMutableArray*units_arr =[[NSMutableArray alloc]init];
    NSMutableArray*dates_arr =[[NSMutableArray alloc]init];
    NSMutableArray*time_arr =[[NSMutableArray alloc]init];
    NSMutableArray*type_arr =[[NSMutableArray alloc]init];
    NSMutableArray*range_arr =[[NSMutableArray alloc]init];
    NSMutableArray*maxvalue_arr =[[NSMutableArray alloc]init];
    NSMutableArray*minvalue_arr =[[NSMutableArray alloc]init];
    NSMutableArray*isready_arr =[[NSMutableArray alloc]init];
    
    

    
    
    //NSLog(@"db testnames:%@",dbmanger.patienttestname_arr);
    for (int i=0; i<dbmanger.patienttestid_arr.count; i++) {
        //NSLog(@"timesss");
        
        //NSLog(@"i value:%d",i);
        if (i<5) {
            
            
            [id_arr addObject:[dbmanger.patienttestid_arr objectAtIndex:i]];
            [name_arr addObject:[dbmanger.patienttestname_arr objectAtIndex:i]];
            [testvalue_arr addObject:[dbmanger.patienttestvalue_arr objectAtIndex:i]];
            [units_arr addObject:[dbmanger.patienttestunits_arr objectAtIndex:i]];
            [dates_arr addObject:[dbmanger.patienttestdate_arr objectAtIndex:i]];
            [time_arr addObject:[dbmanger.patienttesttime_arr objectAtIndex:i]];
            [type_arr addObject:[dbmanger.patienttesttype_arr objectAtIndex:i]];
            [range_arr addObject:[self.patienttestrange_arr objectAtIndex:tagvalue]];
            [maxvalue_arr addObject:[dbmanger.patienttestmaxvalue_arr objectAtIndex:i]];
            [minvalue_arr addObject:[dbmanger.patienttestminvalue_arr objectAtIndex:i]];
            [isready_arr addObject:[dbmanger.patienttestisready objectAtIndex:i]];
            // j++;
        }else{
            
            break;
        }
    }
    
    mrvc.departmentname_str = [NSString stringWithFormat:@"%@",[self.departmentname_arr objectAtIndex:tagvalue]];
    // mrvc.deptName_lbl.text = [NSString stringWithFormat:@"%@",[self.patienttestdept_arr objectAtIndex:indexvalue]];
    //mrvc.testName_lbl.text = [NSString stringWithFormat:@"%@",[self.patienttestname_arr objectAtIndex:indexvalue]];
    
    mrvc.patienttestid_arr =id_arr;
    mrvc.patienttestname_arr =name_arr;
    mrvc.patienttestvalue_arr =testvalue_arr;
    mrvc.patienttestunits_arr =units_arr;
    mrvc.patienttestdate_arr =dates_arr;
    mrvc.patienttesttime_arr =time_arr;
    mrvc.patienttesttype_arr =type_arr;
    mrvc.patienttestrange_arr =range_arr;
    mrvc.patienttestmaxvalue_arr =maxvalue_arr;
    mrvc.patienttestminvalue_arr =minvalue_arr;
    mrvc.patienttestisready =isready_arr;
    // mrvc.patientid_str = self.patientid_str;
    mrvc.selected_index = [NSString stringWithFormat:@"%d",tagvalue];
    //NSLog(@"testnamescheck:%@",mrvc.patienttestname_arr);
    //NSLog(@"reportcheck");
    [self.navigationController pushViewController:mrvc animated:YES];
    
    //[self loadViewControllerFromStoryBoard:@"reportgraph"];
    
}

-(void)groupTestsInDetails:(NSDictionary*)testsdict{
    
    isback=1;
    
    for (NSDictionary*localdict in testsdict) {
        
            
            
            //NSString*type_str = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"type"]intValue]];
            //NSLog(@"type_str:%@",type_str);
            [self.patienttesttype_arr addObject:@"1"];
            
            // NSDictionary*datakeydict = [localdict objectForKey:@"data"];
            ////NSLog(@"datakeydict1:%@",datakeydict);
            
            
            //Test Id
            NSString*testid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceId"]];
            if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqual:[NSNull null]])
            {
                //NSLog(@"testid is :%@",testid_str);
                testid_str=@"";
            }else{
                
            }
            //NSLog(@"testid_str:%@",testid_str);
            [self.patienttestid_arr addObject:testid_str];
            
            //Test Names
            NSString*testname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"serviceName"]];
            if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqual:[NSNull null]])
            {
                //NSLog(@"testname_str is :%@",testname_str);
                testname_str=@"";
            }else{
                
            }
            
            //NSLog(@"testname_str:%@",testname_str);
            [self.patienttestname_arr addObject:testname_str];
            
            //Test Department Ids
            NSString*testdepart_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"deptId"]];
            if ([testdepart_str isEqualToString:@""]||[testdepart_str isEqualToString:@"(null)"]||testdepart_str==nil||testdepart_str==NULL||[testdepart_str isEqual:[NSNull null]])
            {
                //NSLog(@"testdepart_str is :%@",testdepart_str);
                testdepart_str=@"";
            }else{
                
            }
            //NSLog(@"testdepart_str:%@",testdepart_str);
            //[self.departmentid_arr addObject:testdepart_str];
            
            //Test Department Name
            NSString*testdepartname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"depatName"]];
            if ([testdepartname_str isEqualToString:@""]||[testdepartname_str isEqualToString:@"(null)"]||testdepartname_str==nil||testdepartname_str==NULL||[testdepartname_str isEqual:[NSNull null]])
            {
                //NSLog(@"testdepartname_str is :%@",testdepartname_str);
                testdepartname_str=@"";
            }else{
                
            }
            //NSLog(@"testdepartname_str:%@",testdepartname_str);
            // [self.departmentname_arr addObject:testdepartname_str];
            
            
            
            
            //Test Date
            
            
            NSString*testdate_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"testDate"]];
            if ([testdate_str isEqualToString:@""]||[testdate_str isEqualToString:@"(null)"]||testdate_str==nil||testdate_str==NULL||[testdate_str isEqual:[NSNull null]])
            {
                //NSLog(@"testdate_str is :%@",testdate_str);
                testdate_str=@"";
            }else{
                
            }
            //NSLog(@"testdate_str:%@",testdate_str);
            //[self.patienttestdate_arr addObject:testdate_str];
            NSArray * arr = [testdate_str componentsSeparatedByString:@" "];
            //NSLog(@"Array values are : %@",arr);
            NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
            [self.patienttestdate_arr addObject:[arr objectAtIndex:0]];
            [self.patienttesttime_arr addObject:strtime];
            
            
            //Test isEntered
            NSString*isentredstr = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"isEntered"]intValue]];
            [self.patienttestisready addObject:isentredstr];
            
        NSString*isrepeatedstr = [NSString stringWithFormat:@"%d",[[localdict objectForKey:@"isRepeated"]intValue]];
        [self.patienttestisrepeated_arr addObject:isrepeatedstr];
        
        
            //Test Min Value
            NSString*testminvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"lowValue"]];
            if ([testminvalue_str isEqualToString:@""]||[testminvalue_str isEqualToString:@"(null)"]||testminvalue_str==nil||testminvalue_str==NULL||[testminvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testminvalue_str is :%@",testminvalue_str);
                testminvalue_str=@"";
            }else{
                
            }
            //NSLog(@"testminvalue_str:%@",testminvalue_str);
            [self.patienttestminvalue_arr addObject:testminvalue_str];
            
            //Test Max Value
            NSString*testmaxvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"highValue"]];
            if ([testmaxvalue_str isEqualToString:@""]||[testmaxvalue_str isEqualToString:@"(null)"]||testmaxvalue_str==nil||testmaxvalue_str==NULL||[testmaxvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testmaxvalue_str is :%@",testmaxvalue_str);
                testmaxvalue_str=@"";
            }else{
                
            }
            //NSLog(@"testmaxvalue_str:%@",testmaxvalue_str);
            [self.patienttestmaxvalue_arr addObject:testmaxvalue_str];
        
        
        
        
            //Test Result Value
            NSString*testresultvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"testResult"]];
            if ([testresultvalue_str isEqualToString:@""]||[testresultvalue_str isEqualToString:@"(null)"]||testresultvalue_str==nil||testresultvalue_str==NULL||[testresultvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testresultvalue_str is :%@",testresultvalue_str);
                testresultvalue_str=@"";
            }else{
                
            }
            
            [self.patienttestvalue_arr addObject:testresultvalue_str];
        
        if ([testresultvalue_str isEqual:[NSNull null]]||[testmaxvalue_str isEqual:[NSNull null]]||[testminvalue_str isEqual:[NSNull null]]) {
            [self.patienttestrange_arr addObject:@""];
        }else{
        if ([testresultvalue_str isEqualToString:@"Positive"]||[testresultvalue_str isEqualToString:@"Negative"]) {
            [self.patienttestrange_arr addObject:@""];
            
        }else{
            NSString*strrange = [NSString stringWithFormat:@"%@><%@",testminvalue_str,testmaxvalue_str];
            [self.patienttestrange_arr addObject:strrange];
        }
        }
            
            //Test Units
            NSString*testunits_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"uom"]];
            if ([testunits_str isEqualToString:@""]||[testunits_str isEqualToString:@"(null)"]||testunits_str==nil||testunits_str==NULL||[testunits_str isEqual:[NSNull null]])
            {
                //NSLog(@"testunits_str is :%@",testunits_str);
                testunits_str=@"not available";
            }else{
                
            }
            
            
            //NSLog(@"testunits_str:%@",testunits_str);
            [self.patienttestunits_arr addObject:testunits_str];
            
            //Test Critical Low Value
            NSString*testcriticallowvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"lowCritical"]];
            if ([testcriticallowvalue_str isEqualToString:@""]||[testcriticallowvalue_str isEqualToString:@"(null)"]||testcriticallowvalue_str==nil||testcriticallowvalue_str==NULL||[testcriticallowvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testcriticallowvalue_str is :%@",testcriticallowvalue_str);
                testcriticallowvalue_str=@"not available";
            }else{
                
            }
            //NSLog(@"testcriticallowvalue_str:%@",testcriticallowvalue_str);
            // [self.testcriticallowvalue_arr addObject:testcriticallowvalue_str];
            
            //Test Critical Hight Value
            NSString*testcriticalhighvalue_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"highCritical"]];
            if ([testcriticalhighvalue_str isEqualToString:@""]||[testcriticalhighvalue_str isEqualToString:@"(null)"]||testcriticalhighvalue_str==nil||testcriticalhighvalue_str==NULL||[testcriticalhighvalue_str isEqual:[NSNull null]])
            {
                //NSLog(@"testcriticalhighvalue_str is :%@",testcriticalhighvalue_str);
                testcriticalhighvalue_str=@"not available";
            }else{
                
            }
            //NSLog(@"testcriticalhighvalue_str:%@",testcriticalhighvalue_str);
            //[self.testcriticalhighvalue_arr addObject:testcriticalhighvalue_str];
            // }
            
    }

    [self.detailreports_tblview reloadData];
    
}



- (IBAction)backItemClick:(id)sender {
    if (isback==1) {
        [self groupTest];
    }else{
    [self loadViewControllerFromStoryBoard:@"labreport"];
    }
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    
    if ([identifiername isEqualToString:@"labreport"]) {
         IMIHLReport * mrvc = [storyboard instantiateViewControllerWithIdentifier:@"labreport"];
        //NSLog(@"self.tempreportdict:%@",self.tempreportdict);
        mrvc.patientid_str = self.patientid_str;
        mrvc.id_str =@"0";
        mrvc.datestore_str = self.filterdateshow_str;
        mrvc.tempreportdict = self.tempreportdict;
        [self.navigationController pushViewController:mrvc animated:YES];
    }else{
        MyReportsVC * mrvc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        mrvc.patientid_str = self.patientid_str;
        mrvc.tempreportdict = self.tempreportdict;
        [self.navigationController pushViewController:mrvc animated:YES];
    }
    
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.detailreports_tblview reloadData];
}

@end
