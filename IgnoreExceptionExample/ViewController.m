//
//  ViewController.m
//  IgnoreExceptionExample
//
//  Created by zhangbin on 15/3/30.
//  Copyright (c) 2015年 godbe. All rights reserved.
//

#import "ViewController.h"
#import "IgnoreException.h"

@interface ViewController ()

- (IBAction)msgMissing:(id)sender;
- (IBAction)adressError:(id)sender;
- (IBAction)uninstall:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)msgMissing:(id)sender {
    [self performSelector:@selector(aaa) withObject:nil];
}

//inorder to test exc_bad_address,we forbidden arc
- (IBAction)adressError:(id)sender {
    [(UIButton *)0x1234 setTitle:@"hello" forState:UIControlStateNormal];
}

- (IBAction)uninstall:(id)sender {
    [IgnoreException unInstallIgnoreException];
}
@end
