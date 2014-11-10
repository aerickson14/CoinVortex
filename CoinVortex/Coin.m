//
//  Coin.m
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import "Coin.h"
#import "Constants.h"

@implementation Coin

+ (instancetype)coin {
	return [[Coin alloc] init];
}

- (instancetype)init {
	if ((self = (Coin *)[SKSpriteNode spriteNodeWithImageNamed:@"coin"])) {
		self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
		self.physicsBody.fieldBitMask = GameSpriteCategoryGravityField;
		self.physicsBody.categoryBitMask = GameSpriteCategoryCoin;
		self.physicsBody.collisionBitMask = GameSpriteCategoryBounds;
		self.physicsBody.contactTestBitMask = GameSpriteCategoryCollector;
		self.name = @"coin";
	}

	return self;
}

@end
