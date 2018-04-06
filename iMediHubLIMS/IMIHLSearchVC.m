//
//  IMIHLSearchVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 01/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLSearchVC.h"
#import "IMIHLRestService.h"
#import "IMIHLSearchResults.h"
#import "IMIHLReportValue.h"
#import "IMIHLDetail.h"
#import "ViewController.h"
@interface IMIHLSearchVC (){
    int selectedindex;
}
@property(nonatomic,retain) NSMutableArray*patienttestid_arr;
@property(nonatomic,retain) NSMutableArray*patienttestrange_arr;
@property(nonatomic,retain) NSMutableArray*patienttestdate_arr;
@property(nonatomic,retain) NSMutableArray*patienttesttime_arr;
@property(nonatomic,retain)NSMutableArray*patientteststatus_arr;
@property(nonatomic,retain)NSMutableArray*patienttestunits_arr;
@property(nonatomic,retain)NSMutableArray*patienttestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttesttype_arr;
@property(nonatomic,retain)NSMutableArray*patientgrouptestname_arr;
@property(nonatomic,retain)NSMutableArray*patientpaneltestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttestminvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestmaxvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisready;
@property(nonatomic,retain)NSMutableArray*paneltests_arr;
@property(nonatomic,retain)NSMutableArray*panelgrps_arr;


//@property(nonatomic,retain)NSMutableArray*listoftestsingroups_arr;
//@property(nonatomic,retain)NSMutableArray*listoftestsinpanel_arr;
//@property(nonatomic,retain)NSMutableArray*listofgrpsinpanel_arr;



@property (nonatomic, retain) NSArray *autoCompleteFilterArray;
@end

@implementation IMIHLSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.backbarbtnitem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    [self allocateArray];
    /*
    self.serviceid_arr = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    self.servicename_arr = [[NSMutableArray alloc]initWithObjects:@"name1",@"name2",@"name3",@"name4",@"name5",@"name6",@"name7",@"name8",@"name9",@"name10", nil];
    */
    
    //self.tableView.hidden =TRUE;
    
    //self.tableView.tableFooterView = [UIView new];
    
    [[self.tableView layer] setMasksToBounds:NO];
    [[self.tableView layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self.tableView layer] setShadowOffset:CGSizeMake(0.0f, 5.0f)];
    [[self.tableView layer] setShadowOpacity:0.3f];

    
    
    self.searchbar.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden =NO;
    self.backbarbtnitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backbarbtnitem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backbarbtnitem];
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //NSLog(@"touchview:%@",touch.view);
    //if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        [self.searchbar resignFirstResponder];
    //}
}

*/
- (void)goBack
{
    self.navigationController.navigationBar.hidden = YES;
    [self loadViewControllerFromStoryBoard:@"dashboard"];
    //[self.navigationController popViewControllerAnimated:YES];
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
    self.patientgrouptestname_arr = [[NSMutableArray alloc]init];
    
    self.serviceid_arr = [[NSMutableArray alloc]init];
    self.servicename_arr = [[NSMutableArray alloc]init];
    self.paneltests_arr = [[NSMutableArray alloc]init];
    self.panelgrps_arr = [[NSMutableArray alloc]init];
    
   // self.listoftestsingroups_arr = [[NSMutableArray alloc]init];
    //self.listoftestsinpanel_arr = [[NSMutableArray alloc]init];
    //self.listofgrpsinpanel_arr = [[NSMutableArray alloc]init];
    
    [self performSelector:@selector(getServices) withObject:nil afterDelay:0.1];
   // [self getServices];
    
}

-(void)getServices{
    
    IMIHLRestService*restservice = [IMIHLRestService getSharedInstance];
   // int statuscode =[restservice getSearchServices:self.patientid_str];
    [restservice getSearchServices:self.patientid_str withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            IMIHLSearchResults*serch = [[IMIHLSearchResults alloc]init];
            serch = [serch getSearchServiceResult:restservice.restresult_dict];
            
            self.serviceid_arr =  [[NSMutableArray alloc]initWithArray:serch.serviceid_arr];
            self.servicename_arr = [[NSMutableArray alloc]initWithArray:serch.servicename_arr];
            //NSLog(@"idsdd:%@",self.serviceid_arr);
        }else{
            [self showAlertController:@"You dnt have any services"];
        }
    }];
    //NSLog(@"services called");
    //if ([restservice getSearchServices:self.patientid_str]==200) {
    
}




-(void)getSearchResult:(NSString*)patientid :(NSString*)serviceid{
    IMIHLRestService*restservice = [IMIHLRestService getSharedInstance];
    
    //if ([restservice getSearchServices:self.patientid_str]==200) {
    //int statuscode =[restservice getSearchResults:self.patientid_str :serviceid];
    [restservice getSearchResults:self.patientid_str :serviceid withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            IMIHLReportValue*serch = [[IMIHLReportValue alloc]init];
            // serch = [serch getReportResult:restservice.restresult_dict];
            //IMIHLSearchResults*serch = [[IMIHLSearchResults alloc]init];
            
            serch = [serch getReportResult:restservice.restresult_dict];
            
            
            self.patienttesttype_arr =serch.type_arr;
            
            self.patienttestid_arr = serch.testid_arr;
            
            self.patienttestname_arr =serch.testname_arr;
            self.searchbar.text = [serch.testname_arr objectAtIndex:0];
            
            self.patienttestrange_arr =serch.testranges_arr;
            //NSLog(@"testranges:%@",self.patienttestrange_arr);
            self.patienttestdate_arr = serch.testdatesplit_arr;
            //NSLog(@"patienttestdate_arr:%@",self.patienttestdate_arr);
            self.patienttesttime_arr = serch.testtimesplit_arr;
            self.patienttestvalue_arr =serch.testresultvalue_arr;
            //NSLog(@"self.patienttestvalue_arr:%@",self.patienttestvalue_arr);
            self.patienttestunits_arr =serch.testunits_arr;
            self.patienttestminvalue_arr =serch.testminvalue_arr;
            //NSLog(@"self.patienttestminvalue_arr:%@",self.patienttestminvalue_arr);
            self.patienttestmaxvalue_arr =serch.testmaxvalue_arr;
            self.patienttestisready =serch.isentered_arr;
            //self.listoftestsingroups_arr = serch.groupttestobj_arr;
            //self.listoftestsinpanel_arr = serch.paneltestobj_arr;
            //self.listofgrpsinpanel_arr = serch.panelgroupobj_arr;
            
            //NSLog(@"serch.groupttestobj_arr:%@",serch.groupttestobj_arr);
            self.patientgrouptestname_arr =serch.groupttestobj_arr;
            //NSLog(@"self.patientgrouptestname_arr:%@",self.patientgrouptestname_arr);
            
            [self.tableView reloadData];
            
        }else if (response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
             [self showAlertController:[restservice.restresult_dict objectForKey:@"msg"]];
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -kDropDown
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    _Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    _Dropobj.delegate = self;
    [_Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [_Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    //NSLog(@"seledt:%@",[self.servicename_arr objectAtIndex:anIndex]);
    
    [self getSearchResult:self.patientid_str :[self.serviceid_arr objectAtIndex:selectedindex]];
    [self.tableView reloadData];
    [self.searchbar resignFirstResponder];
   // [self.searchbar setTitle:[self.servicename_arr objectAtIndex:anIndex] forState:UIControlStateNormal];
    //self.servicename_str =[self.servicename_arr objectAtIndex:anIndex];
    
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    ///----------------Get Selected Value[Multiple selection]-----------------//
    /*
     if (ArryData.count>0) {
     _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
     CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
     _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
     }
     else{
     _lblSelectedCountryNames.text=@"";
     }
     */
}

- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [_Dropobj fadeOut];
    }
    [self.searchbar resignFirstResponder];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.patienttestname_arr.count ;
}
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    //return self.patienttestname_arr.count;
    return self.autoCompleteFilterArray.count;
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"count patient names:%d",(int)self.autoCompleteFilterArray.count);
    /*
    if (self.autoCompleteFilterArray!=nil) {
        
    return self.autoCompleteFilterArray.count;
    }else if(self.patienttestname_arr.count!=0){
        return self.patienttestname_arr.count;
    }
     */
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    //NSLog(@"cell for row at index");
    static NSString *CellIdentifier = @"testlisttblcell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //NSLog(@"cell if");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.layer.cornerRadius = 10.0f;
    
    //tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //NSLog(@"cell checkkkk:%@",cell);
    
    //NSLog(@"cellcheck1");
    //NSLog(@"indexPath:%lu",(long)indexPath.row);
    //NSLog(@"Patient test Name:%@",[self.patienttestname_arr objectAtIndex:indexPath.row]);
    //NSLog(@"types:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    //NSLog(@"is ready:%@",[self.patienttestisready objectAtIndex:indexPath.row]);
    //NSLog(@"Ready Array:%@",self.patienttestisready);
    if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==1) {
        //NSLog(@"cellcheck2");
        UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        
        // grphbtn.hidden=NO;
        if ([[self.patienttestisready objectAtIndex:indexPath.section]intValue]==1) {
            
           // //NSLog(@"isrepeated value:%d",[[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]);
            //if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==1) {
            
            
            
            grphbtn.hidden=NO;
            //  grphbtn.hidden=YES;
            
            [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
            
            // [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
            
            
            [grphbtn setTag:indexPath.section];
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
            lbl_range.text = [self.patienttestvalue_arr objectAtIndex:indexPath.section];
            lbl_range.hidden=NO;
            //NSLog(@"cellcheck5");
            lbl=(UILabel*)[cell viewWithTag:2];
            lbl.text = [self.patienttestunits_arr objectAtIndex:indexPath.section];
            lbl.hidden=NO;
            //NSLog(@"cellcheck6");
            lbl=(UILabel*)[cell viewWithTag:3];
            lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.section];
            lbl.hidden=NO;
            //NSLog(@"cellcheck7");
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.section];
            lbl.hidden=NO;
            //NSLog(@"cellcheck8");
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            btn.hidden=NO;
            //NSLog(@"patientteststatus_arr value:%@",[self.patientteststatus_arr objectAtIndex:indexPath.row]);
            
            if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section] isEqualToString:@"Positive"]||[[self.patienttestvalue_arr objectAtIndex:indexPath.section] isEqualToString:@"Negative"]) {
                
                //NSLog(@"cellcheck9");
                [grphbtn setImage:[UIImage imageNamed:@"blankimg"] forState:UIControlStateNormal];
                grphbtn.hidden=YES;
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
                if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section] isEqualToString:@"Negative"]) {
                    //NSLog(@"cellcheck21");
                    
                    //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"Negative" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else{
                    //NSLog(@"cellcheck22");
                    //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    [btn setTitle:@"Positive" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                }
                lbl=(UILabel*)[cell viewWithTag:7];
                lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
            }else{
                btn.hidden=NO;
                grphbtn.hidden=NO;
                
                if ([[self.patienttestmaxvalue_arr objectAtIndex:indexPath.section]intValue]==0.0) {
                    
                    //NSLog(@"Check Ranges");
                    lbl=(UILabel*)[cell viewWithTag:6];
                    lbl.hidden=YES;
                    grphbtn.hidden=YES;
                }else{
                    if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]>[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.section]intValue]) {
                        //NSLog(@"cellcheck10");
                        //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                        btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                        [btn setTitle:@"High" forState:UIControlStateNormal];
                        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]<[[self.patienttestminvalue_arr objectAtIndex:indexPath.section]intValue]) {
                        //NSLog(@"cellcheck11");
                        // btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                        btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                        
                        [btn setTitle:@"Low" forState:UIControlStateNormal];
                        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                    }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]>=[[self.patienttestminvalue_arr objectAtIndex:indexPath.section]intValue] ||
                              [[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]<=[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.section]intValue]) {
                        //NSLog(@"cellcheck12");
                        //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                        btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                        
                        [btn setTitle:@"Normal" forState:UIControlStateNormal];
                        lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    }
                    lbl=(UILabel*)[cell viewWithTag:6];
                    
                    
                    NSString*strl = [NSString stringWithFormat:@"%@",[self.patienttestrange_arr objectAtIndex:indexPath.section]];
                    //NSLog(@"strlenth:%d",(int)strl.length);
                    /*
                     if (strl.length>10) {
                     lbl.font = [UIFont systemFontOfSize:8];
                     }
                     */
                    lbl.text = strl;
                    
                    lbl.hidden=NO;
                    //NSLog(@"cellcheck13");
                }
                
                lbl=(UILabel*)[cell viewWithTag:7];
                lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
            }
        }else{
            //NSLog(@"cellcheck14");
            //  grphbtn.hidden=YES;
            
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
            lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.section];
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.hidden=NO;
            lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.section];
            lbl=(UILabel*)[cell viewWithTag:6];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            btn.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:145.0/255.0 blue:50.0/255.0 alpha:1.0];
            
            [btn setTitle:@"Pending" forState:UIControlStateNormal];
            //btn.hidden=YES;
            
            [grphbtn setImage:nil forState:UIControlStateNormal];
            grphbtn.hidden=YES;
            
            
            //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
            //[btn setTitle:@"Pending" forState:UIControlStateNormal];
            //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==2){
        
        //NSLog(@"Group entred");
        //grphbtn.hidden=YES;
        //NSLog(@"patienttestdate_arr:%@",self.patienttestdate_arr);
        UILabel*lbl;
        
        UILabel*lbl_range;
        
        lbl_range=(UILabel*)[cell viewWithTag:1];
        lbl_range.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:2];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:3];
        lbl.hidden=NO;
        lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.section];
        lbl=(UILabel*)[cell viewWithTag:4];
        lbl.hidden=NO;
        lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.section];
        lbl=(UILabel*)[cell viewWithTag:6];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:7];
        lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        
        //NSLog(@"patienttest ready:%@",[self.patienttestisready objectAtIndex:indexPath.row]);
        if ([[self.patienttestisready objectAtIndex:indexPath.section]intValue]==1) {
            //NSLog(@"Pending check if");
            btn.hidden=YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if ([[self.patienttestisready objectAtIndex:indexPath.section]intValue]==0){
            //NSLog(@"Pending check else");
            btn.hidden=NO;
            btn.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:145.0/255.0 blue:50.0/255.0 alpha:1.0];
            [btn setTitle:@"Pending" forState:UIControlStateNormal];
        }
        UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        //[grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
        
        [grphbtn setImage:nil forState:UIControlStateNormal];
        grphbtn.hidden=YES;
        
        
        //cell.accessoryView
        
    }else if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==3){
        //NSLog(@"Panel");
        //grphbtn.hidden=YES;
        
        
        
        
        
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
        lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
        //NSLog(@"cellcheck15");
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        btn.hidden=YES;
        UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        [grphbtn setImage:nil forState:UIControlStateNormal];
        grphbtn.hidden=YES;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //grphbtn.hidden=YES;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.bounds.size.height*0.2;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"didselected1");
    /*
    if (self.autoCompleteFilterArray.count!=0) {
        //NSLog(@"didselected2");
        //self.autoCompleteFilterArray;
        self.autoCompleteFilterArray=nil;
        //NSLog(@"serviceids:%@",self.serviceid_arr);
       // [self getSearchResult:self.patientid_str :[self.serviceid_arr objectAtIndex:selectedindex]];
        //[self.tableView reloadData];
    }else{
    //NSLog(@"didselected3");
    }
    //UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    //autoCompleteField.text =Cell.textLabel.text;
    //NSLog(@"didselected4");
    [self.searchbar resignFirstResponder];
     */
    

    if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==2 && [[self.patienttestisready objectAtIndex:indexPath.section]intValue]!=0) {
        //NSLog(@"group entredee didselet");
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:@"detailreport"];
        
        detailreport.patientid_str = self.patientid_str;
        //NSLog(@"self.patientgrouptestname_arr did select:%@",self.patientgrouptestname_arr);
        detailreport.testdict = [self.patientgrouptestname_arr objectAtIndex:indexPath.section];
        //NSLog(@"group tests one:%@",[self.patientgrouptestname_arr objectAtIndex:indexPath.row]);
        //NSLog(@"group tests details:%@",detailreport.testdict);
        self.navigationController.title = [self.patienttestname_arr objectAtIndex:indexPath.section];

        [self.navigationController pushViewController:detailreport animated:YES];
        
        
    } else if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==3 && [[self.patienttestisready objectAtIndex:indexPath.section]intValue]!=0) {
        //NSLog(@"group entredee didselet 2");
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:@"detailreport"];
        
        detailreport.patientid_str = self.patientid_str;
        detailreport.paneltest_dict = [self.paneltests_arr objectAtIndex:indexPath.section];
        detailreport.panelgrps_dict = [self.panelgrps_arr objectAtIndex:indexPath.section];
        
        [self.navigationController pushViewController:detailreport animated:YES];
        
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text isEqualToString:@""]) {
        [_Dropobj fadeOut];
    }else{
   // //NSLog(@"Range:%@",NSStringFromRange(range));
    //NSLog(@"%@",searchText);
    
    //NSString *passcode = [searchText stringByReplacingCharactersInRange:range withString:string];
    
    ////NSLog(@"%@",passcode);
    
   // if ([str localizedCaseInsensitiveContainsString:searchText] == YES){
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchText];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[c]%@",searchText];
    
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY SELF = %@", passcode];
    
    //NSLog(@"self.servicename_arr:%@",self.servicename_arr);
    self.autoCompleteFilterArray = [self.servicename_arr filteredArrayUsingPredicate:predicate];
    //NSLog(@"autocompleteFilter:%@", self.autoCompleteFilterArray);
    /*
    if ([self.autoCompleteFilterArray count]==0) {
        self.tableView.hidden = TRUE;
    }else{
        self.tableView.hidden = FALSE;
    }
    */
    
    NSUInteger index = [self.servicename_arr  indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        //NSLog(@"idx:%lu",(unsigned long)idx);
        return [predicate evaluateWithObject:obj];
    }];
    
    selectedindex = (int)index;
    //NSLog(@"indexvalue:%d",(int)index);
    
    [_Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Search" withOption:self.autoCompleteFilterArray xy:CGPointMake(searchBar.frame.origin.x,searchBar.frame.origin.y+50) size:CGSizeMake((searchBar.frame.size.width), (self.view.frame.size.height-50)) isMultiple:NO];
    //NSLog(@"title feedback");
        
        //[self.tableView reloadData];
    }
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}



- (IBAction)backbaritemClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    NSString * storyboardName = @"Main";
    if([identifiername isEqualToString:@"dashboard"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:alrtmsg
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    [alert addAction:button0];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


@end
