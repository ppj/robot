## Parser
  - with the following attributes
    - input command
  - can do the following
    - determine the action the Commander should take

## Commander
  - with the following attributes
    - Board
  - can do the following
    - place a Robot on the board given a name, facing direction, x & y
    - move a Robot by one Cell in the direction it is facing
    - tell a Robot with a given name to turn left or right
    - ask the board for a Robots details (x, y, facing) given its name

## Board
  - with the following attributes
    - X bound
    - Y bound
    - Cells
  - can do the following
    - tell whether a Cell is available
      - within boundary, AND
      - empty
    - put a given Robot in its available Cell
    - reports the details given a robot name
    - returns a robot given a name

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
    - sets a provided facing direction
    - turn 90° given the side to turn
