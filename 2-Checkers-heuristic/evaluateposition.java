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
	
	static int rotateCoordinates(int n, int size)
  {
    return size - 1 - n;
  }
	
	

	static private final int BEGINNING = 111;
	static private final int MIDGAME = 222;
	static private final int END_YELLOW_WINNING = 333;
	static private final int END_RED_WINNING = 444;

  static private boolean YELLOW = true;
  static private boolean RED = false;
  static private int KING = 1;
  
  static private int piece_val = 10;
  static private int king_val = 19;
  static private int guard_bonus = 5;
  
  static private int zone_not_border_bonus = 2;
  static private int zone_center_bonus = 1; // note that it's inside zone_not_border, so in fact it's always +3
  static private int zone_strategic_field_bonus = 2;
  
  static private int lower_center_coordinate;
  static private int upper_center_coordinate;

	
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


	static int evaluateSimpleWeights(int[][] pieces, int count)
	{
		int rating = 0;
		
		for (int i = 0; i < count; ++i)
		{
		  if (pieces[i][2] == KING) rating += king_val;
		  rating += piece_val;
		}

		return rating;
  }
  
  static int evaluateMidGame(int[][] pieces, int count)
  { //TODO
		int rating = 0;
		
		int x;
		int y;
		for (int i = 0; i < count; ++i)
		{
		  x = pieces[i][0];
		  y = pieces[i][1];
		  if (x)
		  
		  if (pieces[i][2] == KING) rating += king_val;
		  rating += piece_val;
		}

		return rating;
  }
  
  static int evaluateWinning(int[][] pieces, int count)
  { //TODO
		int rating = 0;
		
		for (int i = 0; i < count; ++i)
		{
		  if (pieces[i][2] == KING) rating += king_val;
		  rating += piece_val;
		}

		return rating;
  }
  
  static int evaluateLosing(int[][] pieces, int count)
  { //TODO
		int rating = 0;
		
		for (int i = 0; i < count; ++i)
		{
		  if (pieces[i][2] == KING) rating += king_val;
		  rating += piece_val;
		}

		return rating;
  }


  static int bestEvaluateStrategy(int[][] yellowPieces, int yellowCount, int[][] redPieces, int redCount)
  {
    int totalCount = yellowCount + redCount;
    
    
    
    int part;
    if (totalCount >= 16)
      part = BEGINNING;
    else if (totalCount >= 8)
      part = MIDGAME;
    else if (yellowCount > redCount)
      part = END_YELLOW_WINNING;
    else if (redCount > yellowCount)
      part = END_RED_WINNING;
    else
      part = MIDGAME; // play as in midgame
      
    int ratingYellow, ratingRed;
      
    switch (part)
    {
      case BEGINNING:
        ratingYellow = evaluateSimpleWeights(yellowPieces, yellowCount);
        ratingRed    = evaluateSimpleWeights(redPieces, redCount);
        break;
      
      case MIDGAME:
        ratingYellow = evaluateMidGame(yellowPieces, yellowCount);
        ratingRed    = evaluateMidGame(redPieces, redCount);
        break;
      
      case END_YELLOW_WINNING:
        ratingYellow = evaluateWinning(yellowPieces, yellowCount);
        ratingRed    = evaluateLosing(redPieces, redCount);
        break;
      
      default: //case END_RED_WINNING:
        ratingYellow = evaluateLosing(yellowPieces, yellowCount);
        ratingRed    = evaluateWinning(redPieces, redCount);
        break;
    }
    
    


    return rate(ratingYellow, ratingRed);
  }




	
	static public int evaluatePosition(AIBoard board) // This method is required and it is the major heuristic method - type your code here
	{
		int size = board.getSize();
		
    int yellowPieces[][] = new int [size*size][3]; // (i, j, king?)
    int redPieces[][] =    new int [size*size][3]; // (i, j, king?)
    
    int yellowCount = 0;
    int redCount = 0;
    
    lower_center_coordinate = 1 * size / 4;
    upper_center_coordinate = 3 * size / 4;
		
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

