#!/bin/bash

BOARD=(" " " " " " " " " " " " " " " " " ")
GAME_PROGRESS=1
PLAYER_ONE="X"
PLAYER_TWO="O"
PLAY=$PLAYER_ONE

function welcome {
  echo "Tic-Tac-Toe Game"
  echo "Choose square from 0 to 8 (top left -> bottom right)"
}

function print_board {
    clear
    echo " ${BOARD[0]} | ${BOARD[1]} | ${BOARD[2]} "
    echo "-----------"
    echo " ${BOARD[3]} | ${BOARD[4]} | ${BOARD[5]} "
    echo "-----------"
    echo " ${BOARD[6]} | ${BOARD[7]} | ${BOARD[8]} "
} 

function change_player {
  if [ $PLAY == $PLAYER_ONE ];
  then
    PLAY=$PLAYER_TWO
  else
    PLAY=$PLAYER_ONE
  fi
}


function player_pick {
  echo -n "Player ${PLAY} pick square: "
  read CHOOSE

  if [[ ! $CHOOSE =~ ^[0-8]$ ]] || [[ ${BOARD[CHOOSE]} == 'X' ]] || [[ ${BOARD[CHOOSE]} == 'O' ]];
  then 
    echo "Not valid input"
    player_pick
  else
    BOARD[CHOOSE]=$PLAY
  fi
}

function check_for_win {
  for ELE in {0..2}
  do
    ROW=ELE*3
    if [[ ${BOARD[$ROW]} == $PLAY ]] && [[ ${BOARD[$ROW+1]} == $PLAY ]] && [[ ${BOARD[$ROW+2]} == $PLAY ]];
    then
      echo "Wygrał ${PLAY}"
      GAME_PROGRESS=0
    fi
  
    if [[ ${BOARD[$ROW]} == $PLAY ]] && [[ ${BOARD[$ROW+3]} == $PLAY ]] && [[ ${BOARD[$ROW+6]} == $PLAY ]];
    then
      echo "Wygrał ${PLAY}"
      GAME_PROGRESS=0
    fi
  done

  if [[ ${BOARD[2]} == $PLAY ]] && [[ ${BOARD[4]} == $PLAY ]] && [[ ${BOARD[6]} == $PLAY ]];
  then
    echo "Wygrał ${PLAY}"
    GAME_PROGRESS=0
  fi
  if [[ ${BOARD[0]} == $PLAY ]] && [[ ${BOARD[4]} == $PLAY ]] && [[ ${BOARD[8]} == $PLAY ]];
  then
    echo "Wygrał ${PLAY}"
    GAME_PROGRESS=0
  fi

  if [[ $GAME_PROGRESS -eq 1 ]];
  then
    change_player
  fi
}

function check_for_draw {
  local COUNTER=0
  for i in "${BOARD[@]}";
  do
    if [[ $i == " " ]];
    then
      COUNTER=$((COUNTER + 1))
    fi
  done
  if [[ $COUNTER -eq 0 ]] && [[ $GAME_PROGRESS -eq 1 ]];
  then
    GAME_PROGRESS=0
    echo "It's a draw!"
  fi
}


welcome
sleep 5
print_board
while [ $GAME_PROGRESS -eq 1 ];
do
  player_pick
  print_board
  check_for_win
  check_for_draw
done