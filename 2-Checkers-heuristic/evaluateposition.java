package checkers; // This package is required - don't remove it

import java.util.*;

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

	
  /*static int rate(int ratingYellow, int ratingRed)
  {
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
		
		if (myRating == 0) return LOSE; 
		else if (opponentsRating == 0) return WIN; 
		else return myRating-opponentsRating;
  }*/


	/*static int simpleWeights(AIboard board)
	{
		int ratingYellow = 0; //upper
		int ratingRed = 0; //lower
		
		for (int i = 0; i < size; i++)
		{
			for (int j = (i + 1) % 2; j < size; j += 2)
			{
				if (!board._board[i][j].empty) // field is not empty
				{
				  if (board._board[i][j].white) // this is upper, yellow piece
					{
					  if (board._board[i][j].king) ratingYellow += 25; // this is upper, yellow king
					  else ratingYellow += 10; // this is upper, yellow piece
					}
					else
					{	
					  if (board._board[i][j].king) ratingRed += 25; // This is opponent's king
					  else ratingRed += 10;
					}
				}
			}
		}
		
		return rate(ratingYellow, ratingRed);
  }	*/

	
	static public int evaluatePosition(AIBoard board) // This method is required and it is the major heuristic method - type your code here
	{
		int size = board.getSize();
		
    int yellowPieces[][] = new int [size*size][3]; // (i, j, king?)
    int redPieces[][] = new int [size*size][3];
    
    int yellowCount = 0;
    int redCount = 0;
		
		for (int i = 0; i < size; i++)
		{
			for (int j = (i + 1) % 2; j < size; j += 2)
			{
				if (!board._board[i][j].empty) // field is not empty
				{
				  if (board._board[i][j].white) // this is upper, yellow piece
					{
					  yellowCount += 1;
					  yellowPieces[yellowCount][0] = i;
					  yellowPieces[yellowCount][1] = j;
					  yellowPieces[yellowCount][3] = board._board[i][j].king ? 1 : 0;
					  ++yellowCount;
					}
					else
					{	
					  redCount += 1;
					  redPieces[yellowCount][0] = i;
					  redPieces[yellowCount][1] = j;
					  redPieces[yellowCount][3] = board._board[i][j].king ? 1 : 0;
					  ++redCount;
					}
				}
			}
		}
		
		int sumCount = redCount + redCount;
		
		if (sumCount >= 16) return 1;//simpleWeights(board);
		else return 1;//simpleWeights(board);
	}
}

