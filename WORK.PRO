domains
  elem = integer
  node_d = node(node_d, node_d, elem); null
predicates
  print_tree(node_d, elem)
  print_spaces(elem)
  build_tree(node_d)
  count_neighbors(node_d, elem)
  count_neighbors_helper(node_d, node_d, elem)
clauses
  % Задаём бинарное дерево
  build_tree(Tree) :-
    Tree = node(node(node(null, null, 5), node(null, null, 4), 2), node(node(null, null, 7), node(null, null, 6), 3), 1).

  % Вывод бинарного дерева
  print_tree(null, _):-!.
  print_tree(node(Left, Right, TopValue), Depth):-
    SubtreesDepth = Depth + 1,
    print_tree(Left, SubtreesDepth),
    print_spaces(Depth), write(TopValue), write("<"), nl,
    print_tree(Right, SubtreesDepth).
  
  % Вывод пробелов для красивого вывода
  print_spaces(SpaceNumber):-
    SpaceNumber <= 0, !;
    write("\t"),
    TailSpaceNumber = SpaceNumber - 1,
    print_spaces(TailSpaceNumber).

  % Подсчет соседних элементов в двоичном дереве
  % Дошли до конца дерева
  count_neighbors(null, 0).
  count_neighbors(node(Left, Right, _), Count) :-
    count_neighbors_helper(Left, Right, BranchCount),
    count_neighbors(Left, LeftCountLeft),
    count_neighbors(Right, RightCountRight),
    Count = BranchCount + LeftCountLeft + RightCountRight.

  % Подсчет соседних элементов для левого и правого поддеревьев: 
  % Поддерево - лист
  count_neighbors_helper(null, null, 0).

  % Поддерево имеет только левого потомка
  count_neighbors_helper(node(_, _, _), null, LeftCount) :-
    LeftCount = 1.

  % Поддерево имеет только правого потомка
  count_neighbors_helper(null, node(_, _, _), RightCount) :-
    RightCount = 1.

  % Поддерево имеет обоих потомков
  count_neighbors_helper(node(_, _, _), node(_, _, _), BranchCount) :-
    BranchCount = 2.
    
goal
  clearwindow,
  build_tree(Tree),
  print_tree(Tree, 3), nl,
  count_neighbors(Tree, BranchCount),
  write("Branch count -> ", BranchCount).