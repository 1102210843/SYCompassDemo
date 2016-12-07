//
//  ViewController.m
//  SYCompassDemo
//
//  Created by 陈蜜 on 16/6/27.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "ViewController.h"
#import "SYCompassView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SYCompassView *compassView = [SYCompassView sharedWithRect:self.view.bounds radius:(self.view.bounds.size.width-20)/2];
    compassView.backgroundColor = [UIColor blackColor];
    compassView.textColor = [UIColor whiteColor];
    compassView.calibrationColor = [UIColor whiteColor];
    compassView.horizontalColor = [UIColor purpleColor];
    [self.view addSubview:compassView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
