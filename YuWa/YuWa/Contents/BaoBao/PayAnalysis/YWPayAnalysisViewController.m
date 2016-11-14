//
//  YWPayAnalysisViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/11/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPayAnalysisViewController.h"
#import "JHChartHeader.h"

@interface YWPayAnalysisViewController ()

@end

@implementation YWPayAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费分析";
    [self requestData];
}

- (void)showFirstQuardrantWithXLineDataArr:(NSArray *)xLineDataArr withValueArr:(NSArray *)valueArr{
    JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(0.f, 64.f, kScreen_Width, (kScreen_Height - 64.f)/2) andLineChartType:JHChartLineValueNotForEveryX];
    NSInteger allValue = 0;
    for (int i = 0; i < [valueArr[0] count]; i++) {
        allValue += [valueArr[0][i] integerValue];
    }
    allValue = (allValue/[valueArr[0] count])*2/5;
    NSInteger number = allValue;
    for (int i = 0; i < 100; i++) {
        if (number/10 <= 0) {
            allValue = number;
            for (int j = 0; j<i; j++) {
                allValue = allValue * 10;
            }
            break;
        }else{
            number = number/10;
        }
    }
    lineChart.yLineNumber = allValue;
    
    lineChart.xLineDataArr = xLineDataArr;
    lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    lineChart.valueArr = valueArr;
    lineChart.valueLineColorArr = @[[UIColor purpleColor], [UIColor brownColor]];//Line Chart colors
    lineChart.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor]];//Colors for every line chart
    lineChart.xAndYLineColor = [UIColor blackColor];//color for XY axis
    lineChart.xAndYNumberColor = [UIColor blueColor];// XY axis scale color
    lineChart.positionLineColorArr = @[[UIColor blueColor],[UIColor greenColor]];//Dotted line color of the coordinate point
    lineChart.contentFill = YES;//Set whether to fill the content, the default is False
    lineChart.pathCurve = YES;//Set whether the curve path
    lineChart.contentFillColorArr = @[[UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.468],[UIColor colorWithRed:0.500 green:0.214 blue:0.098 alpha:0.468]];//Set fill color array
    [self.view addSubview:lineChart];
    [lineChart showAnimation];
}

- (void)showColumnViewWithXShowInfoText:(NSArray *)xShowInfoText withValueArr:(NSArray *)valueArr{
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0.f, (kScreen_Height - 64.f)/2 + 64.f, kScreen_Width, (kScreen_Height - 64.f)/2)];
    column.valueArr = valueArr;
    column.originSize = CGPointMake(30, 30);//The first column of the distance from the starting point
    column.drawFromOriginX = 10;//Column width
    column.columnWidth = 40;//X, Y axis font color
    column.drawTextColorForX_Y = [UIColor greenColor];//X, Y axis line color
    column.colorForXYLine = [UIColor greenColor];//Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green
    column.columnBGcolorsArr = @[CNaviColor,[UIColor greenColor],[UIColor orangeColor]];//Module prompt
    column.xShowInfoText = xShowInfoText;
    [column showAnimation];
    [self.view addSubview:column];
}


#pragma mark - Http
- (void)requestData{
    
    [self showFirstQuardrantWithXLineDataArr:@[@"0",@"1",@"2",@3,@4,@5,@6,@7] withValueArr:@[@[@"100",@"120",@"100",@600,@400,@900,@600,@0]]];
    [self showColumnViewWithXShowInfoText:@[@"美食",@"周边游",@"生活服务",@"时尚购"] withValueArr:@[@[@120],@[@180],@[@12],@[@2]]];
}

@end
