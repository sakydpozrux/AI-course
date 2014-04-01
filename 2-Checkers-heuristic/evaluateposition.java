import java.util.List;

package checkers; // This package is required - don't remove it


public class Checker
{
  private int _x;
  private int _y;
  private boolean _isKing;
  
  public Checker(int x, int y, boolean isKing)
  {
    _x = x;
    _y = y;
    _isKing = isKing;
  }
  
  static public int getX() { return _x; }
  static public int getY() { return _y; }
}

public class EvaluatePosition // This class is required - don't remove it
{
	static private final int WIN=Integer.MAX_VALUE/2;
	static private final int LOSE=Integer.MIN_VALUE/2;
	static private boolean _color; // This field is required - don't remove it
	
	private AIBoard board;
	private List<Checker> friendlyCheckers = new LinkedList<Checker>();
	private List<Checker> enemyCheckers = new LinkedList<Checker>();
	
	static public void changeColor(boolean color) // This method is required - don't remove it
	{
		_color=color;
	}
	static public boolean getColor() // This method is required - don't remove it
	{
		return _color;
	}

  static private int evalPos_simpleCheckersCount() // Modified example method
  { // TODO 1 - FIX KINGS COUNTING IN evaluatePosition(AIBoard board). Maybe use list of references to checkers?
    return myRating-opponentsRating;
  }
  static private int evalPos_weightedCheckersCount()
  {
    // TODO
  }
  static private int evalPos_threeAreas()
  {
    // TODO
  }
  
  
  static private int evalPos_bestMethodAIBoard board, int myRating, int opponentsRating)
  {
    // TODO
    // In function below you should use something like "switch evalPos_chooseMethod(board) {...} "  
  }
  
	static public int evaluatePosition(AIBoard board) // This method is required and it is the major heuristic method - type your code here
	{
   
	  int myRating = 0;
		int opponentsRating = 0;
		int size = board.getSize();
		
		for (int i = 0; i < size; i++)
			for (int j = (i + 1) % 2; j < size; j += 2)
				if (!board._board[i][j].empty) // field is not empty
					if (board._board[i][j].white == getColor()) // this is my piece
					{
						if (board._board[i][j].king) myRating += 5; // this is my king
						else myRating += 1; // this is my piece
					}
					else
					{
						if (board._board[i][j].king) opponentsRating += 5; // This is opponent's king
						else opponentsRating += 1;
					}
		
		if (myRating == 0) return LOSE; 
		else if (opponentsRating == 0) return WIN;
		else return evalPos_bestMethod(board, myRating, opponentsRating);
	}
}

