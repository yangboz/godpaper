//
//  GP_BinarySearchTree.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Collection.h"
#import "GP_BinaryTreeNode.h"

@interface GP_BinarySearchTree : NSObject <GP_Collection>
{
    /**
     * The root node being referenced.
     */
//    public var root:BinaryTreeNode;
//    
//    private var _compare:Function;
    @public
        GP_BinaryTreeNode *root;
    @private
        id *compare;//TODO:NS dynamic function support.
}
//
//public function BinarySearchTree(compare:Function = null)
-(void)BinarySearchTree:(id *)compare;
//public function insert(obj:*):void
-(void)insert:(id)obj;
//public function find(obj:*):BinaryTreeNode
-(GP_BinaryTreeNode *)find:(id)obj;
//public function remove(node:BinaryTreeNode):void
-(void)remove:(GP_BinaryTreeNode *)node;
//
@end
