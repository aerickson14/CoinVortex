//
//  GameScene.m
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import "GameScene.h"
#import "Collector.h"
#import "Coin.h"
#import "CoinEmitter.h"
#import "Constants.h"

@interface GameScene () <SKPhysicsContactDelegate>
@property (strong, nonatomic) Collector *collector;
@end

static NSInteger const GameSceneBorderPadding = 10;
static CGPoint const GameSceneMidPoint = { 0.5, 0.5 };
static CGPoint const GameSceneTopLeftPoint = { 1, 1 };
static CGPoint const GameSceneBottomMiddlePoint = { 0.5, 0 };

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
	[self setUpWorld];
	CGPoint topRight = CGPointMake(self.frame.size.width / 2 - GameSceneBorderPadding, self.frame.size.height / 2 - GameSceneBorderPadding);
	[self addFieldNodeAtPosition:topRight];
	[self addCollectorAtPosition:topRight];
    
    [self showFirstHelpMessage];
}

- (void)setUpWorld {
	self.anchorPoint = GameSceneMidPoint;
	self.physicsWorld.gravity = CGVectorMake(0, 0);
	self.physicsWorld.contactDelegate = self;

	SKNode *bounds = [SKNode node];
	bounds.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	bounds.physicsBody.categoryBitMask = GameSpriteCategoryBounds;
	bounds.physicsBody.collisionBitMask = GameSpriteCategoryCoin;

	[self addChild:bounds];
}

- (void)addFieldNodeAtPosition:(CGPoint)position {
	SKFieldNode *fieldNode = [SKFieldNode radialGravityField];
	fieldNode.enabled = YES;
	fieldNode.categoryBitMask = GameSpriteCategoryGravityField;
	fieldNode.strength = 40;
	fieldNode.falloff = 1.1; //Objects move slightly faster as they become closer to the field
	fieldNode.position = position;

	[self addChild:fieldNode];
}

- (void)addCollectorAtPosition:(CGPoint)position {
	self.collector = [Collector collector];
	self.collector.anchorPoint = GameSceneTopLeftPoint;
	self.collector.position = position;

	[self addChild:self.collector];
}

- (void)addCoinEmitter {
    CoinEmitter *coinEmitter = [CoinEmitter coinEmitter];
    coinEmitter.anchorPoint = GameSceneBottomMiddlePoint;
    coinEmitter.position = CGPointMake(0, -self.frame.size.height/2 + 20);
    
    [self addChild: coinEmitter];
    
    SKAction *releaseCoinAction = [SKAction performSelector:@selector(releaseCoin) onTarget:coinEmitter];
    SKAction *waitOneSecond = [SKAction waitForDuration:1];
    SKAction *releaseCoinActionSequence = [SKAction sequence:@[waitOneSecond, releaseCoinAction]];
    [self runAction: [SKAction repeatActionForever:releaseCoinActionSequence]];
    
}

- (void)showFirstHelpMessage {
    
    SKLabelNode *explainLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    explainLabel.fontSize = 20;
    explainLabel.text = @"Coins are released from the bottom of the screen every second";
    [self addChild: explainLabel];
    
    CGPoint bottomPosition = CGPointMake(0, -self.frame.size.height/2 + explainLabel.fontSize);
    NSLog(@"%f,%f", bottomPosition.x, bottomPosition.y);
    SKAction *moveToBottom = [SKAction moveTo:bottomPosition duration:1];
    
    [explainLabel runAction: moveToBottom completion:^{
        [self clearLabel:explainLabel afterDuration:3 completion:^{
            [self showSecondHelpMessage];
        }];
    }];
}

- (void)showSecondHelpMessage {
    SKLabelNode *helpLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    helpLabel.fontSize = 30;
    helpLabel.text = @"Tap the screen to collect even more coins!";
    
    [self addChild: helpLabel];
    
    [self clearLabel:helpLabel afterDuration:3 completion:^{
        [self addCoinEmitter];
    }];
}

- (void)clearLabel:(SKLabelNode *)label afterDuration:(NSTimeInterval)waitSeconds completion:(void (^)(void))completion {
    
    SKAction *wait = [SKAction waitForDuration:waitSeconds];
    SKAction *fadeOut = [SKAction scaleBy:0 duration:0.5];
    SKAction *fadeOutSequence = [SKAction sequence:@[wait, fadeOut]];
    [label runAction: fadeOutSequence completion: completion];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		[self createCoinAtPosition:[touch locationInNode:self]];
	}
}

- (void)createCoinAtPosition:(CGPoint)position {
	Coin *coin = [Coin coin];
	coin.position = position;
	[self addChild:coin];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
	SKNode *coin = nil;

	if ([contact.bodyA.node.name isEqualToString:@"coin"] && [contact.bodyB.node.name isEqualToString:@"collector"]) {
		coin = contact.bodyA.node;
	}
	else if ([contact.bodyB.node.name isEqualToString:@"coin"] && [contact.bodyA.node.name isEqualToString:@"collector"]) {
		coin = contact.bodyB.node;
	}

	if (coin != nil) {
		[coin removeFromParent];
		[self.collector addPoint];
	}
}

@end
