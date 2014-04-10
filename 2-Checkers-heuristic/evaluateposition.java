package checkers; // This package is required - don't remove it
public class EvaluatePosition // This class is required - don't remove it
{
	static private final int WIN=Integer.MAX_VALUE/2;
	static private final int LOSE=Integer.MIN_VALUE/2;
	static private boolean _color; // This field is required - don't remove it
	static public void changeColor(boolean color) // This method is required - don't remove it
	{
		_color=color;
	}
	static public boolean getColor() // This method is required - don't remove it
	{
		return _color;
	}
	
	
	
	

  static private boolean YELLOW = true;
  static private boolean RED = false;

	
	
	

	
	
	static public int evaluatePosition(AIBoard board) // This method is required and it is the major heuristic method - type your code here
	{
		int ratingYellow = 0; //upper
		int ratingRed = 0; //lower
		
		int size = board.getSize();
		
		for (int i = 0; i < size; i++)
		{
			for (int j = (i + 1) % 2; j < size; j += 2)
			{
				if (!board._board[i][j].empty) // field is not empty
				{
				  if (board._board[i][j].white) // this is upper, yellow piece
					{
					  if (board._board[i][j].king) ratingYellow += 5; // this is upper, yellow king
					  else ratingYellow += 1; // this is upper, yellow piece
					}
					else
					{	
					  if (board._board[i][j].king) ratingRed += 5; // This is opponent's king
					  else ratingRed += 1;
					}
				}
			}
		}
		
		
		int myRating, opponentsRating;
		if (getColor())
		{
		  myRating = ratingYellow;
		  opponentsRating = ratingRed;
		}
		else
		{
		  myRating = ratingRed;
		  opponentsRating = ratingYellow;
		}
		
		
		
		
		
		
		
		if (myRating==0) return LOSE; 
		else if (opponentsRating==0) return WIN; 
		
		
		
		
		
		else return myRating-opponentsRating;
	}
}

