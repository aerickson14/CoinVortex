//
//  CoinEmitter.m
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import "CoinEmitter.h"
#import "Coin.h"

@implementation CoinEmitter

+ (instancetype)coinEmitter {
	return [[CoinEmitter alloc] init];
}

- (instancetype)init {
	if (self = [super init]) {
	}

	return self;
}

- (void)releaseCoin {
	Coin *coin = [Coin coin];

	coin.alpha = 0;
	coin.position = self.position;
	coin.physicsBody.dynamic = NO;
	[self.parent addChild:coin];

	SKAction *fadeIn = [SKAction fadeInWithDuration:0];
	SKAction *blinkIn = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1 duration:0.2];
	SKAction *blinkOut = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:0 duration:0.2];
	SKAction *startSequence = [SKAction sequence:@[fadeIn, blinkIn, blinkOut]];

	[coin runAction:startSequence completion: ^{
	    coin.physicsBody.dynamic = YES;

	    CGFloat dx = arc4random_uniform(5);
	    dx -= 2; //do this after to prevent overflow of the unsigned int
	    CGFloat dy = arc4random_uniform(3);

	    CGVector impulseVector = CGVectorMake(dx, dy);
	    [coin.physicsBody applyImpulse:impulseVector];
	}];
}

@end
