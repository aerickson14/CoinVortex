//
//  Collector.m
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import "Collector.h"
#import "Constants.h"

@interface Collector ()
@property (nonatomic) NSInteger points;
@property (strong, nonatomic) SKSpriteNode *target;
@property (strong, nonatomic) SKLabelNode *scoreLabel;
@end

@implementation Collector

+ (instancetype)collector {
	return [[Collector alloc] init];
}

- (instancetype)init {
	if ((self = [super init])) {
		self.target = [SKSpriteNode spriteNodeWithImageNamed:@"collector"];
		self.target.anchorPoint = CGPointMake(1, 1);
		self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
		self.scoreLabel.text = [self getLabelText];
		self.scoreLabel.position = CGPointMake(-self.target.frame.size.width - 10, -self.scoreLabel.frame.size.height / 2);
		self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
		self.scoreLabel.fontColor = [UIColor whiteColor];
		self.scoreLabel.fontSize = 20;

		[self addChild:self.target];
		[self addChild:self.scoreLabel];

		self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[self calculateAccumulatedFrame].size];
		self.physicsBody.categoryBitMask = GameSpriteCategoryCollector;
		self.physicsBody.affectedByGravity = NO;
		self.physicsBody.contactTestBitMask = GameSpriteCategoryCoin;
		self.name = @"collector";
		self.physicsBody.dynamic = NO;
	}

	return self;
}

- (void)addPoint {
	self.points++;
	self.scoreLabel.text = [self getLabelText];
}

- (NSString *)getLabelText {
    return [NSString stringWithFormat:@"%@", @(self.points)];
}

@end
