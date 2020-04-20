//
//  ViewController.m
//  iOSDevTips
//
//  Created by panwei on 2020/4/19.
//  Copyright © 2020 WeirdPan. All rights reserved.
//

#import "ViewController.h"
#import "PPPermanentThreadVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PPPermanentThreadVC *vc = [PPPermanentThreadVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
