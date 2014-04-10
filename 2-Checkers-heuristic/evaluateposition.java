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
	
	
	
	static private enum GamePart
	{
	  BEGINNING,
	  MIDGAME,
	  END_LOSING,
	  END_WINNING
	}

  static private boolean YELLOW = true;
  static private boolean RED = false;
  static private int KING = 1;
  
  static private int piece_val = 10;
  static private int king_val = 19;

	
  static int rate(int ratingYellow, int ratingRed) //int ratingYellow, int ratingRed)
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
  }


  static int bestEvaluateStrategy(int[][] yellowPieces, int yellowCount, int[][] redPieces, int redCount)
  {
    int totalCount = yellowCount + redCount;
    
    GamePart part;
    //if (totalCount >= 16) part = BEGINNING;
    //else if (totalCount >= 8) part = MIDGAME;
    //else if (totalCount 
    
    int ratingYellow = evaluateSimpleWeights(yellowPieces, yellowCount);
    int ratingRed = evaluateSimpleWeights(redPieces, redCount);

    return rate(ratingYellow, ratingRed);
  }


	static int evaluateSimpleWeights(int[][] pieces, int count)
	{
		int rating = 0;
		
		for (int i = 0; i < count; ++i)
		{
		  if (pieces[i][2] == KING) rating += king_val;
		  else rating += piece_val;
		}

		return rating;
  }
  
  static int rotateCoordinates(int n, int size)
  {
    return size - 1 - n;
  }

	
	static public int evaluatePosition(AIBoard board) // This method is required and it is the major heuristic method - type your code here
	{
		int size = board.getSize();
		
    int yellowPieces[][] = new int [size*size][3]; // (i, j, king?)
    int redPieces[][] =    new int [size*size][3]; // (i, j, king?)
    
    int yellowCount = 0;
    int redCount = 0;
		
		for (int i = 0; i < size; i++)
			for (int j = (i + 1) % 2; j < size; j += 2)
				if (!board._board[i][j].empty) // field is not empty
				{
				  if (board._board[i][j].white) // this is upper, yellow piece
					{
					  yellowCount += 1;
					  yellowPieces[yellowCount][0] = rotateCoordinates(i, size);
					  yellowPieces[yellowCount][1] = rotateCoordinates(j, size);
					  yellowPieces[yellowCount][2] = board._board[i][j].king ? 1 : 0;
					  ++yellowCount;
					}
					else
					{	
					  redCount += 1;
					  redPieces[redCount][0] = i;
					  redPieces[redCount][1] = j;
					  redPieces[redCount][2] = board._board[i][j].king ? 1 : 0;
					  ++redCount;
					}
		}
		
		return bestEvaluateStrategy(yellowPieces, yellowCount, redPieces, redCount);
	}
}

