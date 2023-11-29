domains
  elem = integer
  node_d = node(node_d, node_d, elem); null
predicates
  print_tree(node_d, elem)
  print_spaces(elem)
  build_tree(node_d)
  count_neighbors(node_d, elem, elem, elem)
  count_neighbors_helper(elem, node_d, elem, elem, elem)
clauses
  % Задаём бинарное дерево
  build_tree(Tree) :-
    Tree = node(node(node(null, null, 4), node(null, null, 4), 2), node(node(null, null, 7), node(null, null, 6), 4), 2).

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
  count_neighbors(null, _, _, 0).
  count_neighbors(node(Left, Right, TopValue), Parent, Child, Count) :-
    count_neighbors_helper(TopValue, Left, Parent, Child, BranchCount1),
    count_neighbors_helper(TopValue, Right, Parent, Child, BranchCount2),
    count_neighbors(Left, Parent, Child, LeftCountLeft),
    count_neighbors(Right, Parent, Child, RightCountRight),
    Count = BranchCount1 + BranchCount2 + LeftCountLeft + RightCountRight.

  % Если мы нашли соседние то возвращаем 1
  count_neighbors_helper(Parent, node(_, _, Child), Parent, Child, 1).

  % Поддерева нет
  count_neighbors_helper(_, null, _, _, 0).

  % Соседи не равны 
  count_neighbors_helper(_, node(_, _, _), _, _, 0).

goal
  clearwindow,
  build_tree(Tree),
  print_tree(Tree, 3), nl,
  write("Input parent -> "), 
  readint(Parent),
  write("Input child -> "), 
  readint(Child),
  count_neighbors(Tree, Parent, Child, NeighborsCount),
  write("Neighbors count -> ", NeighborsCount).
