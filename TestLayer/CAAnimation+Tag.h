//
//  CAAnimation+Tag.h
//  TestLayer
//
//  Created by DL on 15/2/4.
//  Copyright (c) 2015年 DL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Tag)
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,weak)CALayer *layer;
@end
