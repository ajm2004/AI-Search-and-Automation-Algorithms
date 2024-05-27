# -*- coding: utf-8 -*-
"""
Examples of using the provided search code.
Please see the Java source files for full documentation.
"""

# NAME: AJAY MENON
# STUDENT ID: H00418802
# DATE: 25/10/2023

# All edits made in example.py ONLY
# NO edits were made in hwu_search.py

import hwu_search

class BreadthFirstSearchOrder(hwu_search.SearchOrder):
    def addToFringe(self, frontier, parent, children):
        for child in children:
            frontier.append(hwu_search.FringeNode(child.node, parent, child.cost))

class DepthFirstSearchOrder(hwu_search.SearchOrder):
    def addToFringe(self, frontier, parent, children):
        for child in children:
            frontier.insert(0, hwu_search.FringeNode(child.node, parent, child.cost))

# We implement A* search by extending the SearchOrder class
class AStarSearchOrder(hwu_search.SearchOrder):
     def addToFringe(self, frontier, parent, children):
        for child in children:
            child_g_value = parent.gValue + child.cost
            f_value = child_g_value + child.node.value.getHeuristic()
            fringe_node = hwu_search.FringeNode(child.node, parent, child.cost)
            ind=0
            while ind<len(frontier) and f_value>frontier[ind].getFValue():
                ind+=1
            frontier.insert(ind,fringe_node)

# This class represents a state in the grid
class GridState(hwu_search.State):
    def __init__(self,value,x,y,goal_x,goal_y, goal=False):
        self.x = x
        self.y = y
        self.goal_x = goal_x
        self.goal_y = goal_y 
        self.value = value
        self.goal = goal 
    
    # This returns true if the state is a goal state
    def isGoal(self):
        return (self.x == self.goal_x) and (self.y == self.goal_y) 
    
    # This returns the heuristic value of the state
    def getHeuristic(self):
        return abs(self.x - self.goal_x) + abs(self.y - self.goal_y)
    
    def __str__(self):
        return "IntegerState [val = "+ str(self.value)+" x = " + str(self.x) +", y = " + str(self.y) + ", goal=" + str(self.goal) + "]"

def addChild(value, goal, parent):
    child = hwu_search.Node(GridState(value, goal))
    parent.addChild(child, 1)
    return child


# We will be hrd coding the grid.

###     GRID-1
#
# S   H1  W1  W2  W3  W4
# W5  H2  B1  W6  H3  W7
# W8  W9  H4  B2  H5  W10
# W11 W12 W13 B3  G   W14

# Adding Nodes
AS = hwu_search.Node(GridState('S',0,0,4,3))
AH1 = hwu_search.Node(GridState('H',1,0,4,3))
AW1 = hwu_search.Node(GridState('W',2,0,4,3))
AW2 = hwu_search.Node(GridState('W',3,0,4,3))
AW3 = hwu_search.Node(GridState('W',4,0,4,3))
AW4 = hwu_search.Node(GridState('W',5,0,4,3))

AW5 = hwu_search.Node(GridState('W',0,1,4,3))
AH2 = hwu_search.Node(GridState('H',1,1,4,3))
AB1 = hwu_search.Node(GridState('B',2,1,4,3))
AW6 = hwu_search.Node(GridState('W',3,1,4,3))
AH3 = hwu_search.Node(GridState('H',4,1,4,3))
AW7 = hwu_search.Node(GridState('W',5,1,4,3))

AW8 = hwu_search.Node(GridState('W',0,2,4,3))
AW9 = hwu_search.Node(GridState('W',1,2,4,3))
AH4 = hwu_search.Node(GridState('H',2,2,4,3))
AB2 = hwu_search.Node(GridState('B',3,2,4,3))
AH5 = hwu_search.Node(GridState('H',4,2,4,3))
AW10 = hwu_search.Node(GridState('W',5,2,4,3))

AW11 = hwu_search.Node(GridState('W',0,3,4,3))
AW12 = hwu_search.Node(GridState('W',1,3,4,3))
AW13 = hwu_search.Node(GridState('W',2,3,4,3))
AB3 = hwu_search.Node(GridState('B',3,3,4,3))
AG = hwu_search.Node(GridState('G',4,3,4,3,True))
AW14 = hwu_search.Node(GridState('W',5,3,4,3))


# Connecting Nodes
#1
AS.addChild(AH1, 3)
AS.addChild(AW5, 1)

AH1.addChild(AS, 1)
AH1.addChild(AW1, 1)
AH1.addChild(AH2, 3)

AW1.addChild(AW2, 1)
AW1.addChild(AB1, float('inf'))
AW1.addChild(AH1, 3)

AW2.addChild(AW1, 1)
AW2.addChild(AW3, 1)
AW2.addChild(AW6, 1)

AW3.addChild(AW2, 1)
AW3.addChild(AW4, 1)
AW3.addChild(AH3, 3)

AW4.addChild(AW3, 1)
AW4.addChild(AW7, 1)

#2
AW5.addChild(AS, 1)
AW5.addChild(AH2, 3)
AW5.addChild(AW8, 1)

AH2.addChild(AW5, 1)
AH2.addChild(AB1, float('inf'))
AH2.addChild(AW9, 1)
AH2.addChild(AH1, 3)

AW6.addChild(AB1, float('inf'))
AW6.addChild(AW2, 1)
AW6.addChild(AH3, 3)
AW6.addChild(AB2, float('inf'))

AH3.addChild(AW6, 1)
AH3.addChild(AW3, 1)
AH3.addChild(AW7, 1)
AH3.addChild(AH5, 3)

AW7.addChild(AW4, 1)
AW7.addChild(AH3, 3)
AW7.addChild(AW10, 1)

#3
AW8.addChild(AW5, 1)
AW8.addChild(AW11, 1)
AW8.addChild(AW9, 1)

AW9.addChild(AW8, 1)
AW9.addChild(AH4, 3)
AW9.addChild(AH2, 3)
AW9.addChild(AW12, 1)

AH4.addChild(AW9, 1)
AH4.addChild(AB2, float('inf'))
AH4.addChild(AW13, 1)
AH4.addChild(AB1, float('inf'))

AH5.addChild(AB2, float('inf'))
AH5.addChild(AH3, 3)
AH5.addChild(AG, 1)
AH5.addChild(AW10, 1)

AW10.addChild(AH5, 3)
AW10.addChild(AW14, 1)
AW10.addChild(AW7, 1)


#4
AW11.addChild(AW8, 1)
AW11.addChild(AW12, 1)

AW12.addChild(AW9, 1)
AW12.addChild(AW11, 1)
AW12.addChild(AW13, 1)

AW13.addChild(AW12, 1)
AW13.addChild(AH4, 3)
AW13.addChild(AB3, float('inf'))    

AG.addChild(AH5, 3)
AG.addChild(AB3, float('inf'))
AG.addChild(AW14, 1)

AW14.addChild(AW10, 1)
AW14.addChild(AG, 1)

ord = BreadthFirstSearchOrder()
order = AStarSearchOrder()
problem = hwu_search.SearchProblem(order)
#problem = 
problem.doSearch(AS)

# Output:
# Found goal node: Node [value=IntegerState [val = G x = 4, y = 3, goal=True]]
# Cost: 11
# Nodes expanded: 19
# Path to root:
# - node:IntegerState [val = G x = 4, y = 3, goal=True]
# - node:IntegerState [val = W x = 5, y = 3, goal=False]
# - node:IntegerState [val = W x = 5, y = 2, goal=False]
# - node:IntegerState [val = W x = 5, y = 1, goal=False]
# - node:IntegerState [val = W x = 5, y = 0, goal=False]
# - node:IntegerState [val = W x = 4, y = 0, goal=False]
# - node:IntegerState [val = W x = 3, y = 0, goal=False]
# - node:IntegerState [val = W x = 2, y = 0, goal=False]
# - node:IntegerState [val = H x = 1, y = 0, goal=False]
# - node:IntegerState [val = S x = 0, y = 0, goal=False]


###     GRID-2
#
# S   W1  W2  W3  W4
# H1  B1  B2  B3  H2
# W5  W6  B4  W7  W8
# B5  W9  H3  W10 H4
# W11 W12 W13 W14 G 

# Adding Nodes
S = hwu_search.Node(GridState('S',0,0,4,4))
W1 = hwu_search.Node(GridState('W',1,0,4,4))
W2 = hwu_search.Node(GridState('W',2,0,4,4))
W3 = hwu_search.Node(GridState('W',3,0,4,4))
W4 = hwu_search.Node(GridState('W',4,0,4,4))

H1 = hwu_search.Node(GridState('H',0,1,4,4)) 
B1 = hwu_search.Node(GridState('B',1,1,4,4))
B2 = hwu_search.Node(GridState('B',2,1,4,4))
B3 = hwu_search.Node(GridState('B',3,1,4,4))
H2 = hwu_search.Node(GridState('H',4,1,4,4))

W5 = hwu_search.Node(GridState('W',0,2,4,4))
W6 = hwu_search.Node(GridState('W',1,2,4,4))
B4 = hwu_search.Node(GridState('B',2,2,4,4))
W7 = hwu_search.Node(GridState('W',3,2,4,4))
W8 = hwu_search.Node(GridState('W',4,2,4,4))

B5 = hwu_search.Node(GridState('B',0,3,4,4))
W9 = hwu_search.Node(GridState('W',1,3,4,4))
H3 = hwu_search.Node(GridState('H',2,3,4,4))
W10 = hwu_search.Node(GridState('W',3,3,4,4))
H4 = hwu_search.Node(GridState('H',4,3,4,4))

W11 = hwu_search.Node(GridState('W',0,4,4,4))
W12 = hwu_search.Node(GridState('W',1,4,4,4))
W13 = hwu_search.Node(GridState('W',2,4,4,4))
W14 = hwu_search.Node(GridState('W',3,4,4,4))
G = hwu_search.Node(GridState('G',4,4,4,4,True))


# Connecting Nodes
#1
S.addChild(W1, 1)
S.addChild(H1, 3)

W1.addChild(S, 1)
W1.addChild(W2, 1)
W1.addChild(B1, float('inf'))

W2.addChild(W1, 1)
W2.addChild(W3, 1)
W2.addChild(B2, float('inf'))

W3.addChild(W2, 1)
W3.addChild(W4, 1)
W3.addChild(B3, float('inf'))

W4.addChild(W3, 1)
W4.addChild(H2, 3)

#2
H1.addChild(S, 1)
H1.addChild(B1, float('inf'))
H1.addChild(W5, 1)

H2.addChild(B3, float('inf'))
H2.addChild(W4, 1)
H2.addChild(W8, 1)

# #3
W5.addChild(H1, 3)
W5.addChild(W6, 1)
W5.addChild(B5, float('inf'))

W6.addChild(W5, 1)
W6.addChild(B1, float('inf'))
W6.addChild(B4, float('inf'))
W6.addChild(W9, 1)

W7.addChild(B4, float('inf'))
W7.addChild(B3, float('inf'))
W7.addChild(W10, 1)
W7.addChild(W8, 1)

W8.addChild(W7, 1)
W8.addChild(H2, 3)
W8.addChild(H4, 3)

#4
W9.addChild(B5, float('inf'))
W9.addChild(W6, 1)
W9.addChild(W12, 1)
W9.addChild(H3, 3)

H3.addChild(W9, 1)
H3.addChild(B4, float('inf'))
H3.addChild(W13, 1)
H3.addChild(W10, 1)

W10.addChild(H3, 3)
W10.addChild(W7, 1)
W10.addChild(H4, 3)
W10.addChild(W14, 1)

H4.addChild(W10, 1)
H4.addChild(W8, 1)
H4.addChild(G, 1)

#5
W11.addChild(B5, float('inf'))
W11.addChild(W12, 1)

W12.addChild(W11, 1)
W12.addChild(W9, 1)
W12.addChild(W13, 1)

W13.addChild(W12, 1)
W13.addChild(H3, 3)
W13.addChild(W14, 1)

W14.addChild(W13, 1)
W14.addChild(W10, 1)
W14.addChild(G, 1)

G.addChild(W14, 1)
G.addChild(H4, 3)

order = AStarSearchOrder()
problem = hwu_search.SearchProblem(order)
problem.doSearch(S)

# Output:
# Found goal node: Node [value=IntegerState [val = G x = 4, y = 4, goal=True]]
# Cost: 10
# Nodes expanded: 14
# Path to root:
# - node:IntegerState [val = G x = 4, y = 4, goal=True]
# - node:IntegerState [val = W x = 3, y = 4, goal=False]
# - node:IntegerState [val = W x = 2, y = 4, goal=False]
# - node:IntegerState [val = W x = 1, y = 4, goal=False]
# - node:IntegerState [val = W x = 1, y = 3, goal=False]
# - node:IntegerState [val = W x = 1, y = 2, goal=False]
# - node:IntegerState [val = W x = 0, y = 2, goal=False]
# - node:IntegerState [val = H x = 0, y = 1, goal=False]
# - node:IntegerState [val = S x = 0, y = 0, goal=False]