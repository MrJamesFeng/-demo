//
//  ViewController.m
//  对象模型
//
//  Created by LDY on 17/3/27.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

void ReportFouction(id self,SEL _cmd){
    
    NSLog(@"%s",__func__);
    NSLog(@"%p %@ %@",self,[self class],[self superclass]);
    Class currentClass = [self class];
    for (int i=1; i<5; i++) {
        NSLog(@"%p",currentClass);
        currentClass = object_getClass(currentClass);//isa
    }
    NSLog(@"%p",[NSObject class]);
    NSLog(@"%p",object_getClass([NSObject class]));//isa
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建类
    Class NewClass = objc_allocateClassPair([UIView class], "NewClass", 0);
    //添加方法
    class_addMethod(NewClass, @selector(newFounction), (IMP)(ReportFouction), "v@:");
    //注册类
    objc_registerClassPair(NewClass);
    //实例化
    id newClass = [[NewClass alloc]init];
    //对象方法
    [newClass performSelector:@selector(newFounction)];
}

-(void)newFounction{
    NSLog(@" SSSSSS ");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
