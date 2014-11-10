//
//  GameViewController.m
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
	[super viewDidLoad];

    SKView *skView = (SKView *)self.view;
	skView.ignoresSiblingOrder = YES;
    
	GameScene *scene = [[GameScene alloc] initWithSize:skView.frame.size];
	scene.scaleMode = SKSceneScaleModeAspectFill;

	[skView presentScene:scene];
}

- (BOOL)shouldAutorotate {
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return UIInterfaceOrientationMaskAllButUpsideDown;
	}
	else {
		return UIInterfaceOrientationMaskAll;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end
