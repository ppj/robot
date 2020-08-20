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

  ### Cell
    - with the following attributes
      - x coordinate  
      - y coordinate
      - Robot when it is occupied
    - can perform the following actions
      - tell whether it is empty or not

## Robot
  - with the following attributes
    - name
    - facing direction (once placed on a Board)
    - Cell (once it is placed on a Board)
  - can perform the following actions
    - occupy a Cell on a Board (optional until placed)
    - turn 90° given the side to turn (within a Cell)
    - move one Cell on its Board in the direction it is facing

## Commander
  - with the following attributes
    - Board
  - can do the following
    - place a Robot with the given name & facing direction on the Board given the x & y (includes teleporting it)
    - tell a Robot with a given name to turn left or right
    - tell a Robot to move one step
