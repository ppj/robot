## Board
  - with the following attributes
    - X bound
    - Y bound
    - Cells
  - can do the following
    - tell whether a Cell is available
      - within boundary, AND
      - empty
    - allocate a given Robot to an available Cell
    - tell a Cell to vacate itself

## Cell
  - with the following attributes
    - Board
    - x coordinate  
    - y coordinate
    - Robot occupying it (optional)
  - can perform the following actions
    - tell whether it is empty or occupied

## Robot
  - with the following attributes
    - name
    - facing direction (once placed on a Board)
    - Cell (once it is placed on a Board)
  - can perform the following actions
    - occupy a Cell on a Board (optional until placed)
    - turn given the side (within a Cell)
    - move (to an adjacent Cell on its Board)

## Commander
  - with the following attributes
    - Board
  - can do the following
    - place a Robot with the given name & facing direction on the Board given the x & y (includes teleporting it)
