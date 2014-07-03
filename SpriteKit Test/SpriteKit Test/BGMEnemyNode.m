//
//  BGMEnemyNode.m
//  SpriteKit Test
//
//  Created by 馬 岩 on 14-7-2.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMEnemyNode.h"
#import "BGMPhysicsCategories.h"
#import "BGMGeometry.h"

@implementation BGMEnemyNode

- (instancetype)init
{
    if (self = [super init])
	{
        self.name = [NSString stringWithFormat:@"Enemy %p", self];
        [self initNodeGraph];
		[self initPhysicsBody];
    }
    return self;
}

- (void)initNodeGraph
{
    SKLabelNode *topRow = [SKLabelNode
                           labelNodeWithFontNamed:@"Courier-Bold"];
    topRow.fontColor = [SKColor brownColor];
    topRow.fontSize = 20;
    topRow.text = @"x x";
    topRow.position = CGPointMake(0, 15);
    [self addChild:topRow];
	
    SKLabelNode *middleRow = [SKLabelNode
                              labelNodeWithFontNamed:@"Courier-Bold"];
    middleRow.fontColor = [SKColor brownColor];
    middleRow.fontSize = 20;
    middleRow.text = @"x";
    [self addChild:middleRow];
	
    SKLabelNode *bottomRow = [SKLabelNode
                              labelNodeWithFontNamed:@"Courier-Bold"];
    bottomRow.fontColor = [SKColor brownColor];
    bottomRow.fontSize = 20;
    bottomRow.text = @"x x";
    bottomRow.position = CGPointMake(0, -15);
    [self addChild:bottomRow];
}

- (void)initPhysicsBody {
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:
                           CGSizeMake(40, 40)];
    body.affectedByGravity = NO;
    body.categoryBitMask = EnemyCategory;
    body.contactTestBitMask = PlayerCategory|EnemyCategory;
    body.mass = 0.2;
    body.angularDamping = 0.0f;
    body.linearDamping = 0.0f;
    self.physicsBody = body;
}

@end
