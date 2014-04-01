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
  
  static public int     getX()   { return _x; }
  static public int     getY()   { return _y; }
  static public boolean ifKing() { return _isKing; }
}

public class EvaluatePosition // This class is required - don't remove it
{
	static private final int WIN  = Integer.MAX_VALUE / 2;
	static private final int LOSE = Integer.MIN_VALUE / 2;
	static private boolean _color; // This field is required - don't remove it
	
	static private final int  KING_VAL = 5;
	static private final int PIECE_VAL = 1;
	
	private AIBoard _board;
	private List<Checker> _friendlyCheckers = new LinkedList<Checker>();
	private List<Checker> _opponentCheckers = new LinkedList<Checker>();
	
	static private int totalFriendly()
	{
	  return _friendlyCheckers.size();
	}
	
	static private int totalOpponent()
	{
	  return _opponentCheckers.size();
	}
	
	static private int totalBoth()
	{
	  return totalFriendly() + totalOpponent();
	}
	
	static public void changeColor(boolean color) // This method is required - don't remove it
	{
		_color=color;
	}
	static public boolean getColor() // This method is required - don't remove it
	{
		return _color;
	}

  static private int evalPos_simpleCheckersCount()
  {
    return totalFriendly() - totalOpponent();
  }
  static private int evalPos_weightedCheckersCount()
  {
    // TODO
  }
  static private int evalPos_threeAreas()
  {
    // TODO
  }
  
  
  static private int evalPos_bestMethod()
  {
    // TODO
    // In function below you should use something like "switch evalPos_chooseMethod(board) {...} "  
  }
  
	static public int evaluatePosition(AIBoard board) // This method is required and it is the major heuristic method - type your code here
	{
	  _board = board;
		int size = board.getSize();
		
		for (int i = 0; i < size; i++)
			for (int j = (i + 1) % 2; j < size; j += 2)
				if (!board._board[i][j].empty) // field is not empty
					if (board._board[i][j].white == getColor()) // this is my piece
					  _friendlyCheckers.add(new Checker(i, j, board._board[i][j].king));
					else // this is enemy piece
						_opponentCheckers.add(new Checker(i, j, board._board[i][j].king));
		
		if (myRating == 0) return LOSE; 
		else if (opponentsRating == 0) return WIN;
		else return evalPos_bestMethod(board, myRating, opponentsRating);
	}
}

