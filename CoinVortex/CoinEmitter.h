//
//  CoinEmitter.h
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CoinEmitter : SKSpriteNode

+ (instancetype)coinEmitter;

- (void)releaseCoin;

@end
