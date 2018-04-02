//
//  IMDIHLReport.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 29/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMDIHLReport.h"
#import "IMIHLReport.h"
#define ARC4RANDOM_MAX 0x100000000
@interface IMDIHLReport (){
    NSArray*patienttestrange_arr;
    NSArray*patienttestdate_arr;
    NSArray*patienttesttime_arr;
    NSArray*patientteststatus_arr;
    NSMutableArray*xChart_arr;
    float max_range,min_range;
    
    NSIndexPath *path;
   // UUChart *chartView;
    BOOL showgraph;
}




@property(nonatomic,retain)NSMutableArray*departmentstxtarr;
@property(nonatomic,retain)NSMutableArray*departmentsimgarr;
@property(nonatomic,retain)NSMutableArray*teststxtarr;


@property(nonatomic,retain)NSMutableArray*testyearsarr;
@property(nonatomic,retain)NSMutableArray*testMaxrangearr;
@property(nonatomic,retain)NSMutableArray*testMinrangearr;
@property(nonatomic,retain)NSMutableArray*testNormalrangearr;
//@property(nonatomic,retain)NSMutableArray*xChart_arr;

@property(nonatomic,retain)NSMutableArray*yChart_arr;
@property(nonatomic,retain)NSMutableArray*yMaxChart_arr;
@property(nonatomic,retain)NSMutableArray*yMinChart_arr;
@property(nonatomic,retain)NSMutableArray*colorChart_arr;










@end

@implementation IMDIHLReport

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.myreportbarbtnitem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];

    //[self allocateArray];
        //[self setData];
    xChart_arr = [[NSMutableArray alloc]init];
    self.colorChart_arr = [[NSMutableArray alloc]init];
    self.testMaxrangearr = [[NSMutableArray alloc]init];
    self.yMaxChart_arr = [[NSMutableArray alloc]init];
    
    [self setChartData];
    [self.reporttblView reloadData];
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
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    
    self.navigationController.navigationBarHidden = NO;
    self.myreportbarbtnitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.myreportbarbtnitem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.myreportbarbtnitem];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setData{
    
    max_range=35;
    min_range=15;
    self.departmentstxtarr = [[NSMutableArray alloc]init];
    self.departmentsimgarr = [[NSMutableArray alloc]init];
    self.teststxtarr = [[NSMutableArray alloc]init];
     //self.testyearsarr = [[NSMutableArray alloc]init];
    //self.testrangearr = [[NSMutableArray alloc]init];
    self.testMaxrangearr = [[NSMutableArray alloc]init];
    self.testMinrangearr = [[NSMutableArray alloc]init];
    self.testNormalrangearr = [[NSMutableArray alloc]init];
   
    
    NSArray*tmpdepttxtarr = [NSArray arrayWithObjects:@"Bio Chemistry",@"Hematology & Hemostasis",@"Immutology",@"Histopathology",@"Microbiology",@"infectious Molecular Biology",@"Pathology",@"Microbiology",@"Toxicology",@"Urin", nil];
    [self.departmentstxtarr setArray:tmpdepttxtarr];
    NSArray*tmpdeptimgarr = [NSArray arrayWithObjects:@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon",@"deptmolecularicon", nil];
    [self.departmentsimgarr setArray:tmpdeptimgarr];
    
    NSArray*tmptesttxtarr = [NSArray arrayWithObjects:@"CBC",@"Lipid Profile",@"Hemoglobin",@"Test1",@"CBC",@"Lipid Profile",@"Hemoglobin",@"Test1",@"Test2",@"Test3",nil];
    [self.teststxtarr setArray:tmptesttxtarr];
    
    
    //NSArray*tmpTestMaxRange = [NSArray arrayWithObjects:@"41.2", @"18.2", @"32.2", @"16.2",@"15.2",@"22.2",@"36.2",@"34.2",@"10.2",@"21.2",nil];
    
    //self.testMaxrangearr =
    patienttestrange_arr = [NSArray arrayWithObjects:@"41.2", @"18.2", @"32.2", @"16.2",@"15.2",@"22.2",@"36.2",@"34.2",@"10.2",@"21.2",nil];
    patienttestdate_arr = [NSArray arrayWithObjects:@"24th Jan 2016", @"29th Jan 2016", @"2th Feb 2016", @"12th Feb 2016",@"5th Mar 2016",@"15th Mar 2016",@"10th Apr 2016",@"16th May 2016",@"25th May 2016",@"20th Jun 2016",nil];
    patienttesttime_arr = [NSArray arrayWithObjects:@"10.30pm", @"10.30pm", @"10.30pm", @"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",nil];
    patientteststatus_arr = [NSArray arrayWithObjects:@"High", @"Normal", @"Normal", @"Normal",@"Normal",@"Normal",@"High",@"Normal",@"Low",@"Normal",nil];
    

    self.navigationController.navigationBarHidden=NO;
        //[self loadBarChartUsingArray];
    //[self setDataInChart:0];


}



-(void)setChartData{
    
    self.deptName_lbl.text = self.departmentname_str;
    self.testName_lbl.text = [self.patienttestname_arr objectAtIndex:0];
    
    
    //NSLog(@"cahrtncmcmdkmc");
   // int index = [self.selected_index intValue];
    //NSLog(@"indexvalue:%d",index);
    //NSLog(@"patienttestmaxvalue_arr:%@",self.patienttestmaxvalue_arr);
    //NSLog(@"testrange:%@",self.patienttestrange_arr);
    
    max_range=[[self.patienttestmaxvalue_arr objectAtIndex:self.patienttestmaxvalue_arr.count-1]floatValue];
    min_range=[[self.patienttestminvalue_arr objectAtIndex:self.patienttestminvalue_arr.count-1]floatValue];

   
    //[self.yMaxChart_arr addObject:[self.patienttestmaxvalue_arr objectAtIndex:index]];
    
    //NSLog(@"check1");
   // //NSLog(@"testyears:%@",[patienttestdate_arr objectAtIndex:0]);
   // [xChart_arr addObject:[self.patienttestdate_arr objectAtIndex:index]];
    
    //NSLog(@"check2");
    //NSLog(@"testnamessss:%@",self.patienttestname_arr);
    
        NSMutableArray*arrtestname = [[NSMutableArray alloc]init];
    NSMutableArray*arrrangename = [[NSMutableArray alloc]init];
    NSMutableArray*arrdatename = [[NSMutableArray alloc]init];
    NSMutableArray*arrmaindatename = [[NSMutableArray alloc]init];
    
    for (int i=0;i<self.patienttestname_arr.count;i++) {
        if ([[self.patienttestisready objectAtIndex:i]intValue]==1) {
            
            //NSLog(@"max in loop:%@",[self.patienttestminvalue_arr objectAtIndex:i]);
            if ([[self.patienttestvalue_arr objectAtIndex:i]floatValue]<min_range) {
                //NSLog(@"min");
                min_range = [[self.patienttestvalue_arr objectAtIndex:i]floatValue];
                //NSLog(@"min value:%f",min_range);
                
            }else if ([[self.patienttestvalue_arr objectAtIndex:i]floatValue]>max_range){
                //NSLog(@"max");
                max_range = [[self.patienttestvalue_arr objectAtIndex:i]floatValue];
                //NSLog(@"max value:%f",max_range);
            }
            
            [arrtestname addObject:[self.patienttestname_arr objectAtIndex:i]];
            [arrrangename addObject:[self.patienttestvalue_arr objectAtIndex:i]];
            [arrdatename addObject:[self.patienttestmaxvalue_arr objectAtIndex:i]];
            [arrmaindatename addObject:[self.patienttestdate_arr objectAtIndex:i]];
        }
    }
    //NSLog(@"self.patienttestvalue_arr check2:%@",self.patienttestvalue_arr);
    if (arrtestname.count==0) {
        //NSLog(@"self.patienttestvalue_arr check1:%@",self.patienttestvalue_arr);
        self.testMaxrangearr =self.patienttestvalue_arr;
        self.yMaxChart_arr = self.patienttestmaxvalue_arr;
        //NSLog(@"self.patienttestdate_arr:%@",self.patienttestdate_arr);
        xChart_arr = self.patienttestdate_arr;

    }else{
        [self.patienttestname_arr removeAllObjects];
        [self.patienttestvalue_arr removeAllObjects];
        [self.patienttestmaxvalue_arr removeAllObjects];
        [self.patienttestdate_arr removeAllObjects];
        [xChart_arr removeAllObjects];
        //NSLog(@"arrmaindatename:%@",arrmaindatename);
        self.testMaxrangearr =arrrangename;
        self.yMaxChart_arr = arrdatename;
        xChart_arr = arrmaindatename;
        //NSLog(@"xChart_arr:%@",xChart_arr);
        
        self.patienttestname_arr = arrtestname;
        self.patienttestvalue_arr =arrrangename;
        self.patienttestmaxvalue_arr=arrdatename;
        self.patienttestdate_arr=arrmaindatename;
    }
    /*
    for (int i=0; i<self.patienttestname_arr.count; i++) {
        
    
    if ([[self.patienttestvalue_arr objectAtIndex:i] integerValue]>max_range) {
        //NSLog(@"greater max_range");
        max_range = [[self.patienttestvalue_arr objectAtIndex:i] floatValue];
        [self.colorChart_arr addObject:PNRed];
        //[self.testMaxrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
    }else if ([[self.patienttestvalue_arr objectAtIndex:i] integerValue]<min_range){
        min_range = [[self.patienttestvalue_arr objectAtIndex:i] floatValue];
        [self.colorChart_arr addObject:PNStarYellow];
        //NSLog(@"lessthan min_range");
        //[self.testMinrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
    }else{
        [self.colorChart_arr addObject:PNGreen];
        //[self.testNormalrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
    }
        if (xChart_arr.count<2) {
        //[xChart_arr addObject:@""];
        }
        
        
    }
     */
    
    //[xChart_arr addObject:@""];
    //[xChart_arr addObject:@""];
    

//NSLog(@"check3");
  //[self barChartView];
    [self lineChartView];
    [self.reporttblView reloadData];

}


-(void)setDataInChart:(int)index{
    
    
    //NSLog(@"index value:%d",index);
    int n=0;
    //[xChart_arr removeAllObjects];
   // [self.testMaxrangearr removeAllObjects];
    //[self.testMinrangearr removeAllObjects];
    // [self.testNormalrangearr removeAllObjects];
    for (int i=0; i<self.patienttestid_arr.count; i++) {
        //NSLog(@"entred in loooop....");
        if (n<4) {
            //NSLog(@"n=%d",n);
            if ([[self.teststxtarr objectAtIndex:index] isEqualToString:[self.teststxtarr objectAtIndex:i]]) {
                //NSLog(@"testyears:%@",[patienttestdate_arr objectAtIndex:i]);
                [xChart_arr addObject:[patienttestdate_arr objectAtIndex:i]];
                
                 if ([[patienttestrange_arr objectAtIndex:i] integerValue]>max_range) {
                 //NSLog(@"greater max_range");
                     
                     [self.colorChart_arr addObject:PNRed];
                 //[self.testMaxrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
                 }else if ([[patienttestrange_arr objectAtIndex:i] integerValue]<min_range){
                     [self.colorChart_arr addObject:PNLightYellow];
                 //NSLog(@"lessthan min_range");
                 //[self.testMinrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
                 }else{
                     [self.colorChart_arr addObject:PNGreen];
                 //[self.testNormalrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
                 }
                
                [self.testMaxrangearr addObject:[patienttestrange_arr objectAtIndex:i]];
                n++;
            }
        }
        
        /*
        if (self.patienttestid_arr.count==2) {
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
        }else if (self.patienttestid_arr.count==3){
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            
        }else if (self.patienttestid_arr.count==4){
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];

        }else if (self.patienttestid_arr.count==5){
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
            [xChart_arr addObject:@" "];
        
        }
         */
        
    }
    
        //[self barChartView];
    
   // [self lineChartView];
}



-(CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}

-(void)lineChartView{
    //NSLog(@"entred in line chart");
    //self.reports_tblview.hidden=YES;
    
    //self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
   // self.lineChart.frame = CGRectMake(0, self.lineChart.frame.origin.y, self.lineChart.bounds.size.width, self.lineChart.bounds.size.height/0.5);
    //self.lineChart.frame = CGRectMake(0, self.lineChart.frame.origin.y, 300, 800);
   // self.lineChart.chartCavanHeight=self.lineChart.frame.size.height/2;
   self.lineChart.yLabelFormat = @"%2.1f";
    
   //self.lineChart.chartMarginLeft = self.lineChart.bounds.origin.x;
    //self.lineChart.chartMarginRight = 25.0;
    
    //NSLog(@"self.linchart size:%f",self.view.bounds.size.width);
    //NSLog(@"self.linchart height:%f",self.lineChart.frame.size.height);
    
    if (self.view.bounds.size.width>=350) {
        //NSLog(@"if in");
        //self.lineChart.chartCavanHeight=self.lineChart.frame.size.height/2;
       self.lineChart.chartCavanHeight=self.lineChart.frame.size.height*0.8;
        self.lineChart.chartMarginLeft=20.0f;
        self.lineChart.chartMarginTop = 35.0f;
        self.lineChart.chartMarginBottom = 35.0f;
        self.lineChart.chartMarginRight=10.0;
        [self.lineChart setXLabels:xChart_arr withWidth:80];
    }else{
        //NSLog(@"else in");
       // self.lineChart.chartCavanHeight=self.lineChart.frame.size.height*0.8;
        self.lineChart.chartMarginLeft=20.0;
        self.lineChart.chartMarginTop = 18.0;
        self.lineChart.chartMarginBottom = 20.0;
        self.lineChart.chartMarginRight=14.0;
        [self.lineChart setXLabels:xChart_arr withWidth:50];
    
    }
    
    self.lineChart.backgroundColor = [UIColor clearColor];
    //[self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
   // [self.lineChart setXLabels:xChart_arr];
    
 // self.lineChart.showCoordinateAxis = YES;
    //self.lineChart.showYGridLines=YES;
   // self.lineChart.yLabelFont=[UIFont systemFontOfSize:15];
    self.lineChart.showSmoothLines=YES;
    
    
   // self.lineChart.xLabelFont = [UIFont systemFontOfSize:[self screenSize].width/5];
   // [self.lineChart setYLabelFont:[UIFont systemFontOfSize:10.0f]];
   // self.lineChart.yLabelFont=[UIFont systemFontOfSize:22.0f weight:1.0f];
   // self.lineChart.yLabelHeight=15.0f;
    self.lineChart.showLabel=YES;
    //NSLog(@"xChart_arr line:%@",xChart_arr);
    
   //[self.lineChart setXLabels:xChart_arr withWidth:self.lineChart.bounds.size.width/4.83];
   // self.lineChart.xLabels=xChart_arr;
    //self.lineChart.xChartLabels=xChart_arr;
    //self.lineChart.xLabelWidth=self.lineChart.bounds.size.width/10;
    //self.lineChart.showGenYLabels=YES;
   
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
   // self.lineChart.yFixedValueMax = 300.0;
   // self.lineChart.yFixedValueMin = 0.0;
   // self.lineChart.xLabelWidth=[self screenSize].width/5;
    
    //self.lineChart.yFixedValueMax = max_range+50;
    
    
    
    
    
    //NSLog(@"min_range:%f",min_range);
    //NSLog(@"max_range:%f",max_range);
    
/*
    [self.lineChart setYLabels:@[
                                 @"0 min",
                                 @"50 min",
                                 @"100 min",
                                 @"150 min",
                                 @"200 min",
                                 @"250 min",
                                 @"300 min",
                                 ]
     ];
    
  */
    
    
    
    
    /*
    // Line Chart #1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
     */
    
    // Line Chart #2
   // NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    
    
    
    
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"Beta";
    data02.color = PNTwitterColor;
    //data02.inflexionPointColor = PNiOSGreenColor;
    data02.showPointLabel=YES;
    data02.pointLabelFont=[UIFont systemFontOfSize:12.0f];
    data02.alpha = 0.5f;
    //data02.itemCount = data02Array.count;
    data02.itemCount = self.testMaxrangearr.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
      //  CGFloat yValue = [data02Array[index] floatValue];
        CGFloat yValue = [self.testMaxrangearr[index] floatValue];
        //NSLog(@"yValue:%f",yValue);
        if (yValue>max_range) {
            max_range = yValue;
        }
        
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    self.lineChart.yFixedValueMax = max_range;
    self.lineChart.yFixedValueMin = min_range;
    
   //self.lineChart.chartData = @[data01, data02];
    self.lineChart.chartData = @[data02];
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
   
    
    //self.lineChart.legendStyle = PNLegendItemStyleStacked;
    //self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    //self.lineChart.legendFontColor = [UIColor redColor];
    /*
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];
*/

}


-(void)barChartView{
    //NSLog(@"check4");
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        //barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.numberStyle = NSNumberFormatterNoStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
    //self.titleLabel.text = @"Bar Chart";
    
   //     self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    
    //        self.barChart.showLabel = NO;
    
    //self.barChart.frame = CGRectMake(0, self.barChart.frame.origin.y, self.view.frame.size.width, self.barChart.frame.size.height);
    
   // self.barChart.frame = CGRectMake(0, self.barChart.frame.origin.y, [self screenSize].width, [self screenSize].height/2.5);
    
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
    };
    /*
    self.barChart.yChartLabelWidth = 20.0;
    self.barChart.chartMarginLeft = 30.0;
    self.barChart.chartMarginRight = 10.0;
    self.barChart.chartMarginTop = 5.0;
    self.barChart.chartMarginBottom = 10.0;
     */
    
    self.barChart.yChartLabelWidth = 15.0;
    self.barChart.chartMarginLeft = 15.0;
    self.barChart.chartMarginRight = 5.0;
    self.barChart.chartMarginTop = 5.0;
   self.barChart.chartMarginBottom = 5.0;

    
   // self.barChart.xLabelWidth = 20.0;
    
   // [self.barChart setXLabels:xChart_arr];
    
    self.barChart.labelMarginTop = 5.0;
     self.barChart.labelFont = [UIFont systemFontOfSize:12.0];
    self.barChart.showChartBorder = YES;
    
    
      [self.barChart setXLabels:xChart_arr];
    

   //[self.barChart setXLabels:@[[xChart_arr objectAtIndex:0],@"",@"",@""]];
    //[self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
    //       self.barChart.yLabels = @[@-10,@0,@10];
    //        [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
    //[self.barChart setYValues:@[@10.82,@1.88,@6.96,@33.93,@10.82,@1.88,@6.96,@33.93]];
    //[self.barChart setYLabels:self.testMaxrangearr];
    
    //NSLog(@"check5");
    [self.barChart setXLabelWidth:[self screenSize].width/5];
   // [self.barChart setXLabels:xChart_arr];
    
    [self.barChart setYMaxValue:(max_range+100)];
    [self.barChart setYMinValue:min_range];
    
    //[self.barChart setYLabels:self.yMaxChart_arr];
    [self.barChart setYValues:self.testMaxrangearr];
    
    
    //[self.barChart setStrokeColors:@[PNGreen,PNRed]];
    [self.barChart setStrokeColors:self.colorChart_arr];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = YES;
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    //[self.view addSubview:self.barChart];
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    //NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    //NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

- (void)userClickedOnBarAtIndex:(NSInteger)barIndex
{
    
    //NSLog(@"Click on bar %@", @(barIndex));
    
    PNBar * bar = [self.barChart.bars objectAtIndex:barIndex];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = @1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = @1.1;
    animation.duration = 0.2;
    animation.repeatCount = 0;
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [bar.layer addAnimation:animation forKey:@"Float"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeReportDateClick:(id)sender {
}

- (IBAction)myReportBackClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"labreport"];
}

#pragma mark - Load ViewControllers
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    if ([identifiername isEqualToString:@"labreport"]) {
        /*
        IMIHLReport * myvc = [storyboard instantiateViewControllerWithIdentifier:@"labreport"];
        myvc.patientid_str = self.patientid_str;
       // myvc.patientname_str = self.patientname_str;
        myvc.tempreportdict = self.tempreportdict;
        [self.navigationController pushViewController:myvc animated:YES];
         */
        //NSLog(@"labreport");
        
        IMIHLReport * mrvc = [storyboard instantiateViewControllerWithIdentifier:@"labreport"];
        mrvc.patientid_str = self.patientid_str;
        mrvc.id_str =@"0";
        mrvc.datestore_str = self.filterdateshow_str;
        mrvc.tempreportdict = self.tempreportdict;
        [self.navigationController pushViewController:mrvc animated:YES];
    }else{
    
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    }
}





//////////////////////////////TableView Delegate Methods/////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"count patient names:%d",(int)self.patienttestname_arr.count);
    return self.patienttestname_arr.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    //NSLog(@"cell for row at index");
    static NSString *CellIdentifier = @"testlisttblcell";
    
    UITableViewCell *cell = [self.reports_tblview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    self.reports_tblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //mtable.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    
    
    //NSLog(@"cellcheck1");
    //if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==1) {
        //NSLog(@"cellcheck2");
        
        
        //if ([[self.patienttestisready objectAtIndex:indexPath.row]intValue]==1) {
            
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
            
            if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row] isEqualToString:@"Positive"]||[[self.patienttestvalue_arr objectAtIndex:indexPath.row] isEqualToString:@"Negative"]) {
                
                //NSLog(@"cellcheck9");
                
                
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
                    
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"Negative" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else{
                    //NSLog(@"cellcheck22");
                    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    [btn setTitle:@"Positive" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                }
                
            }else{
                
               
                if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]>[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck10");
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"High" forState:UIControlStateNormal];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];                }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]<[[self.patienttestminvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck11");
                        btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                        
                        [btn setTitle:@"Low" forState:UIControlStateNormal];
                        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
                }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]>=[[self.patienttestminvalue_arr objectAtIndex:indexPath.row]intValue] ||
                          [[self.patienttestvalue_arr objectAtIndex:indexPath.row]intValue]<=[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.row]intValue]) {
                    //NSLog(@"cellcheck12");
                    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    
                    [btn setTitle:@"Normal" forState:UIControlStateNormal];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];                }
                lbl=(UILabel*)[cell viewWithTag:6];
                
                NSString*strl = [NSString stringWithFormat:@"%@",[self.patienttestrange_arr objectAtIndex:indexPath.row]];
                //NSLog(@"strlenth:%d",(int)strl.length);
                if (strl.length>10) {
                    lbl.font = [UIFont systemFontOfSize:8];
                }
                lbl.text = strl;
                //lbl.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck13");
            }
            
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.row];
            
    

/*}else{
        
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
            //lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.row];
            lbl.hidden=YES;
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            btn.hidden=YES;
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
        }
 */
    
    /*
        else{
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
            btn.hidden=YES;
            //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
            //[btn setTitle:@"Pending" forState:UIControlStateNormal];
            //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
            
            
            
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
     */
   /*
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
        
    }else if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==3){
        //NSLog(@"Panel");
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
        //NSLog(@"cellcheck15");
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        btn.hidden=YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    */
    return cell;
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"didselect method.....");
    //NSLog(@"didselect type:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:@"detailreport"];
    self.navigation_name_str = [self.patienttestname_arr objectAtIndex:indexPath.row];
    
    
    self.navigationController.title=self.navigation_name_str;
    
    if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==2) {
        //NSLog(@"group entredee didselet");
        
        detailreport.testdict = [self.patientgrouptestname_arr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailreport animated:YES];
        
        
    } else if ([[self.patienttesttype_arr objectAtIndex:indexPath.row]intValue]==3) {
        //NSLog(@"group entredee didselet 2");
        detailreport.paneltest_dict = [self.paneltests_arr objectAtIndex:indexPath.row];
        detailreport.panelgrps_dict = [self.panelgrps_arr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailreport animated:YES];
        
    }
}
*/

@end