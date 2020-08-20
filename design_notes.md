## Board
  - with the following attributes
    - X bound
    - Y bound
    - Cells
  - can do the following
    - tell whether a Cell is available
      - within boundary, AND
      - empty
    - put a given Robot in its empty Cell
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
    - facing direction
  - can perform the following actions
    - turn 90° given the side to turn

## Commander
  - with the following attributes
    - Board
  - can do the following
    - place a Robot with the given name & facing direction on the Board given the x & y (includes teleporting it)
    - tell a Robot with a given name to turn left or right
    - move a Robot a Cell in the direction it is facing
