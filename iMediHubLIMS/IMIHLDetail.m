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
#import "ALTest.h"
#import "IMIHLReportValue.h"
@interface IMIHLDetail ()
@property (strong,nonatomic)NSMutableArray<ALTest*>*listOfTests;

@end

@implementation IMIHLDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTestDataInTable];
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backbaritem_btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backbaritem_btn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backbaritem_btn];
}
-(void)setTestDataInTable{
    self.listOfTests = [NSMutableArray new];
    IMIHLReportValue*reportValue = [IMIHLReportValue new];
    for (NSDictionary*dict in self.groupObj.grouptests) {
       ALTest*testObj = [reportValue setDataForAlTestObj:dict];
        [self.listOfTests addObject:testObj];
    }
    [self.detailreports_tblview reloadData];
}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    
    return self.listOfTests.count;
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
    
    ALTest*testObj = [self.listOfTests objectAtIndex:indexPath.section];
        
        //NSLog(@"cellcheck2");
         UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        /*
        UIButton*grphbtn = (UIButton*)[cell viewWithTag:8];
        
        [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
        [grphbtn setTag:indexPath.row];
        [grphbtn addTarget:self action:@selector(graphBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        */
        
        
        
        if ([testObj.isentered isEqualToString:@"1"]) {
            
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
            lbl_range.text = testObj.testranges;
            //NSLog(@"cellcheck5");
            lbl=(UILabel*)[cell viewWithTag:2];
            lbl.text = testObj.testunits;
            //NSLog(@"cellcheck6");
            lbl=(UILabel*)[cell viewWithTag:3];
            lbl.text = testObj.testdatesplit;
            //NSLog(@"cellcheck7");
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.text = testObj.testtimesplit;
            //NSLog(@"cellcheck8");
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            
            //NSLog(@"patientteststatus_arr value:%@",[self.patientteststatus_arr objectAtIndex:indexPath.row]);
            //NSLog(@"self.patienttestvalue_arr:%@",self.patienttestvalue_arr);
            if ([testObj.testresultvalue isEqualToString:@"Positive"]||[testObj.testresultvalue isEqualToString:@"Negative"]) {
                
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
                if ([testObj.testresultvalue isEqualToString:@"Negative"]) {
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
                
                if ([testObj.testresultvalue intValue]>[testObj.testmaxvalue intValue]) {
                    //NSLog(@"cellcheck10");
                   // btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"High" forState:UIControlStateNormal];
                   // lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];;
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else if ([testObj.testresultvalue intValue]<[testObj.testminvalue intValue]) {
                    //NSLog(@"cellcheck11");
                    //btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                    [btn setTitle:@"Low" forState:UIControlStateNormal];
                   // lbl_range.textColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                }else if ([testObj.testresultvalue intValue]>=[testObj.testminvalue intValue] ||
                          [testObj.testresultvalue intValue]<=[testObj.testmaxvalue intValue]) {
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
                
                
               
                
                lbl.text = testObj.testranges;
                
               // lbl.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck13");
                
                
                
                /*
                lbl=(UILabel*)[cell viewWithTag:6];
                lbl.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                 */
                //NSLog(@"cellcheck13");
            }
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = testObj.testname;
            
            
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
            lbl.text = testObj.testdatesplit;
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.hidden=NO;
            lbl.text = testObj.testtimesplit;
            lbl=(UILabel*)[cell viewWithTag:6];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = testObj.testname;
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


    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}




-(IBAction)graphBtnClicked:(id)sender{
    UIButton*tagbutton = (UIButton*)sender;
    int tagvalue = (int)tagbutton.tag;
    
    NSString * storyboardName = @"Main";

    //[self loadViewControllerFromStoryBoard:@"reportgraph"];
    
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
